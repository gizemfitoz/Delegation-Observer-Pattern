import Foundation
import UIKit

enum ItemType {
    case book
    case notebook
    case pencil
    
    var image: UIImage {
        switch self {
        case .book:
            return UIImage(named: "book")!
        case .notebook:
            return UIImage(named: "notebook")!
        case .pencil:
            return UIImage(named: "pencil")!
        }
    }
}

struct Item: Hashable {
    var id: UUID
    var type: ItemType
    var price: Int
    
    init(type: ItemType, price: Int) {
        self.id = UUID()
        self.type = type
        self.price = price
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(type)
    }
}
