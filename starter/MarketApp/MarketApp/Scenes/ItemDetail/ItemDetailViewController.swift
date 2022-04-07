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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.itemImageView.image = selectedItem.type.image
        self.typeLabel.text = "\(selectedItem.type)"
    }
}
