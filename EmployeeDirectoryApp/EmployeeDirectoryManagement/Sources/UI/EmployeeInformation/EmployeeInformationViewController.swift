import Foundation
import SnapKit
import UIKit

final class EmployeeInformationViewController<ViewModel>: UIViewController
where ViewModel: EmployeeInformationViewViewModel {
    let customView: EmployeeInformationView = .init()
    let viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        bindToViewModel()
        
        view.addSubview(customView)
        
        customView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func bindToViewModel() {
        customView.configure(model: viewModel)
    }
}
