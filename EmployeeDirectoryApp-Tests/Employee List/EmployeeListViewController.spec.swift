import Combine
import Foundation
import Nimble
import SnapshotTesting
import Quick
@testable import EmployeeDirectoryApp

final class EmployeeListViewController_Spec: QuickSpec {
    override func spec() {
        var viewController: EmployeeListViewController<MockViewModel>!
        var viewModel: MockViewModel!
        
        beforeEach {
            viewModel = .init()
            viewController = .init(viewModel: viewModel)
        }
        
        describe("appearance") {
            context("when the employee list isEmpty") {
                beforeEach {
                    @MainActor in
                    viewController.loadViewIfNeeded()
                    viewModel.employeesSubject.send([])
                }
                
                it("should have the right appearance") {
                    @MainActor in
                    assertSnapshot(matching: viewController, as: .image, named: "Empty List")
                }
            }
            context("when the employee list has values") {
                beforeEach {
                    @MainActor in
                    viewController.loadViewIfNeeded()
                    viewModel.employeesSubject.send([
                        MockViewModel.EmployeeSummaryCellModel(),
                        MockViewModel.EmployeeSummaryCellModel()
                    ])
                }
                it("should have the right appearance") {
                    @MainActor in
                    assertSnapshot(matching: viewController, as: .image, named: "FullList")
                }
            }
        }
    }
}

private final class MockViewModel: EmployeeListViewControllerViewModel {
    let header: HeaderCellModel = .init()
    var employeesPublisher: AnyPublisher<[EmployeeSummaryCellModel], Never> { employeesSubject.eraseToAnyPublisher() }
    let errorPublisher: AnyPublisher<Error, Never> = Empty(completeImmediately: false).eraseToAnyPublisher()
    let isLoadingPublisher: AnyPublisher<Bool, Never> = Empty(completeImmediately: false).eraseToAnyPublisher()
    
    var employeesSubject: PassthroughSubject<[EmployeeSummaryCellModel], Never> = .init()
    
    func loadEmployees() async {}
}

private extension MockViewModel {
    struct EmployeeSummaryCellModel: EmployeeSummaryCellViewModel, Hashable {
        var uuid: String = UUID().uuidString
        var imageUrl: URL = URL(string: "example.com")!
        var name: String = "[NAME]"
        var team: String = "[TEAM]"
    }
    
    struct HeaderCellModel: HeaderCellViewModel, Hashable {
        var title: String = "[TITLE]"
        var subTitle: String = "[SUBTITLE]"
    }
}
