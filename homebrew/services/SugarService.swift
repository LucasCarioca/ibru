//
// Created by Lucas Desouza on 12/21/21.
//

import Foundation
import SwiftUI

struct SugarServiceKey: EnvironmentKey {
    static let defaultValue = SugarService()
}

extension EnvironmentValues {
    var sugarService: SugarService {
        get {
            self[SugarServiceKey.self]
        }
        set {
            self[SugarServiceKey.self] = newValue
        }
    }
}

class SugarService {

    private final let apiUrl = "https://api.ibru.io/api/"
    private final let apiVersion = "v1"

    init() {}

    private func buildUrl(route: String, options: ApiOptions) -> URL? {
        guard let url = URL(string: "\(apiUrl)\(apiVersion)/\(route)?approved=\(options.approved)&audit_id=\(options.auditId)") else {
            print("Invalid URL")
            return nil
        }
        return url
    }

    public func getSugars() async -> [Sugar] {
        do {
            let options = ApiOptions(auditId: "666", approved: false)
            let url = buildUrl(route: "sugars", options: options)
            let (data, _) = try await URLSession.shared.data(from: url!)
            return try JSONDecoder().decode([Sugar].self, from: data)
        } catch {
            print("Invalid data \(error)")
            return []
        }
    }
}


private struct ApiOptions {
    var auditId: String
    var approved: Bool
}