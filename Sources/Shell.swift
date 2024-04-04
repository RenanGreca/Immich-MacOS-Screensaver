//
//  Shell.swift
//
//
//  Created by Renan Greca on 04/04/24.
//

import Foundation

struct Shell {
    static func mkdir(path: String) {
        do {
            let mkdir = Process()
            mkdir.executableURL = URL(fileURLWithPath: "/usr/bin/env")
            mkdir.arguments = ["mkdir", "-p", path]
//            print(mkdir.arguments!.joined(separator: " "))
            try mkdir.run()
            mkdir.waitUntilExit()
        } catch {
            fatalError("Error creating directories: \(error)")
        }
    }


    static func ln(source: String, target: String) {
        do {
            let ln = Process()
            ln.executableURL = URL(fileURLWithPath: "/usr/bin/env")
            ln.arguments = ["ln", "-s", source, target]
//            print(ln.arguments!.joined(separator: " "))
            try ln.run()
            ln.waitUntilExit()
        } catch {
            fatalError("Error creating symbolic link: \(error)")
        }
    }

    static func dot_clean(path: String) {
        do {
            let dot_clean = Process()
            dot_clean.executableURL = URL(fileURLWithPath: "/usr/bin/env")
            dot_clean.arguments = ["dot-clean", "-m", path]
//            print(dot_clean.arguments!.joined(separator: " "))
            try dot_clean.run()
            dot_clean.waitUntilExit()
        } catch {
            fatalError("Error cleaning dotflies: \(error)")
        }
    }
}
