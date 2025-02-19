//
//  Decryptable.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/4/10.
//  Copyright © 2024-2025 RakuyoKit. All rights reserved.
//

import Foundation

import CryptoSwift
import RAKCodable
import RAKCore

// MARK: - DecryptResult

/// Decryption result.
public enum DecryptResult<T: Codable> {
    /// Decryption failed.
    case decryptFailure(error: Error)
    
    /// Decryption succeeded.
    case success(result: T)

    /// When decrypting Data type data, conversion to base64 Data failed.
    case toBase64DataFailure
    
    /// Decryption succeeded, but type transformation failed.
    case transformFailure
}

// MARK: - Decryptable

/// Provides decryption capability.
public protocol Decryptable {
    /// The AES instance for decryption.
    var aes: AES { get set }

    /// Decrypts encrypted data.
    /// - Parameters:
    ///   - value: The encrypted data to decrypt.
    ///   - type: type of data
    /// - Returns: The decryption result. See `DecryptResult` for details.
    func decrypt<T: RAKCodable>(_ value: String, type: T.Type) -> DecryptResult<T.DecodeType>
}

extension Decryptable {
    public func decrypt<T: RAKCodable>(_ value: String, type _: T.Type) -> DecryptResult<T.DecodeType> {
        guard let decodedData = Data(base64Encoded: value) else {
            return .toBase64DataFailure
        }

        do {
            let decryptResult = try decodedData.decrypt(cipher: aes)

            if let result = decryptResult as? T.DecodeType {
                return .success(result: result)
            }

            if let resutl = T.decodeJSON(from: decryptResult) {
                return .success(result: resutl)
            }

            return .transformFailure

        } catch {
            return .decryptFailure(error: error)
        }
    }
}
