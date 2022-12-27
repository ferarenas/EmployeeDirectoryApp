import UIKit
import SnapKit

protocol HeaderCellViewModel {
    var title: String { get }
    var firstInstruction: String { get }
}

final class HeaderCell: UICollectionViewCell {
    static var estimatedHeight: Double {
        UIFontMetrics.default.scaledValue(for: Spacing.extraLarge)
        + UIFontMetrics.default.scaledValue(for: Spacing.medium)*2
    }

    let titleLabel: UILabel = .init()
    let firstInstructionLabel: UILabel = .init()
    
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
    }
    
    private func setUpLabelStackView() {
        let labelStackView: UIStackView = .init()
        labelStackView.axis = .vertical
        labelStackView.alignment = .center
        labelStackView.spacing = Spacing.extraSmall
        
        labelStackView.addArrangedSubview(titleLabel)
        labelStackView.addArrangedSubview(firstInstructionLabel)
        
        addSubview(labelStackView)
        
        labelStackView.snp.makeConstraints { make in
            make.edges.equalTo(layoutMarginsGuide)
        }
    }
    
    private func setUpTitleLabel() {
        titleLabel.font = UIFont.boldSystemFont(ofSize: Spacing.extraLarge)
        titleLabel.numberOfLines = 0
    }
    
    private func setUpFirstInstructionLabel() {
        firstInstructionLabel.font = UIFont.boldSystemFont(ofSize: Spacing.small)
    }
}

extension HeaderCell {
    func configure(with viewModel: HeaderCellModel) {
        titleLabel.text = viewModel.title
        firstInstructionLabel.text = viewModel.firstInstruction
    }
}
