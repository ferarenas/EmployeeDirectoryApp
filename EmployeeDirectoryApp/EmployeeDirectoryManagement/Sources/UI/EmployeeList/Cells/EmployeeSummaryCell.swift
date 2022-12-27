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
    static var estimatedHeight: Double {
        UIFontMetrics.default.scaledValue(for: 20)
        + UIFontMetrics.default.scaledValue(for: 18)
    }
    
    private let employeePhoto: UIImageView = .init()
    private let cellStackView: UIStackView = .init()
    private let nameLabel: UILabel = .init()
    private let teamLabel: UILabel = .init()
    
    private let labelStackView: UIStackView = .init()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }
    
    private func setupSubviews() {
        setUpCellStackView()
        setUpLabelStackView()
        setUpEmployeeName()
        setUpEmployeeTeam()
    }
    
    private func setUpCellStackView() {
        cellStackView.axis = .horizontal
        cellStackView.addArrangedSubview(employeePhoto)
        cellStackView.addArrangedSubview(labelStackView)
        
        addSubview(cellStackView)
        
        cellStackView.snp.makeConstraints { make in
            make.edges.equalTo(layoutMarginsGuide)
        }
    }
    
    private func setUpLabelStackView() {
        labelStackView.axis = .vertical
        labelStackView.spacing = 10
        
        cellStackView.addArrangedSubview(labelStackView)
    }
    
    private func setUpEmployeeName() {
        
        nameLabel.font = UIFont.boldSystemFont(ofSize: 20)
        
        labelStackView.addArrangedSubview(nameLabel)
    }
    
    private func setUpEmployeeTeam() {
        teamLabel.font = UIFont.boldSystemFont(ofSize: 18)
        
        labelStackView.addArrangedSubview(teamLabel)
    }
    
}

extension EmployeeSummaryCell {
    func configure(with viewModel: EmployeeSummaryCellViewModel) {
        nameLabel.text = viewModel.name
        teamLabel.text = viewModel.team
    }
}


