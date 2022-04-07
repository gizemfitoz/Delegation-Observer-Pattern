//
//  ItemDetailViewController.swift
//  MarketApp
//
//  Created by Gizem Fitoz on 23.12.2021.
//

import UIKit

protocol ItemDetailViewControllerDelegate: AnyObject {
    func updateCount(_ item: Item, totalCount: Int)
}

class ItemDetailViewController: UIViewController {
    @IBOutlet var itemImageView: UIImageView!
    @IBOutlet var typeLabel: UILabel!
    @IBOutlet var counterView: CounterView!
    var selectedItem: Item!
    
    var count: Int = 0 {
        didSet {
            self.updateItemCount()
        }
    }
    weak var delegate: ItemDetailViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.itemImageView.image = selectedItem.type.image
        self.typeLabel.text = "\(selectedItem.type)"
        counterView.delegate = self
        updateItemCount()
    }
    
    private func updateItemCount() {
        self.counterView?.count = count
    }
}

extension ItemDetailViewController: CounterViewDelegate {
    func updateCount(_ view: CounterView, totalCount: Int) {
        self.count = totalCount
        delegate?.updateCount(selectedItem, totalCount: totalCount)
    }
}
