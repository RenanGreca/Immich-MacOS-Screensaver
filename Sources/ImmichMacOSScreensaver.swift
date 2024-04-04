// The Swift Programming Language
// https://docs.swift.org/swift-book
// 
// Swift Argument Parser
// https://swiftpackageindex.com/apple/swift-argument-parser/documentation

import ArgumentParser
import Progress

@main struct ImmichMacOSScreensaver: AsyncParsableCommand {
    mutating func run() async throws {
        let config = try await ImmichScreensaverOptions.loadFrom(source: .path("pkl/config/options.pkl"))
        let api = try await ImmichAPI.loadFrom(source: .path("pkl/config/immichAPI.pkl"))


        let person = try await Person.getBy(name: config.includePeople!.first!, api: api)
        let assets = try await Asset.getPersonAssets(person: person!, api: api)
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
}
