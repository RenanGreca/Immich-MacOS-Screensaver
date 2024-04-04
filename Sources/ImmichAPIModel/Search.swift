//
//  Search.swift
//
//
//  Created by Renan Greca on 04/04/24.
//

import Foundation

struct Search: Decodable {

    let albums: Albums
    let assets: Assets

    struct SearchSmart: Codable {
        let isFavorite: Bool?
        let isArchived: Bool?
        let isVisible: Bool?
        let page: String?
        let personIds: [String]?
        let size: Int?
        let takenAfter: String?
        let takenBefore: String?
        let type: String?
        let query: String

    }

    static func searchSmart(body: SearchSmart, api: ImmichAPI.Module) async throws -> Search {
        guard let url = URL(string: api.endpoint + "/search/smart") else {
            fatalError("Invalid URL")
        }

        let data = try await sendPostRequest(url: url, body: body, api: api)

        let decodedAssets = try JSONDecoder().decode(Search.self, from: data)
        return decodedAssets
    }
}
