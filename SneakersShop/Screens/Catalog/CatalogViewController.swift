import UIKit
import FirebaseFirestore
import SnapKit

final class CatalogViewController:
    UIViewController,
    UICollectionViewDataSource,
    UICollectionViewDelegate,
    UICollectionViewDelegateFlowLayout {

    private var items: [CatalogItem] = []

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 16
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 10, right: 16)

        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .systemGray6
        collection.delegate = self
        collection.dataSource = self
        collection.register(
            CatalogCell.self,
            forCellWithReuseIdentifier: CatalogCell.reuseIdentifier
        )
        return collection
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemGray6
        navigationItem.title = "Hello, Sneakerhead!"

        view.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        fetchProducts()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
    }


    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        items.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CatalogCell.reuseIdentifier,
            for: indexPath
        ) as! CatalogCell

        let item = items[indexPath.item]
        cell.configure(with: item)

        cell.onActionTap = { [weak self] in
            guard let self else { return }

            if CartService.shared.isInCart(id: item.id) {
                CartService.shared.remove(itemId: item.id)
            } else {
                CartService.shared.add(item: item)
            }

            self.collectionView.reloadItems(at: [indexPath])
        }

        return cell
    }


    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {

        let padding: CGFloat = 16 * 2
        let spacing: CGFloat = 10
        let availableWidth = collectionView.frame.width - padding - spacing
        let itemWidth = availableWidth / 2

        return CGSize(width: itemWidth, height: itemWidth * 1.6)
    }


    private func fetchProducts() {
        let db = Firestore.firestore()

        db.collection("AllProducts").getDocuments { [weak self] snapshot, error in
            if let error = error {
                print("Error loading products:", error)
                return
            }

            guard let documents = snapshot?.documents else { return }

            self?.items = documents.compactMap { doc in
                let data = doc.data()

                guard
                    let sneakers = data["title"] as? String,
                    let description = data["description"] as? String,
                    let price = data["price"] as? Int,
                    let image = data["imageUrl"] as? String
                else {
                    return nil
                }

                return CatalogItem(
                    id: doc.documentID,
                    sneakers: sneakers,
                    description: description,
                    price: price,
                    image: image
                )
            }

            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
    }
}
