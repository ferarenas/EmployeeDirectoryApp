import Foundation
import UIKit
import SnapKit

protocol EmployeeInfoCellViewModel {
    var employeeInformation: [String] { get }
}

final class EmployeeInfoCell: UICollectionViewCell {
    static var estimatedHeight: Double {
        let cellHeight = UIFontMetrics.default.scaledValue(for: 22)*4
        return cellHeight
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
    }
    
    private func setUpLabelStackView() {
        labelStackView.axis = .vertical
        labelStackView.spacing = 5
        
        addSubview(labelStackView)
        
        labelStackView.snp.makeConstraints { make in
            make.edges.equalTo(layoutMarginsGuide)
        }
    }
}
