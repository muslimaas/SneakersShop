import UIKit
import SnapKit

final class CartViewController: UIViewController {

    private let tableView = UITableView()
    private let confirmButton = BigButtonView()
    private let totalContainer = UIView()
    private let totalTextLabel = UILabel()
    private let totalPriceLabel = UILabel()
    private let emptyView = CartEmptyView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableFooter()
        updateTotal()
        updateEmptyState()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateTotal()
        updateEmptyState()
        tableView.reloadData()
    }

    private func setupUI() {
        view.backgroundColor = .systemGray6
        title = "Cart"

        setupConfirmButton()
        setupTableView()
    }


    private func setupTableView() {
        tableView.register(CartItemCell.self, forCellReuseIdentifier: "CartItemCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = .systemGray6
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 160

        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(confirmButton.snp.top).offset(-12)
        }
    }



    private func setupTableFooter() {
        let footer = UIView()
        footer.backgroundColor = .clear

        totalContainer.backgroundColor = .white
        totalContainer.layer.cornerRadius = 4

        totalTextLabel.font = .systemFont(ofSize: 13)
        totalPriceLabel.font = .boldSystemFont(ofSize: 13)

        totalContainer.addSubview(totalTextLabel)
        totalContainer.addSubview(totalPriceLabel)

        totalTextLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.centerY.equalToSuperview()
        }

        totalPriceLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
        }

        footer.addSubview(totalContainer)

        totalContainer.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(50)
            $0.bottom.equalToSuperview().offset(-12)
        }

        footer.layoutIfNeeded()
        footer.frame.size.height = 74

        tableView.tableFooterView = footer
    }


    private func setupConfirmButton() {
        confirmButton.setTitle("Confirm Order")
        confirmButton.BackColor(.black)
        confirmButton.onTap = { [weak self] in
            self?.confirmTapped()
        }

        view.addSubview(confirmButton)
        confirmButton.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(15)
            $0.trailing.equalToSuperview().inset(17)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.height.equalTo(64)
        }
    }


    private func updateTotal() {
        let total = CartService.shared.totalPrice()
        let count = CartService.shared.totalCount()
        totalTextLabel.text = "\(count) items · Total (Including Delivery)"
        totalPriceLabel.text = "$\(total)"
    }

    private func updateEmptyState() {
        let isEmpty = CartService.shared.items.isEmpty

        if isEmpty {
            if emptyView.superview == nil {
                view.addSubview(emptyView)
                emptyView.snp.makeConstraints { $0.edges.equalToSuperview() }
            }
        } else {
            emptyView.removeFromSuperview()
        }

        tableView.isHidden = isEmpty
        totalContainer.isHidden = isEmpty
        confirmButton.isHidden = isEmpty
    }

    private func confirmTapped() {
        let alert = UIAlertController(
            title: "Proceed with payment",
            message: "Are you sure you want to confirm?",
            preferredStyle: .alert
        )

        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))

        alert.addAction(UIAlertAction(title: "Confirm", style: .default) { [weak self] _ in
            guard let self else { return }

            CartService.shared.clear()

            let successVC = OrderSuccessViewController()
            successVC.modalPresentationStyle = .overFullScreen

            successVC.onClose = { [weak self] in
                guard let self else { return }

                CartService.shared.clear()
                self.tableView.reloadData()
                self.updateTotal()
                self.updateEmptyState()
            }

            self.present(successVC, animated: true)
        })

        present(alert, animated: true)
    }
}


extension CartViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        CartService.shared.items.count
    }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(
            withIdentifier: "CartItemCell",
            for: indexPath
        ) as! CartItemCell

        let item = CartService.shared.items[indexPath.row]
        cell.configure(with: item)

        cell.onIncrease = { [weak self] in
            guard let self else { return }
            CartService.shared.add(itemId: item.id)
            self.updateTotal()
            tableView.reloadRows(at: [indexPath], with: .none)
        }

        cell.onDecrease = {
            CartService.shared.remove(itemId: item.id)
            self.updateTotal()
            tableView.reloadData()
        }

        return cell
    }

    func tableView(
        _ tableView: UITableView,
        trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath
    ) -> UISwipeActionsConfiguration? {

        let delete = UIContextualAction(style: .destructive, title: "Delete") { _,_,completion in
            let item = CartService.shared.items[indexPath.row]
            CartService.shared.removeCompletely(itemId: item.id)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            self.updateTotal()
            self.updateEmptyState()
            completion(true)
        }

        return UISwipeActionsConfiguration(actions: [delete])
    }
}
