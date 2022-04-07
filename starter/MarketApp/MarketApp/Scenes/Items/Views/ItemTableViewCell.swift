import UIKit

final class ItemTableViewCell: UITableViewCell {
    @IBOutlet var itemImageView: UIImageView!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var counterView: CounterView!

    func setUp(item: Item, count: Int) {
        itemImageView?.image = item.type.image
        self.priceLabel.text = "Price: \(item.price) TL"
        self.counterView.count = count
    }
}
