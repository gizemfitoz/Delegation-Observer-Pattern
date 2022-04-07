//
//  Basket.swift
//  MarketApp
//
//  Created by Gizem Fitoz on 23.12.2021.
//

import Foundation


class WeakWrapper {
    weak var basketObserver: BasketObserver?
    
    init(basketObserver: BasketObserver) {
        self.basketObserver = basketObserver
    }
}

class Basket {
    static let shared = Basket()
    var itemsDict: [Item: Int] = [:] {
        didSet {
            notify()
        }
    }
    private var observers: [WeakWrapper] = []
    
    private init() {}
    
    func addObserver(_ observer: BasketObserver) {
        observers.append(WeakWrapper(basketObserver: observer))
    }
    
    func removeObserver(_ observer: BasketObserver) {
        observers.removeAll(where: { $0.basketObserver?.id == observer.id })
    }
    
    func addItem(_ itemId: Int) {
        guard let itemToBeUpdate = getItem(from: itemId) else { return }
        let count = itemsDict[itemToBeUpdate] ?? 0
        itemsDict[itemToBeUpdate] = count + 1
    }
    
    func removeItem(_ itemId: Int) {
        guard let itemToBeUpdate = getItem(from: itemId) else { return }
        let count = itemsDict[itemToBeUpdate] ?? 0
        guard count > 0 else { return }
        itemsDict[itemToBeUpdate] = count - 1
    }
    
    private func getItem(from id: Int) -> Item? {
        return itemsDict.keys.first(where: { $0.id.hashValue == id })
    }
    
    private func notify() {
        observers.forEach {
            $0.basketObserver?.onChange(itemsDict: itemsDict)
        }
    }
}
