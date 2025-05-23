import Foundation
import Kingfisher
import SnapKit
import UIKit

protocol EmployeeInformationViewViewModel {
    var employee: Employee { get }
}

final class EmployeeInformationView: UIView {
    let photo: UIImageView = .init()
    let nameLabel: UILabel = .init()
    let emailLabel: UILabel = .init()
    let phoneLabel: UILabel = .init()
    let biographyLabel: UILabel = .init()
    let teamLabel: UILabel = .init()
    let employeeTypeLabel: UILabel = .init()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpViews() {
        backgroundColor = .white
        setUpStackView()
        setUpPhoto()
        setUpBiographyLabel()
    }
    
    private func setUpStackView() {
        let stackView: UIStackView = .init()
        
        stackView.axis = .vertical
        stackView.spacing = Spacing.medium
        stackView.alignment = .center
        
        stackView.addArrangedSubview(photo)
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(emailLabel)
        stackView.addArrangedSubview(phoneLabel)
        stackView.addArrangedSubview(biographyLabel)
        stackView.addArrangedSubview(teamLabel)
        stackView.addArrangedSubview(employeeTypeLabel)
        
        
        addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview(\.layoutMarginsGuide)
        }
    }
    
    private func setUpPhoto() {
        photo.snp.makeConstraints { make in
            make.size.equalTo(120)
        }
    }
    
    private func setUpBiographyLabel() {
        biographyLabel.numberOfLines = 0
    }
}

extension EmployeeInformationView {
    func configure(model: EmployeeInformationViewViewModel) {
        let employee = model.employee
        
        if let employeeUrlString = employee.photoUrlLarge {
            photo.kf.setImage(with: URL(string: employeeUrlString))
        }
        
        nameLabel.text = employee.fullName
        
        emailLabel.text = employee.emailAddress
        phoneLabel.text = employee.phoneNumber
        biographyLabel.text = employee.biography
        teamLabel.text = employee.team
        employeeTypeLabel.text = employee.employeeType.localizable
    }
}
