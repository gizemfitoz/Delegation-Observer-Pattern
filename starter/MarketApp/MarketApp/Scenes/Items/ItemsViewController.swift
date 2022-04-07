import UIKit

class ItemsViewController: UIViewController {
    @IBOutlet weak var itemsTableView: UITableView!
    @IBOutlet weak var totalPriceView: TotalPriceView!
    var itemsDict: [Item: Int] = [:]
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
        itemsTableView.reloadData()
    }
    
    private func addInitalDummyItems() {
        itemsDict[Item(type: .book, price: 30)] = 0
        itemsDict[Item(type: .notebook, price: 20)] = 0
        itemsDict[Item(type: .pencil, price: 10)] = 0
    }
}

extension ItemsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        itemsDict.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ItemTableViewCell") as? ItemTableViewCell
        else { return UITableViewCell() }
        cell.selectionStyle = .none
        let item = Array(itemsDict.keys)[indexPath.row]
        cell.setUp(item: item, count: itemsDict[item] ?? 0)
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
        self.navigationController?.pushViewController(detailViewController, animated: false)
    }
    
    private func getItem(from cell: UITableViewCell) -> Item? {
        let itemId = cell.tag
        return itemsDict.keys.first(where: { $0.id.hashValue == itemId})
    }
}
