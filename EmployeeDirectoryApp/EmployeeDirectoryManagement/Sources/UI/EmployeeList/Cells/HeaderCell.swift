import UIKit
import SnapKit

protocol HeaderCellViewModel {
    var title: String { get }
    var subTitle: String { get }
}

final class HeaderCell: UICollectionViewCell {
    static var estimatedHeight: Double {
        UIFontMetrics.default.scaledValue(for: Spacing.extraLarge)
        + UIFontMetrics.default.scaledValue(for: Spacing.small)
    }

    let titleLabel: UILabel = .init()
    let subtitleLabel: UILabel = .init()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpSubviews()
    }
    
    private func setUpSubviews() {
        setUpLabelStackView()
        setUpTitleLabel()
        setUpSubTitleLabel()
    }
    
    private func setUpLabelStackView() {
        let labelStackView: UIStackView = .init()
        labelStackView.axis = .vertical
        labelStackView.alignment = .center
        labelStackView.spacing = Spacing.extraSmall
        
        labelStackView.addArrangedSubview(titleLabel)
        labelStackView.addArrangedSubview(subtitleLabel)
        
        addSubview(labelStackView)
        
        labelStackView.snp.makeConstraints { make in
            make.edges.equalTo(layoutMarginsGuide)
        }
    }
    
    private func setUpTitleLabel() {
        titleLabel.font = UIFont.boldSystemFont(ofSize: Spacing.extraLarge)
        titleLabel.numberOfLines = 0
    }
    
    private func setUpSubTitleLabel() {
        subtitleLabel.font = UIFont.boldSystemFont(ofSize: Spacing.small)
    }
}

extension HeaderCell {
    func configure(with viewModel: HeaderCellViewModel) {
        titleLabel.text = viewModel.title
        subtitleLabel.text = viewModel.subTitle
    }
}
