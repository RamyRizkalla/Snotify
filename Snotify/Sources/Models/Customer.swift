//Copyright © 2019 Snotify. All rights reserved.

import Foundation

struct Customer: Decodable {
    let firstName: String
    let lastName: String
    
    var fullName: String {
        return "\(firstName) \(lastName)"
    }
    
    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
    }
    
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        firstName = try values.decode(String.self, forKey: .firstName)
//        lastName = try values.decode(String.self, forKey: .lastName)
//    }
}
