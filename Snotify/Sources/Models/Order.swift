//Copyright © 2019 Snotify. All rights reserved.

import Foundation

struct Order: Decodable {
    let totalPrice: String
    let currency: String
    let customer: Customer?

    enum CodingKeys: String, CodingKey {
        case totalPrice = "total_price"
        case currency
        case customer
    }
    
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        totalPrice = try values.decode(String.self, forKey: .totalPrice)
//        currency = try values.decode(String.self, forKey: .currency)
//        customer = try values.decode(Customer.self, forKey: .customer)
//    }
}
