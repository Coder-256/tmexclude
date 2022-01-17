import Foundation
import ArgumentParser

let toolVersion = "1.0.0"

@main
struct TMExclude: ParsableCommand {
    static var configuration = CommandConfiguration(commandName: "tmexclude", version: toolVersion)

    enum ExcludedStatus: String, EnumerableFlag {
        case included, excluded

        static func name(for value: ExcludedStatus) -> NameSpecification {
            return .shortAndLong
        }
    }

    @Flag(help: "Flag the item to be included or excluded in backups.")
    var excludedStatus: ExcludedStatus

    @Argument(help: "Path to a file/folder.", completion: .file())
    var path: [String]

    func run() throws {
        var lastError: Error? = nil
        for currentPath in path {
            do {
                var url = URL(fileURLWithPath: currentPath)
                var resourceValues = URLResourceValues()
                resourceValues.isExcludedFromBackup = (excludedStatus == .excluded)
                try url.setResourceValues(resourceValues)
            } catch {
                if let errorDescription = lastError?.localizedDescription {
                    fputs("Error: \(errorDescription)\n", stderr)
                }
                lastError = error
            }
        }
        if let lastError = lastError {
            throw lastError
        }
    }
}
