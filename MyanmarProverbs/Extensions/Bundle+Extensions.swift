//
//  Bundle+Extensions.swift
//  MyanmarProverbs
//
//  Created by Dylan on 12/02/2025.
//

import Foundation

extension Bundle {
    func decodeJsonFile<T: Decodable>(_ fileName: String) throws -> T {
        guard let fileUrl = Bundle.main.url(forResource: fileName, withExtension: ".json") else {
            throw FileDecodingError.fileNotFound
        }
        guard let fileData = try? Data(contentsOf: fileUrl) else {
            throw FileDecodingError.invalidData
        }
        guard let decodedObject = try? JSONDecoder().decode(T.self, from: fileData) else {
            throw FileDecodingError.decodingFailed
        }
        return decodedObject
    }
}
