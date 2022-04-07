//
//  CounterView.swift
//  MarketApp
//
//  Created by Gizem Fitoz on 23.12.2021.
//

import UIKit

class CounterView: UIView {
    @IBOutlet var countLabel: UILabel!
    
    var count: Int = 0 {
        didSet {
            countLabel.text = "\(count)"
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
        let nib = UINib(nibName: "CounterView", bundle: .main)
        guard let view = nib.instantiate(withOwner: self, options: nil)[0] as? UIView else { return }
        view.frame = bounds
        view.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
        addSubview(view)
    }
    
    @IBAction func addItem() {
        // TODO
    }
    
    @IBAction func removeItem() {
        // TODO
    }
}
