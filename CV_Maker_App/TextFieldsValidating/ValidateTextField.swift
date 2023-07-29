//
//  Validate.swift
//  CV_Maker_App
//
//  Created by Dmitriy Mkrtumyan on 27.07.23.
//

import Foundation

final class ValidateTextField {
    static func isContainsDigits(in text: String) -> Bool {
        let regex = "[0-9]+"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        let isValid = predicate.evaluate(with: text)
        return !isValid
    }
    
    static func isContainsCharacters(in text: String) -> Bool {
        let allowedCharacters = CharacterSet.decimalDigits
        let charachtersSetFromText = CharacterSet(charactersIn: text)
        return allowedCharacters.isSuperset(of: charachtersSetFromText)
    }
}
