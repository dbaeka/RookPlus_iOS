//
//  RookCryption.swift
//  RookPlus
//
//  Created by Delmwin Baeka on 3/16/19.
//  Copyright © 2019 Delmwin Baeka. All rights reserved.
//

import Cryptor

public enum RookCryption {
    
    private static let rounds: UInt32 = 10000
    
    /// Encrypt data using password and return encrypted data.
    public static func encrypt(password: String, withKey key: String) throws -> Data {
        precondition(password != "")
        let encryptionSalt = try Random.generate(byteCount: FormatV3.saltSize)
        let hmacSalt = try Random.generate(byteCount: FormatV3.saltSize)
        let iv = try Random.generate(byteCount: FormatV3.ivSize)
        
        let encryptionKey = try PBKDF.deriveKey(fromPassword: key, salt: encryptionSalt , prf: .sha1, rounds: rounds, derivedKeyLength: FormatV3.keySize)
        let hmacKey = try PBKDF.deriveKey(fromPassword: key, salt: hmacSalt, prf: .sha1, rounds: rounds, derivedKeyLength: FormatV3.keySize)
        let preamble = [FormatV3.formatVersion, UInt8(1)]
        
        var header = preamble
        header.append(contentsOf: encryptionSalt)
        header.append(contentsOf: hmacSalt)
        header.append(contentsOf: iv)
        
        let hmac = HMAC(using: .sha256, key: hmacKey)
        let engine = try Cryptor(operation: .encrypt, algorithm: .aes128, options: .pkcs7Padding, key: encryptionKey, iv: iv)
        
        let firstPass = (engine.update(string: password)?.final())!
        let secondPass = (hmac.update(byteArray: firstPass)?.final())!
        
        header.append(contentsOf: firstPass)
        header.append(contentsOf: secondPass)
        
        return CryptoUtils.data(from: header)
    }
    
    
    /// Decrypt data using password and return decrypted data. Throws if
    /// password is incorrect or ciphertext is in the wrong format.
    /// - throws `Error`
    public static func decrypt(data: Data, withKey key: String) throws -> Data {
        let header = data.subdata(in: 0..<FormatV3.passwordHeaderSize)
        let body = data.subdata(in: FormatV3.passwordHeaderSize..<data.count)
        guard FormatV3.canDecrypt(preamble: header) else {
            throw Error.unknownHeader
        }
        guard header[1] == 1 else {
            throw Error.invalidCredentialType
        }
        let encryptionSalt = byteArray(from: header.subdata(in: Range(2...9)))
        let hmacSalt =  byteArray(from: header.subdata(in: Range(10...17)))
        let iv =  byteArray(from: header.subdata(in: Range(18...33)))
        
        let encryptionKey = try PBKDF.deriveKey(fromPassword: key, salt: encryptionSalt , prf: .sha1, rounds: rounds, derivedKeyLength: FormatV3.keySize)
        let hmacKey = try PBKDF.deriveKey(fromPassword: key, salt: hmacSalt, prf: .sha1, rounds: rounds, derivedKeyLength: FormatV3.keySize)
        
        let hmac = HMAC(using: .sha256, key: hmacKey)
        let engine = try Cryptor(operation: .decrypt, algorithm: .aes128, options: .pkcs7Padding, key: encryptionKey, iv: iv)
        
        let capacity = body.count - FormatV3.hmacSize
        let firstPass = body.subdata(in: 0..<capacity)
        let passData = (engine.update(data: firstPass)?.final())!
        let secondPass = byteArray(from: body.subdata(in: capacity..<body.count))
        let hmacPass = (hmac.update(data: firstPass)?.final())!
        guard hmacPass == secondPass else {
            throw Error.hmacMismatch
        }
        return CryptoUtils.data(from: passData)
    }
}


public extension RookCryption {
    /// V3 format settings
    public final class FormatV3 {
        /// Size of AES and HMAC keys
        public static let keySize: UInt = UInt(Cryptor.Algorithm.aes256.defaultKeySize)
        
        /// Size of PBKDF2 salt
        public static let saltSize = 8
        
        static let formatVersion = UInt8(3)
        static let ivSize = Cryptor.Algorithm.aes128.blockSize
        static let keyHeaderSize = 1 + 1 + Cryptor.Algorithm.aes128.blockSize
        static let passwordHeaderSize = 1 + 1 + 8 + 8 + Cryptor.Algorithm.aes128.blockSize
        static let hmacSize = HMAC.Algorithm.sha256.digestLength()
        
        fileprivate static func canDecrypt(preamble: Data) -> Bool {
            assert(preamble.count >= 1)
            return preamble[0] == 3
        }
    }
    
    /// Errors thrown by `RookCryption`.
    public enum Error: Int, Swift.Error {
        /// Ciphertext was corrupt or password was incorrect.
        /// It is not possible to distinguish between these cases in the v3 data format.
        case hmacMismatch = 1
        
        /// Unrecognized data format. Usually this means the data is corrupt.
        case unknownHeader = 2
        
        /// Memory allocation failure. This should never happen.
        case memoryFailure
        
        /// A password-based decryptor was used on a key-based ciphertext, or vice-versa.
        case invalidCredentialType
    }
    
    public static func byteArray(from: Data) -> [UInt8] {
        return from.map { value in
            return value
        }
    }
}
