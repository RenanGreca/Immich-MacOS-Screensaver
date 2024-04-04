// Code generated from Pkl module `ImmichAPI`. DO NOT EDIT.
import PklSwift

public enum ImmichAPI {}

extension ImmichAPI {
    public struct Module: PklRegisteredType, Decodable, Hashable {
        public static var registeredIdentifier: String = "ImmichAPI"

        public var key: String

        public var endpoint: String

        public init(key: String, endpoint: String) {
            self.key = key
            self.endpoint = endpoint
        }
    }

    /// Load the Pkl module at the given source and evaluate it into `ImmichAPI.Module`.
    ///
    /// - Parameter source: The source of the Pkl module.
    public static func loadFrom(source: ModuleSource) async throws -> ImmichAPI.Module {
        try await PklSwift.withEvaluator { evaluator in
            try await loadFrom(evaluator: evaluator, source: source)
        }
    }

    /// Load the Pkl module at the given source and evaluate it with the given evaluator into
    /// `ImmichAPI.Module`.
    ///
    /// - Parameter evaluator: The evaluator to use for evaluation.
    /// - Parameter source: The module to evaluate.
    public static func loadFrom(
        evaluator: PklSwift.Evaluator,
        source: PklSwift.ModuleSource
    ) async throws -> ImmichAPI.Module {
        try await evaluator.evaluateModule(source: source, as: Module.self)
    }
}