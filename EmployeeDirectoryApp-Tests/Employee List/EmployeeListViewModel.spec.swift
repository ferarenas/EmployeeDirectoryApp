import Combine
import Foundation
import Quick
import Nimble
@testable import EmployeeDirectoryApp

final class EmployeeListViewModel_Spec: QuickSpec {
    override func spec() {
        var viewModel: EmployeeListViewModel!
        var employees: [Employee]!
        var employeeOne: Employee!
        var employeeTwo: Employee!
        var cancellables: Set<AnyCancellable> = []
        
        beforeEach {
            employeeOne = .testEmployee(uuid: "1")
            employeeTwo = .testEmployee(uuid: "2")
            employees = [
                employeeOne,
                employeeTwo
            ]
        }
        
        describe("init(service:urlType:") {
            var isLoading: Bool!
            var employeeCellModels: [EmployeeListViewModel.EmployeeSummaryCellModel]?
            var error: Error?
            
            it("should set the header with the correct information") {
                viewModel = .init(
                    service: MockEmployeeService(result: .success(employees)),
                    urlType: .valid
                )
                
                let expectedHeader = EmployeeListViewModel.HeaderCellModel(
                    title: L10n.EmployeeList.title,
                    subTitle: L10n.EmployeeList.subtitle
                )
                expect(viewModel.header) == expectedHeader
            }
            
            context("when urlType is of type .valid") {
                context("when loadEmployees call succeeds") {
                    beforeEach {
                        viewModel = .init(
                            service: MockEmployeeService(result: .success(employees)),
                            urlType: .valid
                        )
                        
                        viewModel
                            .isLoadingPublisher
                            .receive(on: DispatchQueue.main)
                            .sink { isLoading = $0 }
                            .store(in: &cancellables)
                        
                        viewModel
                            .employeesPublisher
                            .receive(on: DispatchQueue.main)
                            .sink { employeeCellModels = $0 }
                            .store(in: &cancellables)
                        
                        await viewModel.loadEmployees()
                    }
                    
                    it("should set isLoading to true") {
//                        await expect(isLoading).toEventually(beTrue())
                    }
                    
                    it("should publish the EmployeesPublisher") {
                        let expectedEmployeeCellModels: [EmployeeListViewModel.EmployeeSummaryCellModel] = [
                            .init(employee: employeeOne)!,
                            .init(employee: employeeTwo)!
                        ]
                        
                        await expect(employeeCellModels).toEventually(contain(expectedEmployeeCellModels))
                    }
                    
                    it("should set isLoading to false") {
                        await expect(isLoading).toEventually(beFalse())
                    }
                }
            }
            
            context("when urlType is of type .empty") {
                context("when loadEmployees call succeeds") {
                    beforeEach {
                        viewModel = .init(
                            service: MockEmployeeService(result: .success([])),
                            urlType: .empty
                        )
                        
                        viewModel
                            .isLoadingPublisher
                            .receive(on: DispatchQueue.main)
                            .sink { isLoading = $0 }
                            .store(in: &cancellables)
                        
                        viewModel
                            .employeesPublisher
                            .receive(on: DispatchQueue.main)
                            .sink { employeeCellModels = $0 }
                            .store(in: &cancellables)
                        
                        await viewModel.loadEmployees()
                    }
                    
                    it("should set isLoading to true") {
//                        await expect(isLoading).toEventually(beTrue())
                    }
                    
                    it("should publish the EmployeesPublisher") {
                        expect(employeeCellModels) == []
                    }
                    
                    it("should set isLoading to false") {
                        await expect(isLoading).toEventually(beFalse())
                    }
                    
                }
            }
            
            context("when urlType is of type .malformed") {
                context("when loadEmployees call succeeds") {
                    beforeEach {
                        viewModel = .init(
                            service: MockEmployeeService(result: .failure(NSError(domain: "abc", code: 1))),
                            urlType: .malformed
                        )
                        
                        viewModel
                            .isLoadingPublisher
                            .receive(on: DispatchQueue.main)
                            .sink { isLoading = $0 }
                            .store(in: &cancellables)
                        
                        viewModel
                            .errorPublisher
                            .receive(on: DispatchQueue.main)
                            .sink { error = $0 }
                            .store(in: &cancellables)
                    }
                    
                    it("should set isLoading to true") {
//                        await expect(isLoading).toEventually(beTrue())
                    }
                    
                    it("should publish the error") {
                        //
                    }
                    
                    it("should set isLoading to false") {
                        await expect(isLoading).toEventually(beFalse())
                    }
                }
            }
        }
    }
}
