//
//  Album.swift
//
//
//  Created by Renan Greca on 04/04/24.
//

import Foundation

struct Albums: Decodable {
    let items: [Album]
}

struct Album: Identifiable, Decodable {
    let id: String
}
