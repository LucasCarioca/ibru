//
// Created by Lucas Desouza on 12/21/21.
//

import Foundation

struct Sugar: Codable, Hashable {
    var id: Int
    var name: String
    var gravityPerPound: Double
    var approved: Bool

    private enum CodingKeys : String, CodingKey {
        case gravityPerPound = "gravity_per_pound", id, name, approved
    }
}
