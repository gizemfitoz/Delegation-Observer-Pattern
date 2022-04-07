import UIKit

class ItemsViewController: UIViewController {
    @IBOutlet weak var itemsTableView: UITableView!
    @IBOutlet weak var totalPriceView: TotalPriceView!
    var badge = BadgedButtonItem()
    var id = UUID()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setRightBarButton(badge, animated: false)
        itemsTableView.register(
            UINib(nibName: "ItemTableViewCell", bundle: .main),
            forCellReuseIdentifier: "ItemTableViewCell"
        )
        addInitalDummyItems()
        updateViews()
        Basket.shared.addObserver(self)
    }
    
    deinit {
        Basket.shared.removeObserver(self)
    }
    
    private func addInitalDummyItems() {
        Basket.shared.itemsDict[Item(type: .book, price: 30)] = 0
        Basket.shared.itemsDict[Item(type: .notebook, price: 20)] = 0
        Basket.shared.itemsDict[Item(type: .pencil, price: 10)] = 0
    }
    
    private func updateViews() {
        itemsTableView.reloadData()
        updateTotalPriceAndBadge()
    }
    
    private func updateTotalPriceAndBadge() {
        var totalCount = 0
        var totalPrice = 0
        
        for (item, count) in Basket.shared.itemsDict {
            totalCount += count
            totalPrice += count * item.price
        }
        totalPriceView.setTotalPrice(totalPrice)
        badge.setBadge(with: totalCount)
    }
}

extension ItemsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        Basket.shared.itemsDict.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ItemTableViewCell") as? ItemTableViewCell
        else { return UITableViewCell() }
        cell.selectionStyle = .none
        let item = Array(Basket.shared.itemsDict.keys)[indexPath.row]
        cell.setUp(item: item, count: Basket.shared.itemsDict[item] ?? 0)
        cell.tag = item.id.hashValue
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath),
              let selectedItem = getItem(from: cell)
        else { return }
                
        guard let detailViewController = UIStoryboard(name: "ItemDetail", bundle: .main)
                .instantiateViewController(withIdentifier: "ItemDetailViewController") as? ItemDetailViewController
        else { return }
        
        detailViewController.selectedItem = selectedItem
        detailViewController.count = Basket.shared.itemsDict[selectedItem] ?? 0
        self.navigationController?.pushViewController(detailViewController, animated: false)
    }
    
    private func getItem(from cell: UITableViewCell) -> Item? {
        let itemId = cell.tag
        return Basket.shared.itemsDict.keys.first(where: { $0.id.hashValue == itemId})
    }
}

extension ItemsViewController: BasketObserver {
    func onChange(itemsDict: [Item : Int]) {
        updateViews()
    }
}
