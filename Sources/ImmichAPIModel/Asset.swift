//
//  Asset.swift
//
//
//  Created by Renan Greca on 04/04/24.
//

import Foundation

struct Asset: Identifiable, Decodable {
    let id: String
    let type: String
    let originalFileName: String
    let originalPath: String

    static func getPersonAssets(person: Person, api: ImmichAPI.Module) async throws -> [Asset] {
        guard let url = URL(string: api.endpoint + "/person/\(person.id)/assets") else {
            fatalError("Invalid URL")
        }
        var request = URLRequest(url:url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue(api.key, forHTTPHeaderField: "x-api-key")

        let (data, response) = try await URLSession.shared.data(for: request)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            fatalError("Error performing HTTP request")
        }

        let decodedAssets = try JSONDecoder().decode([Asset].self, from: data)
        return decodedAssets
    }
}
