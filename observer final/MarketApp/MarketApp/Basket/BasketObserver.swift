//
//  BasketObserver.swift
//  MarketApp
//
//  Created by Gizem Fitoz on 23.12.2021.
//

import Foundation

protocol BasketObserver: AnyObject {
    var id: UUID { get }
    func onChange(itemsDict: [Item: Int])
}
