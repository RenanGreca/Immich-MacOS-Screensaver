//
//  Request.swift
//
//
//  Created by Renan Greca on 04/04/24.
//

import Foundation

func sendRequest(url: URL, api: ImmichAPI.Module) async throws -> Data {
    var request = URLRequest(url:url)
    request.setValue("application/json", forHTTPHeaderField: "Accept")
    request.setValue(api.key, forHTTPHeaderField: "x-api-key")
    let (data, response) = try await URLSession.shared.data(for: request)
    guard (response as? HTTPURLResponse)?.statusCode == 200 else {
        fatalError("Error performing HTTP request")
    }
    return data
}

func sendPostRequest(url: URL, body: Codable, api: ImmichAPI.Module) async throws -> Data {
    var request = URLRequest(url:url)
    request.setValue("application/json", forHTTPHeaderField: "Accept")
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.setValue(api.key, forHTTPHeaderField: "x-api-key")
    request.httpMethod = "POST"
    request.httpBody = try JSONEncoder().encode(body)
//    print(String(data: request.httpBody!, encoding: .utf8) ?? "Error decoding body")

    let (data, response) = try await URLSession.shared.data(for: request)
    guard (response as? HTTPURLResponse)?.statusCode == 200 else {
        fatalError("Error performing HTTP request")
    }
//    print(String(data: data, encoding: .utf8) ?? "Error decoding response")
    return data
}
