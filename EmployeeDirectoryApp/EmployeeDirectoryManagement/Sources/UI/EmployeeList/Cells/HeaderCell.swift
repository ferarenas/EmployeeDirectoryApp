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

    let titleLabel: UILabel = .init()
    let firstInstructionLabel: UILabel = .init()
    let secondInstructionLabel: UILabel = .init()
    
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
        let labelStackView: UIStackView = .init()
        labelStackView.axis = .vertical
        labelStackView.spacing = 10
        
        labelStackView.addArrangedSubview(titleLabel)
        labelStackView.addArrangedSubview(firstInstructionLabel)
        labelStackView.addArrangedSubview(secondInstructionLabel)
        
        addSubview(labelStackView)
        
        labelStackView.snp.makeConstraints { make in
            make.edges.equalTo(layoutMarginsGuide)
        }
    }
    
    private func setUpTitleLabel() {
        titleLabel.font = UIFont.boldSystemFont(ofSize: 22)
    }
    
    private func setUpFirstInstructionLabel() {
        firstInstructionLabel.font = UIFont.boldSystemFont(ofSize: 20)
    }
    
    private func setUpSecondInstructionLabel() {
        secondInstructionLabel.font = UIFont.boldSystemFont(ofSize: 20)

    }
}

extension HeaderCell: Configurable {
    func configure(with viewModel: HeaderCellModel) {
        titleLabel.text = viewModel.title
        firstInstructionLabel.text = viewModel.firstInstruction
        secondInstructionLabel.text = viewModel.secondInstruction
        
    }
}
