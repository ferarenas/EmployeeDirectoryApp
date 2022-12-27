import UIKit
import Combine

protocol EmployeeListViewControllerViewModel: ObservableObject {
    associatedtype EmployeeModel: EmployeeSummaryCellViewModel, Hashable
    
    var header: HeaderCellModel { get }
    var employees: [EmployeeModel] { get }
    var isLoading: Bool { get }
    
    func loadEmployees()
}

final class EmployeeListViewController<ViewModel>: UIViewController, UICollectionViewDelegate
where ViewModel: EmployeeListViewControllerViewModel {
    private typealias DataSource = UICollectionViewDiffableDataSource<Section, Item>

    private enum Section: Hashable {
        case header
        case employees
    }

    private enum Item: Hashable {
        case header(HeaderCellModel)
        case employeeSummary(ViewModel.EmployeeModel)
    }

    private let viewModel: ViewModel
    private var dataSource: DataSource?
    private var cancellables: Set<AnyCancellable> = []
    private var collectionView: UICollectionView!
    private var onRefresh: (() async -> Void)?
    
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
        setUpDataSource()
        setupLayout()
        updateDataSource()
        
        setupRefresh { [weak self] in
            self?.viewModel.loadEmployees()
        }
    }
    
    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UICollectionViewLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.delegate = self
        view.addSubview(collectionView)
    }
    
// MARK: - Pull to refresh
    func setupRefresh(onRefresh: @escaping () async -> Void) {
        collectionView.alwaysBounceVertical = true
        collectionView.refreshControl = UIRefreshControl()
        collectionView.refreshControl?.backgroundColor = .clear
        collectionView.refreshControl?.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
        self.onRefresh = onRefresh
    }

    @objc
    private func didPullToRefresh(_ sender: UIRefreshControl) {
        Task {
            await onRefresh?()
            sender.endRefreshing()
        }
    }
}
// MARK: - Data Source
private extension EmployeeListViewController {
    func setUpDataSource() {
        typealias CellRegistration = UICollectionView.CellRegistration
        
        let headerCell = CellRegistration(for: HeaderCell.self)
        
        let dataSource = DataSource(collectionView: collectionView) { collectionView, indexPath, item -> UICollectionViewCell? in
            switch item {
            case let .header(item):
                return collectionView.dequeueConfiguredReusableCell(
                    using: headerCell,
                    for: indexPath,
                    item: item
                )
            }
        }
        
        self.dataSource = dataSource
    }
    
    func updateDataSource() {
        guard var snapshot = dataSource?.snapshot() else { return }
        defer { dataSource?.apply(snapshot, animatingDifferences: true) }

        snapshot.deleteAllItems()

        snapshot.appendSections([.header])
        snapshot.appendItems([.header(viewModel.header)])
    }
}


// MARK: - Layout
private extension EmployeeListViewController {
    func setupLayout() {
        let layout = UICollectionViewCompositionalLayout { [weak self] index, _ in
            switch self?.dataSource?.snapshot().sectionIdentifiers[index] {
            case .header:
                return .headerLayout
            case .employees:
                return nil
            case .none:
                return nil
            }
        }
        collectionView.collectionViewLayout = layout
    }
}

private extension NSCollectionLayoutSection {
    static var headerLayout: NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(HeaderCell.estimatedHeight)
        )
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let group = NSCollectionLayoutGroup.vertical(layoutSize: itemSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets.bottom = 20
        section.contentInsetsReference = .layoutMargins
        
        return section
    }
}

