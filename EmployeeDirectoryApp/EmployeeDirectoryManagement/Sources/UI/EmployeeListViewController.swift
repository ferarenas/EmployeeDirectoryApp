
private extension EmployeeListViewController {
    func setupDataSource() {
        typealias CellRegistration = UICollectionView.CellRegistration
        
        let headerCell = CellRegistration(cellNib: <#T##UINib#>, handler: <#T##UICollectionView.CellRegistration<UICollectionViewCell, _>.Handler##UICollectionView.CellRegistration<UICollectionViewCell, _>.Handler##(_ cell: UICollectionViewCell, _ indexPath: IndexPath, _ itemIdentifier: _) -> Void#>)
        
        let dataSource = DataSource(collectionView: collectionView) { collectionView, indexPath, item -> UICollectionViewCell? in
            switch item {
            case .header(_):
                <#code#>
            case .employeeSummary(_):
                <#code#>
            case .employeeInformation(_):
                <#code#>
            }
        }
        
        self.dataSource = dataSource
    }
    
    func updateDataSource() {
        guard var snapshot = dataSource?.snapshot() else { return }
        defer { dataSource?.apply(snapshot, animatingDifferences: true) }
        
        snapshot.deleteAllItems()
    }
}

private extension EmployeeListViewController {
    func setupLayout() {
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        configuration.contentInsetsReference = .layoutMargins

        let layout = UICollectionViewCompositionalLayout(
            sectionProvider: { [weak self] index, _ in
                switch self?.dataSource?.snapshot().sectionIdentifiers[index] {
                case .none:
                    <#code#>
                case .some(_):
                    <#code#>
                }
            },
            configuration: configuration
        )

        collectionView.collectionViewLayout = layout
    }
}

private extension NSCollectionLayoutSection {
    static var headerLayout: NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(HeaderCell.estimatedHeight)
        )
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let group = NSCollectionLayoutGroup.vertical(layoutSize: itemSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets.bottom = 20
        section.contentInsetsReference = .layoutMargins

        return section
    }
}
    