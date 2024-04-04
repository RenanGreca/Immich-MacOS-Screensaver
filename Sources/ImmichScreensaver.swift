// The Swift Programming Language
// https://docs.swift.org/swift-book
// 
// Swift Argument Parser
// https://swiftpackageindex.com/apple/swift-argument-parser/documentation

import ArgumentParser
import Progress

@main struct ImmichScreensaver: AsyncParsableCommand {
    mutating func run() async throws {
        let config = try await ImmichScreensaverOptions.loadFrom(source: .path("options.pkl"))
        let api = try await ImmichAPI.loadFrom(source: .path("immichAPI.pkl"))
        
        let people = try await getPeople(names: config.includePeople, api: api)
        var page: String? = "1"
        var assets: [Asset] = []

        while (page != nil) {
            print("Searching page \(page!)")
            let searchBody = Search.SearchSmart(
                isFavorite: nil,
                isArchived: nil,
                isVisible: nil,
                page: page,
                personIds: [people.first!.id],
                size: nil,
                takenAfter: nil,
                takenBefore: nil,
                type: "IMAGE",
                query: "string"
            )
            let results = try await Search.searchSmart(body: searchBody, api: api)
            assets.append(contentsOf: results.assets.items)
            page = results.assets.nextPage
        }

//        let person = people.first!
//        let assets = try await Asset.getPersonAssets(person: person, api: api)
        print("Found \(assets.count) assets.")
        var progressBar = ProgressBar(count: assets.count)
        for asset in assets {
            // e.g. /upload/library/admin/2023/2023-01/abc.jpg
            // testable
            let path = asset.originalPath.split(separator: "/").dropFirst().joined(separator: "/")
            
            //testable
            let fullPath = config.uploadLocation+path

            //testable
            let outputStructure = asset.originalPath.split(separator: "/").dropFirst(3).dropLast().joined(separator: "/")

            //testable
            let outputPath = config.uploadLocation+"screensaver/"+outputStructure

            Shell.mkdir(path: outputPath)

            //testable
            let target = outputPath+"/"+asset.originalFileName

            Shell.ln(source: fullPath, target: target)

            progressBar.next()
        }

        print("Cleaning up...")
        let outputPath = config.uploadLocation+"screensaver/"
        Shell.dot_clean(path: outputPath)
    }

    func getPeople(names: [String]?, api: ImmichAPI.Module) async throws -> [Person] {
        guard let names = names else {
            return []
        }

        var people: [Person] = []
        for name in names {
            let results = try await Person.searchPerson(name: name, api: api)
            let person = results.first!
            people.append(person)
        }
        return people
    }
}
