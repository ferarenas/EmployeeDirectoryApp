import Foundation
import UIKit
import SnapKit

protocol HeaderCellViewModel {
    var title: String { get }
    var firstInstruction: String { get }
    var secondInstruction: String { get }
}

final class HeaderCell: UICollectionViewCell {
    static var estimatedHeight: Double {
        UIFontMetrics.default.scaledValue(for: 22)
        + UIFontMetrics.default.scaledValue(for: 20)*2
    }

    private let labelStackView: UIStackView = .init()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }
    
    private func setupSubviews() {
        setUpLabelStackView()
        setUpTitleLabel()
        setUpFirstInstructionLabel()
        setUpSecondInstructionLabel()
    }
    
    private func setUpLabelStackView() {
        labelStackView.axis = .vertical
        labelStackView.spacing = 10
        
        addSubview(labelStackView)
        
        labelStackView.snp.makeConstraints { make in
            make.edges.equalTo(layoutMarginsGuide)
        }
    }
    
    private func setUpTitleLabel() {
        let titleLabel: UILabel = .init()
        titleLabel.font = UIFont.boldSystemFont(ofSize: 22)
        
        labelStackView.addArrangedSubview(titleLabel)
    }
    
    private func setUpFirstInstructionLabel() {
        let firstInstructionLabel: UILabel = .init()
        firstInstructionLabel.font = UIFont.boldSystemFont(ofSize: 20)
        
        labelStackView.addArrangedSubview(firstInstructionLabel)
    }
    
    private func setUpSecondInstructionLabel() {
        let secondInstructionLabel: UILabel = .init()
        secondInstructionLabel.font = UIFont.boldSystemFont(ofSize: 20)
        
        labelStackView.addArrangedSubview(secondInstructionLabel)
    }
}
