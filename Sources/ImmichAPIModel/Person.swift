//
//  Person.swift
//
//
//  Created by Renan Greca on 04/04/24.
//

import Foundation

struct Person: Identifiable, Decodable {
    let id: String
    let isHidden: Bool
    let name: String

    static func getBy(name: String, api: ImmichAPI.Module) async throws -> Person? {
        let people = try await People.getAllPeople(api: api)
        let person = people.people.first { item in
            item.name == name
        }
        return person
    }
}

struct People: Decodable {
    let people: [Person]

    static func getAllPeople(api: ImmichAPI.Module) async throws -> People {
        guard let url = URL(string: api.endpoint + "/person") else {
            fatalError("Invalid URL")
        }
        var request = URLRequest(url:url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue(api.key, forHTTPHeaderField: "x-api-key")
        let (data, response) = try await URLSession.shared.data(for: request)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            fatalError("Error performing HTTP request")
        }

        let decodedPeople = try JSONDecoder().decode(People.self, from: data)
        return decodedPeople
    }
}
