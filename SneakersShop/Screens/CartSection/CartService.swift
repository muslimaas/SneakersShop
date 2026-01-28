//
//  CartService.swift
//  SneakersShop
//
//  Created by Muslima Sandybay on 22.01.2026.
//

import Foundation

final class CartService {

    static let shared = CartService()
    private init() {}

    private(set) var items: [CartItem] = []

    func add(item: CatalogItem) {
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            items[index].quantity += 1
        } else {
            let cartItem = CartItem(
                id: item.id,
                title: item.sneakers,
                description: item.description,
                price: item.price,
                image: item.image,
                quantity: 1
            )
            items.append(cartItem)
        }
    }

    func add(itemId: String) {
        if let index = items.firstIndex(where: { $0.id == itemId }) {
            items[index].quantity += 1
        }
    }

    func remove(itemId: String) {
        guard let index = items.firstIndex(where: { $0.id == itemId }) else { return }

        if items[index].quantity > 1 {
            items[index].quantity -= 1
        } else {
            items.remove(at: index)
        }
    }

    func removeCompletely(itemId: String) {
        guard let index = items.firstIndex(where: { $0.id == itemId }) else { return }
        items.remove(at: index)
    }

    func isInCart(id: String) -> Bool {
        items.contains { $0.id == id }
    }

    func quantity(for id: String) -> Int {
        items.first(where: { $0.id == id })?.quantity ?? 0
    }

    func totalCount() -> Int {
        items.reduce(0) { $0 + $1.quantity }
    }

    func totalPrice() -> Int {
        items.reduce(0) { $0 + $1.price * $1.quantity }
    }

    func clear() {
        items.removeAll()
    }
}
