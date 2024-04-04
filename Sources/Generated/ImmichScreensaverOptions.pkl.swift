// Code generated from Pkl module `ImmichScreensaverOptions`. DO NOT EDIT.
import PklSwift

public enum ImmichScreensaverOptions {}

extension ImmichScreensaverOptions {
    public struct Module: PklRegisteredType, Decodable, Hashable {
        public static var registeredIdentifier: String = "ImmichScreensaverOptions"

        public var includeAlbums: [String]?

        public var excludeAlbums: [String]?

        /// People (faces) to be
        public var includeFaces: [String]?

        public var excludeFaces: [String]?

        public var startDate: Date?

        public var endDate: Date?

        public var uploadLocation: String

        public init(
            includeAlbums: [String]?,
            excludeAlbums: [String]?,
            includeFaces: [String]?,
            excludeFaces: [String]?,
            startDate: Date?,
            endDate: Date?,
            uploadLocation: String
        ) {
            self.includeAlbums = includeAlbums
            self.excludeAlbums = excludeAlbums
            self.includeFaces = includeFaces
            self.excludeFaces = excludeFaces
            self.startDate = startDate
            self.endDate = endDate
            self.uploadLocation = uploadLocation
        }
    }

    public struct Date: PklRegisteredType, Decodable, Hashable {
        public static var registeredIdentifier: String = "ImmichScreensaverOptions#Date"

        public var day: Int

        public var month: Int

        public var year: Int

        public init(day: Int, month: Int, year: Int) {
            self.day = day
            self.month = month
            self.year = year
        }
    }

    /// Load the Pkl module at the given source and evaluate it into `ImmichScreensaverOptions.Module`.
    ///
    /// - Parameter source: The source of the Pkl module.
    public static func loadFrom(source: ModuleSource) async throws -> ImmichScreensaverOptions.Module {
        try await PklSwift.withEvaluator { evaluator in
            try await loadFrom(evaluator: evaluator, source: source)
        }
    }

    /// Load the Pkl module at the given source and evaluate it with the given evaluator into
    /// `ImmichScreensaverOptions.Module`.
    ///
    /// - Parameter evaluator: The evaluator to use for evaluation.
    /// - Parameter source: The module to evaluate.
    public static func loadFrom(
        evaluator: PklSwift.Evaluator,
        source: PklSwift.ModuleSource
    ) async throws -> ImmichScreensaverOptions.Module {
        try await evaluator.evaluateModule(source: source, as: Module.self)
    }
}