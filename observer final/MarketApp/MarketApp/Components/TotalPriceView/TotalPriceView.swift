import UIKit

class TotalPriceView: UIView {
    @IBOutlet private var view: UIView!
    @IBOutlet private var totalPriceLabel: UILabel!
    private var totalPrice: Int = 0 {
        didSet {
            totalPriceLabel.text = "Total Price: \(totalPrice) TL"
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    private func setup() {
        let nib = UINib(nibName: "TotalPriceView", bundle: .main)
        guard let view = nib.instantiate(withOwner: self, options: nil)[0] as? UIView else { return }
        view.frame = bounds
        view.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
        addSubview(view)
    }
    
    func setTotalPrice(_ price: Int) {
        self.totalPrice = price
    }
}
