import UIKit
import Combine

protocol EmployeeListViewControllerViewModel {
    associatedtype EmployeeSummaryCellModel: EmployeeSummaryCellViewModel, Hashable
    associatedtype HeaderCellModel: HeaderCellViewModel, Hashable
    
    var header: HeaderCellModel { get }
    var employeesPublisher: AnyPublisher<[EmployeeSummaryCellModel], Never> { get }
    var errorPublisher: AnyPublisher<Error, Never> { get }
    var isLoadingPublisher: AnyPublisher<Bool, Never> { get }
    
    func loadEmployees() async
    func showEmployee(_ employee: EmployeeSummaryCellModel)
}

final class EmployeeListViewController<ViewModel>: UIViewController, UICollectionViewDelegate
where ViewModel: EmployeeListViewControllerViewModel {
    private typealias Strings = L10n.EmployeeList
    private typealias DataSource = UICollectionViewDiffableDataSource<Section, Item>
    private typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Item>

    private enum Section: Hashable {
        case header
        case employees
    }

    private enum Item: Hashable {
        case header(ViewModel.HeaderCellModel)
        case employeeSummary(ViewModel.EmployeeSummaryCellModel)
    }

    private let viewModel: ViewModel
    private lazy var dataSource: DataSource = setUpDataSource()
    private var cancellables: Array<AnyCancellable> = []
    private var collectionView: UICollectionView!
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCollectionView()
        bindToViewModel()
        setUpLayout()
        setUpRefresh()
        
        Task {
            await viewModel.loadEmployees()
        }
    }
    
    func configureCollectionView() {
        collectionView = UICollectionView(
            frame: view.bounds,
            collectionViewLayout: UICollectionViewLayout()
        )
        collectionView.delegate = self
        
        view.addSubview(collectionView)
    }
    
    func bindToViewModel() {
        viewModel
            .employeesPublisher
            .receive(on: DispatchQueue.main)
            .handleEvents(receiveOutput: { [weak self] employees in
                if employees.isEmpty {
                    let label = UILabel()
                    label.text = Strings.emptyListTitle
                    label.textAlignment = .center
                    self?.collectionView.backgroundView = label
                } else {
                    self?.collectionView.backgroundView = nil
                }
            })
            .compactMap{ [weak self] in self?.makeSnapshot(employees: $0) }
            .sink { [weak self] in self?.dataSource.apply($0, animatingDifferences: true) }
            .store(in: &cancellables)
        
        viewModel.errorPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in self?.handleError($0) }
            .store(in: &cancellables)
        
        viewModel.isLoadingPublisher
            .receive(on: DispatchQueue.main)
            .assign(to: \.animating, on: UIActivityIndicatorView(style: .large))
            .store(in: &cancellables)
        
    }
    
    func handleError(_ error: Error) {
        let alert = UIAlertController(
            title: Strings.Alert.title,
            message: error.localizedDescription,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: Strings.Alert.button, style: .default, handler: nil))
        DispatchQueue.main.async { [weak self] in self?.present(alert, animated: true)}
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard case let .employeeSummary(employee) = dataSource.itemIdentifier(for: indexPath) else { return }
        
        viewModel.showEmployee(employee)
    }
    
    // MARK: - Pull to refresh
    func setUpRefresh() {
        collectionView.alwaysBounceVertical = true
        collectionView.refreshControl = UIRefreshControl()
        collectionView.refreshControl?.backgroundColor = .clear
        collectionView.refreshControl?.addTarget(
            self,
            action: #selector(didPullToRefresh),
            for: .valueChanged
        )
    }

    @objc
    private func didPullToRefresh(_ sender: UIRefreshControl) {
        Task {
            await viewModel.loadEmployees()
            
            sender.endRefreshing()
        }
    }
}

// MARK: - Data Source
private extension EmployeeListViewController {
    private func setUpDataSource() -> DataSource {
        typealias CellRegistration = UICollectionView.CellRegistration
        
        let headerCell = CellRegistration<HeaderCell, ViewModel.HeaderCellModel> { cell, _, item in
            cell.configure(with: item)
        }
        
        let employeeCell = CellRegistration<EmployeeSummaryCell, ViewModel.EmployeeSummaryCellModel> {
            cell, _, item in
            cell.configure(with: item)
        }
        
        let dataSource = DataSource(collectionView: collectionView) {
            collectionView, indexPath, item -> UICollectionViewCell? in
            switch item {
            case let .header(item):
                return collectionView.dequeueConfiguredReusableCell(
                    using: headerCell,
                    for: indexPath,
                    item: item
                )
            case let .employeeSummary(item):
                return collectionView.dequeueConfiguredReusableCell(
                    using: employeeCell,
                    for: indexPath,
                    item: item
                )
            }
        }
        return dataSource
    }
    
    private func makeSnapshot(employees: [ViewModel.EmployeeSummaryCellModel]) -> Snapshot {
        var snapshot = Snapshot()

        snapshot.appendSections([.header])
        snapshot.appendItems([.header(viewModel.header)])
        
        snapshot.appendSections([.employees])
        snapshot.appendItems(employees.map(Item.employeeSummary))
        
        return snapshot
    }
}

// MARK: - Layout
private extension EmployeeListViewController {
    func setUpLayout() {
        let layout = UICollectionViewCompositionalLayout { [weak self] index, _ in
            guard let section = self?.dataSource.snapshot().sectionIdentifiers[index]
            else { return nil }
            
            switch section {
            case .header:
                return .defaultLayout(height: HeaderCell.estimatedHeight)
            case .employees:
                return .defaultLayout(height: EmployeeSummaryCell.estimatedHeight)
            }
        }
        collectionView.collectionViewLayout = layout
    }
}

private extension NSCollectionLayoutSection {
    static func defaultLayout(height: Double) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(height)
        )
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let group = NSCollectionLayoutGroup.vertical(layoutSize: itemSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets.bottom = 20
        section.contentInsetsReference = .layoutMargins
        
        return section
    }
    
}
