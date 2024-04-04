//
//  Asset.swift
//
//
//  Created by Renan Greca on 04/04/24.
//

import Foundation

struct Assets: Decodable {
    let count: Int
    let items: [Asset]
    let nextPage: String?
}

struct Asset: Identifiable, Decodable {
    let id: String
    let type: String
    let originalFileName: String
    let originalPath: String

    static func getPersonAssets(person: Person, api: ImmichAPI.Module) async throws -> [Asset] {
        guard let url = URL(string: api.endpoint + "/person/\(person.id)/assets") else {
            fatalError("Invalid URL")
        }
        let data = try await sendRequest(url: url, api: api)

        let decodedAssets = try JSONDecoder().decode([Asset].self, from: data)
        return decodedAssets
    }
}
