import Foundation

extension URL {
    func makeEmptyFile() throws {
        try FileManager().createDirectory(at: deletingLastPathComponent(), withIntermediateDirectories: true)
        try Data().write(to: self, options: .atomic)
    }

    func append(_ line: String) throws {
        let fileHandle = try FileHandle(forUpdating: self)
        fileHandle.seekToEndOfFile()
        let data = Data("\(line)\n".utf8)
        fileHandle.write(data)
        try fileHandle.close()
    }

    static var logFilesDirectory: URL {
        URL(fileURLWithPath: #filePath)
            .deletingLastPathComponent()
            .deletingLastPathComponent()
            .appendingPathComponent("LogFiles")
    }
}
