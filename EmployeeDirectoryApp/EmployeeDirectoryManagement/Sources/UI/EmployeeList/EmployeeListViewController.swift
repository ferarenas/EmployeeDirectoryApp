import UIKit
import Combine

protocol EmployeeListViewControllerViewModel: ObservableObject {
    associatedtype EmployeeModel: EmployeeSummaryCellViewModel, Hashable
    
    var header: HeaderCellModel { get }
    var employees: [EmployeeModel] { get }
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
    private var collectionView: UICollectionView!
//    private var expandedEmployees: Set<ViewModel.Employee> = [] {
//        didSet {
//            updateDataSource()
//        }
//    }
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.delegate = self
        collectionView.dataSource = self
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

