//Copyright © 2019 Snotify. All rights reserved.

import Foundation

class OrdersListModel {
    private let recentOrderslimit = 5
    var ordersList: [Order] = []

    func orders(success: @escaping () -> Void, failure: @escaping (String) -> Void) {
        guard
            let shop = SelectedShop.shop,
            !shop.apiKey.isEmpty,
            !shop.password.isEmpty,
            !shop.uniqueName.isEmpty
        else {
            failure("shopify.orders.error-message.missing-fields".localized)
            return
        }

        APIClient.shared.getOrders(
            for: shop,
            limit: recentOrderslimit,
            success: { [weak self] data in
                do {
                    let response = try JSONDecoder().decode([String: [Order]].self, from: data)
                    self?.ordersList = response["orders"]!
                    success()
                } catch {
                    failure("global.error-message.unexpected-error".localized)
                }
            },
            failure: { error in
                let errorDescription = error.localizedDescription
                failure(errorDescription)
            }
        )
    }
}
