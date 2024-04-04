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

    static func searchPerson(name: String, api: ImmichAPI.Module) async throws -> [Person] {
        guard let url =
            URL(string: api.endpoint + "/search/person")?
            .appending(queryItems: [
                URLQueryItem(name: "name", value: name)
            ])
        else {
            fatalError("Invalid URL")
        }
        
        let data = try await sendRequest(url: url, api: api)
        let decodedPerson = try JSONDecoder().decode([Person].self, from: data)
        return decodedPerson
    }
}

struct People: Decodable {
    let people: [Person]

    static func getAllPeople(api: ImmichAPI.Module) async throws -> People {
        guard let url = URL(string: api.endpoint + "/person") else {
            fatalError("Invalid URL")
        }
        let data = try await sendRequest(url: url, api: api)

        let decodedPeople = try JSONDecoder().decode(People.self, from: data)
        return decodedPeople
    }
}
