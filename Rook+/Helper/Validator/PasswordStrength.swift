//
//  PasswordStrength.swift
//  RookPlus
//
//  Created by Delmwin Baeka on 3/19/19.
//  Copyright © 2019 Delmwin Baeka. All rights reserved.
//

import Foundation
import UIKit

/// Strength of password types.
/// Evaluated using information theory entropy
public enum PasswordStrength: String {
    /// Entropy < 28
    case veryWeak = "Very Weak"
    /// 28 <= Entropy <=  35
    case weak = "Weak"
    /// 36 <= Entopy <= 59
    case reasonable = "Okay"
    /// 60 <= Entropy <= 127
    case strong = "Strong"
    /// Entropy > 127
    case veryStrong = "Very Strong"
    
    var color: UIColor {
        switch self {
        case .veryWeak:
            return UIColor.red
        case .weak:
            return UIColor.orange
        case .reasonable:
            return UIColor.white
        case .strong:
            return UIColor(hexString: "#87F58C")
        case .veryStrong:
            return UIColor(hexString: "#6EEA74")        }
    }
}


extension Validator {
    
    public static func strength(ofPassword password: String?) -> PasswordStrength {
        return passwordStrength(forEntropy: entropy(of: password))
    }
    
    private static func entropy(of string: String?) -> Float {
        guard let string = string, string.count > 0 else {
            return 0
        }
        
        var includesLowerCaseCharacter = false,
        includesUpperCaseCharacter = false,
        includesDecimalDigitCharacter = false,
        inclusesPunctuationCharacter = false,
        includesSymbolCharacter = false,
        includesWhitespaceCharacter = false,
        includesNonBaseCharacter = false,
        isInDictionary = false
        
        var sizeOfCharacters: Float = 0
        
        string.enumerateSubstrings(in: string.startIndex ..< string.endIndex, options: .byComposedCharacterSequences) { substring, _, _, _ in
            guard let unicodeScalars = substring?.first?.unicodeScalars.first else {
                return
            }
            
            if !includesLowerCaseCharacter && CharacterSet.lowercaseLetters.contains(unicodeScalars) {
                includesLowerCaseCharacter = true
                sizeOfCharacters += 26
            }
            
            if !includesUpperCaseCharacter && CharacterSet.uppercaseLetters.contains(unicodeScalars) {
                includesUpperCaseCharacter = true
                sizeOfCharacters += 26
            }
            
            if !includesDecimalDigitCharacter && CharacterSet.decimalDigits.contains(unicodeScalars) {
                includesDecimalDigitCharacter = true
                sizeOfCharacters += 10
            }
            
            if !includesSymbolCharacter && CharacterSet.symbols.contains(unicodeScalars) {
                includesSymbolCharacter = true
                sizeOfCharacters += 10
            }
            
            if !inclusesPunctuationCharacter && CharacterSet.punctuationCharacters.contains(unicodeScalars) {
                inclusesPunctuationCharacter = true
                sizeOfCharacters += 20
            }
            
            if !includesWhitespaceCharacter && CharacterSet.whitespacesAndNewlines.contains(unicodeScalars) {
                includesWhitespaceCharacter = true
                sizeOfCharacters += 1
            }
            
            if !includesNonBaseCharacter && CharacterSet.nonBaseCharacters.contains(unicodeScalars) {
                includesNonBaseCharacter = true
                sizeOfCharacters += 32 + 128
            }
        }
        
        if !isInDictionary && UIReferenceLibraryViewController.dictionaryHasDefinition(forTerm: string.lowercased().trimmingCharacters(in: CharacterSet.lowercaseLetters.inverted)) {
            isInDictionary = true
            sizeOfCharacters += 50
        }
        
        return log2f(sizeOfCharacters) * Float(string.count)
    }
    
    private static func passwordStrength(forEntropy entropy: Float) -> PasswordStrength {
        if entropy < 28 {
            return .veryWeak
        } else if entropy < 36 {
            return .weak
        } else if entropy < 60 {
            return .reasonable
        } else if entropy < 128 {
            return .strong
        } else {
            return .veryStrong
        }
    }
}
