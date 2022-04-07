import UIKit

protocol ItemTableViewCellDelegate: AnyObject {
    func updateCellCount(_ cell: ItemTableViewCell, totalCount: Int)
}

final class ItemTableViewCell: UITableViewCell {
    @IBOutlet var itemImageView: UIImageView!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var counterView: CounterView!
    weak var delegate: ItemTableViewCellDelegate?

    func setUp(item: Item, count: Int) {

        itemImageView?.image = item.type.image
        self.priceLabel.text = "Price: \(item.price) TL"
        self.counterView.count = count
    }
}

extension ItemTableViewCell: CounterViewDelegate {
    func updateCount(_ view: CounterView, totalCount: Int) {
        delegate?.updateCellCount(self, totalCount: totalCount)
    }
}
