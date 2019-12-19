//Copyright © 2019 Snotify. All rights reserved.

import Foundation

struct APIClient {
    static let shared = APIClient()
    let standardUrl = "https://{apiKey}:{password}@{shop}.myshopify.com/admin/api/2019-10"
    
    func getOrders(for shop: Shop, limit: Int? = nil, success: @escaping (Data) -> Void, failure: @escaping (Error) -> Void) {
        let baseUrl = standardUrl.replaceOccurrences(
            of: ["{apiKey}", "{password}", "{shop}"],
            with: [shop.apiKey, shop.password, shop.uniqueName]
        )

        var ordersUrlPath = "\(baseUrl)/orders.json"
        if let limit = limit {
            ordersUrlPath.append("?limit=\(limit)&status=any&fulfillment_status=any")
        }
        guard let ordersUrl = URL(string: ordersUrlPath) else { return }

        URLSession.shared.dataTask(with: ordersUrl) { (data, response, error) in
            if let error = error {
                failure(error)
            } else if let data = data  {
                success(data)
            }
        }.resume()
    }
    
}
