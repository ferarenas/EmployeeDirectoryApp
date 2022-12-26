import UIKit
import Combine

protocol EmployeeListViewControllerViewModel: ObservableObject {
    associatedtype EmployeeModel: EmployeeSummaryCellViewModel, Hashable
    
    var header: HeaderCellModel { get }
    var employees: [EmployeeModel] { get }
    var isLoading: Bool { get }
    
    func loadEmployees()
}

final class EmployeeListViewController<ViewModel>: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource
where ViewModel: EmployeeListViewControllerViewModel {
    private typealias DataSource = UICollectionViewDiffableDataSource<Section, Item>

    private enum Section: Hashable {
        case header
        case Employees(ViewModel.EmployeeModel)
    }

    private enum Item: Hashable {
        case header(HeaderCellModel)
        case employeeSummary(ViewModel.EmployeeModel)
    }

    private let viewModel: ViewModel
    private var dataSource: DataSource?
    private var cancellables: Set<AnyCancellable> = []
    private var collectionView: UICollectionView = .init()
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
        setupRefresh { [weak self] in
            self?.viewModel.loadEmployees()
        }
        view.addSubview(collectionView)
        
        view.backgroundColor = .red

//        collectionView.delegate = self
//        collectionView.dataSource = self
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
    
// MARK: - DataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return viewModel.employees.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        cell.backgroundColor = (indexPath.section == 0) ? .red : .blue
        return cell
    }
}

