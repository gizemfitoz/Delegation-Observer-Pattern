import UIKit

class BadgedButtonItem: UIBarButtonItem {
    func setBadge(with value: Int) {
        badgeValue = value
    }

    private var badgeValue: Int? {
        didSet {
            if let value = badgeValue,
               value > 0 {
                badgeLabel.isHidden = false
                badgeLabel.text = "\(value)"
            } else {
                badgeLabel.isHidden = true
            }
        }
    }
    public var buttonBackgroundColor: UIColor!
    public var labelBackgroundColor: UIColor!
    public var labelTextColor: UIColor!
    public var borderColor: UIColor!

    private let button = UIButton()
    private let badgeLabel = UILabel()

    override public init() {
        super.init()
        self.buttonBackgroundColor = .clear
        self.labelBackgroundColor = .white
        self.labelTextColor = .blue
        self.borderColor = .blue
        setup(image: image)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    private func setup(image: UIImage? = nil) {
        button.frame = CGRect(x: 0, y: 0, width: 28, height: 28)
        let image = UIImage(named: "shoppingCart")?.withRenderingMode(.alwaysTemplate)
        button.setImage(image, for: .normal)
        button.tintColor = .blue
        button.backgroundColor = .clear

        badgeLabel.frame = CGRect(x: 14, y: -8, width: 23, height: 23)
        badgeLabel.layer.borderWidth = 2
        badgeLabel.layer.borderColor = borderColor.cgColor
        badgeLabel.backgroundColor = labelBackgroundColor
        badgeLabel.clipsToBounds = true
        badgeLabel.layer.cornerRadius = 11.5
        badgeLabel.textColor = labelTextColor
        badgeLabel.textAlignment = .center
        badgeLabel.isHidden = true
        badgeLabel.minimumScaleFactor = 0.1
        badgeLabel.adjustsFontSizeToFitWidth = true
        button.addSubview(badgeLabel)
        customView = button
    }
}
