import UIKit

class ViewController: UIViewController {

    private var dataSource: UICollectionViewDiffableDataSource<Section, Item>!
    private var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    lazy var collectionViewLayout: UICollectionViewLayout = {
        
        let layout = UICollectionViewCompositionalLayout { [weak self] (sectionIndex, enviroment) ->
            NSCollectionLayoutSection? in
            guard let self = self else { return nil }
            
            let snapshot = self.dataSource.snapshot()
            let sectionType = snapshot.sectionIdentifiers[sectionIndex].type
            
            switch sectionType {
            case .large:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(240))
                
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
                
                let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
                group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)
                
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .groupPaging
                section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 15, trailing: 0)
                
                return section
                
            case .header:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(50))

                let item = NSCollectionLayoutItem(layoutSize: itemSize)

                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(50))

                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 0)

                let section = NSCollectionLayoutSection(group: group)

                return section
                
            case .ad:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50))

                let item = NSCollectionLayoutItem(layoutSize: itemSize)

                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))

                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 0)

                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .groupPaging
                section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 15, trailing: 0)

                return section
                
            default: return nil
            }
        }
        
        
        return layout
        
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }

    func initialize() {
        setUpCollectionView()
        configureDataSource()
    }
    
    private func setUpCollectionView() {
        collectionView.register(UINib(nibName: "LargeCell", bundle: .main), forCellWithReuseIdentifier: "LargeCell")
        collectionView.register(UINib(nibName: "MediumCell", bundle: .main), forCellWithReuseIdentifier: "MediumCell")
        collectionView.register(UINib(nibName: "HeaderCell", bundle: .main), forCellWithReuseIdentifier: "HeaderCell")
        collectionView.register(UINib(nibName: "AdCell", bundle: .main), forCellWithReuseIdentifier: "AdCell")
        
        collectionView.collectionViewLayout = collectionViewLayout
    }
    
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView) { [weak self]
            (collectionView, indexPath, item) in
            guard let self = self else { return UICollectionViewCell() }
            
            let  snapshot = self.dataSource.snapshot()
            let sectionType = snapshot.sectionIdentifiers[indexPath.section].type
            
            switch sectionType {
            case .large:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LargeCell", for: indexPath)
                return cell
            case .header:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HeaderCell", for: indexPath)
                return cell
            case .ad:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AdCell", for: indexPath)
                return cell
                
            default: return nil
                
            }
            
        }
        
        let sections = [
            Section(type: .header, items: [
                Item()
            ]),
            Section(type: .large, items: [
                Item(), Item(), Item(),
                
            ]),
            Section(type: .ad, items: [
                Item(), Item(), Item()
            ])
        ]
        
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections(sections)
        sections.forEach {snapshot.appendItems($0.items, toSection: $0) }
        dataSource.apply(snapshot, animatingDifferences: false)
        
    }
    
}

