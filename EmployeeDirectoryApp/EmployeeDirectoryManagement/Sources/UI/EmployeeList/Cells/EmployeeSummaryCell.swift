import Foundation
import UIKit
import SnapKit
import Kingfisher

protocol EmployeeSummaryCellViewModel {
    var imageUrl: URL { get }
    var name: String { get }
    var team: String { get }
}

final class EmployeeSummaryCell: UICollectionViewCell {
    static var estimatedHeight: Double { Double(Spacing.huge*2) }
    
    private let employeePhoto: UIImageView = .init()
    private let labelStackView: UIStackView = .init()
    private let nameLabel: UILabel = .init()
    private let teamLabel: UILabel = .init()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpSubviews()
    }
    
    private func setUpSubviews() {
        setUpCellStackView()
        setUpLabelStackView()
        setUpEmployeePhoto()
        setUpNameLabel()
        setUpTeamLabel()
    }
    
    private func setUpCellStackView() {
        let cellStackView: UIStackView = .init()
        cellStackView.axis = .horizontal
        cellStackView.spacing = Spacing.extraSmall
        
        cellStackView.addArrangedSubview(employeePhoto)
        cellStackView.addArrangedSubview(labelStackView)
        
        addSubview(cellStackView)
        
        cellStackView.snp.makeConstraints { make in
            make.edges.equalTo(layoutMarginsGuide)
        }
    }
    
    private func setUpLabelStackView() {
        labelStackView.axis = .vertical
        labelStackView.spacing = Spacing.extraSmall
        labelStackView.alignment = .leading
        
        labelStackView.addArrangedSubview(nameLabel)
        labelStackView.addArrangedSubview(teamLabel)
    }
    
    private func setUpEmployeePhoto() {
        employeePhoto.snp.makeConstraints { make in
            make.size.equalTo(Spacing.huge)
        }
    }
    
    private func setUpNameLabel() {
        nameLabel.font = UIFont.boldSystemFont(ofSize: Spacing.medium)
    }
    
    private func setUpTeamLabel() {
        teamLabel.font = UIFont.boldSystemFont(ofSize: Spacing.small)
    }
}

extension EmployeeSummaryCell {
    func configure(with viewModel: EmployeeSummaryCellViewModel) {
        nameLabel.text = viewModel.name
        teamLabel.text = viewModel.team
        employeePhoto.kf.setImage(with: viewModel.imageUrl)
    }
}


