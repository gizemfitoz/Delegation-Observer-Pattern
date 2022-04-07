//
//  ItemDetailViewController.swift
//  MarketApp
//
//  Created by Gizem Fitoz on 23.12.2021.
//

import UIKit

class ItemDetailViewController: UIViewController {
    let id = UUID()
    @IBOutlet var itemImageView: UIImageView!
    @IBOutlet var typeLabel: UILabel!
    @IBOutlet var counterView: CounterView!
    var selectedItem: Item!
    var count: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.itemImageView.image = selectedItem.type.image
        self.typeLabel.text = "\(selectedItem.type)"
        self.counterView.count = count
        self.counterView.itemId = selectedItem.id.hashValue
        Basket.shared.addObserver(self)
    }
    
    deinit{
        Basket.shared.removeObserver(self)
    }
}

extension ItemDetailViewController: BasketObserver {
    func onChange(itemsDict: [Item : Int]) {
        guard let item = Basket.shared.itemsDict.keys.first(where: { $0.id.hashValue == selectedItem.id.hashValue })
        else { return }
        selectedItem = item
        count = itemsDict[selectedItem] ?? 0
        self.counterView.count = count
    }
}
