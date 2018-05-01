//
//  Validation.swift
//  Test
//
//  Created by monika on 15/02/18.
//  Copyright © 2017 Monika. All rights reserved.
//

import UIKit
import EZSwiftExtensions

extension String {
    
    enum FieldType : String{
        
        case fullName = "name"
        case email = "email"
        case password = "password"
        case info = ""
        case mobile = "contact number"
        case cardNumber = "card number"
        case cvv = "CVV"
        case zip = "pin code"
        case amount = "amount"
        case country = "country"
        case nationality = "nationality"
        case dateOfBirth = "date of birth"
        case fromDate = "from date"
        case toDate = "to date"
        case about = "about me"
        case cases = "cases"
        case title = "title"
        case desc = "description"
        case language = "language"
        case firstName = "firstname"
        case lastName = "lastname"
        case destination = "destination"
        case groupSize = "Group size"
        case proposal = "proposal"
        case bid = "bid amount"
        case paymentType = "payment type"
        case otp = "OTP"
        case travellersInfo = "travellers info"
        case expiry = "expiry date"
        case welcomeMessage = "welcome message"
    }
    
    enum Status : String {
        
        case empty = "Please enter "
        case allSpaces = "Enter the "
        case valid
        case inValid = " Please enter a valid "
        case allZeros = "Please enter a valid "
        case hasSpecialCharacter = " can only contain A-z, a-z characters only"
        case notANumber = " must be a number "
        case emptyCountrCode = "Enter country code "
        case mobileNumberLength = " Phone Number should be of at least 6 - 15 number"
        case pwd = "Password length should be between 6-15 characters"
        case pinCode = "PinCode length should be 6 characters long"
        case zip = "Pincode should not contain special characters"
        //        case dob = "date of birth "
        case notSelected = "Please choose "
        case nameLength = "Name length should be 25 characters long"
        case digitsOnly = "Mobile number should contain digits only"
        case cannotBeZero = " can not be zero"
        
        //  case addressLength = ""
        func message(type : FieldType) -> String? {
            
            switch self {
            case .hasSpecialCharacter: return type.rawValue + rawValue
            case .valid: return nil
            case .emptyCountrCode: return rawValue
            case .pwd
                : return rawValue
            case .mobileNumberLength : return rawValue
            case .pinCode , .zip : return rawValue
            case .digitsOnly : return rawValue
            case .cannotBeZero :  return type.rawValue + rawValue
            case .nameLength : return rawValue
            default: return rawValue + type.rawValue
            }
        }
    }
    
    //MARK:- valation function
    func login(email : String? , password : String? ) -> Bool {
        if isValid(type: .email, info: email) && isValid(type: .password, info: password) {
            return true
        }
        return false
    }
   
    func isValid(type : FieldType , info: String?) -> Bool {
        guard let validStatus = info?.handleStatus(fieldType : type) else {
            return true
        }
        let errorMessage = validStatus
        print(errorMessage)
        Alerts.shared.show(alert: .alert, message: errorMessage , type : .info)
        return false
    }
    
   
    
    func handleStatus(fieldType : FieldType) -> String? {
        
        switch fieldType {
        case .firstName , .lastName,  .fullName:
            return  isValidName.message(type: fieldType)
        case .email  :
            return  isValidEmail.message(type: fieldType)
        case .password:
            return  isValid(password: 6, max: 15).message(type: fieldType)
        case .info:
            return  isValidInformation.message(type: fieldType)
        case .mobile:
            return  isValidPhoneNumber.message(type: fieldType)
        case .cardNumber:
            return  isValidCardNumber(length: 16).message(type: fieldType)
        case .cvv:
            return  isValidCVV.message(type: fieldType)
        case .zip:
            return  isValidZipCode.message(type: fieldType)
        case .amount:
            return  isValidAmount.message(type: fieldType)
        case .cases :
            return isValidCase.message(type: fieldType)
        case .destination ,.paymentType:
            return isValidAddress.message(type: fieldType)
        case .dateOfBirth :
            return  isValidDob.message(type: fieldType)
        case .groupSize :
            return isValidGroupSize.message(type: fieldType)
        case .otp :
            return isValidOTP.message(type: fieldType)
        case .expiry :
            return isValidExpiry.message(type: fieldType) case  .country   , .nationality,.about,.fromDate ,.toDate, .title,.desc,.language, .proposal,.bid,.travellersInfo,.welcomeMessage:
                return  isValidInformation.message(type: fieldType)
        }
    }
    
    
    
    var isNumber : Bool {
        if let _ = NumberFormatter().number(from: self) {
            return true
        }
        return false
    }
    
    var hasSpecialCharcters : Bool {
        
        return rangeOfCharacter(from: CharacterSet.alphanumerics.inverted) != nil
    }
    
    var hasOnlyLetterAndSpaces : Bool {
        let set = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLKMNOPQRSTUVWXYZ ")
        return (rangeOfCharacter(from: set.inverted) != nil)
    }
    var hasOnlyDigit : Bool {
        let set = CharacterSet(charactersIn: "1234567890")
        return (rangeOfCharacter(from: set.inverted) != nil)
    }
    
    var isEveryCharcterZero : Bool{
        var count = 0
        self.characters.forEach {
            if $0 == "0"{
                count += 1
            }
        }
        if count == self.characters.count{
            return true
        }else{
            return false
        }
    }
    
    
    
    public func toString(format: String , date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: date)
    }
    
    public var length: Int {
        return self.characters.count
    }
    
    
    
    public var isEmail: Bool {
        let dataDetector = try? NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
        let firstMatch = dataDetector?.firstMatch(in: self, options: NSRegularExpression.MatchingOptions.reportCompletion, range: NSRange(location: 0, length: length))
        return (firstMatch?.range.location != NSNotFound && firstMatch?.url?.scheme == "mailto")
    }
    
    public var isBlank: Bool {
        get {
            let trimmed = trimmingCharacters(in: .whitespacesAndNewlines)
            return trimmed.isEmpty
        }
    }
    
    func isValid(password min: Int , max: Int) -> Status {
        if length < 0 { return .empty }
        if isBlank  { return .allSpaces }
        if  characters.count >= min && characters.count <= max {
            return .valid
        }
        return .pwd
    }
    
    var isValidEmail : Status {
        if length < 0 { return .empty }
        if isBlank { return .allSpaces }
        if length > 0 {
            if !isEmail { return .inValid }
        }
        return .valid
    }
    
    var isValidGroupSize : Status {
        if length < 0 { return .empty }
        if isBlank { return .allSpaces }
        if length > 3 { return .inValid }
        if self == "0" { return .cannotBeZero}
        return .valid
    }
    var isValidOTP : Status {
        if length < 0 { return .empty }
        if isBlank { return .allSpaces }
        // if length > 2 { return .inValid }
        return .valid
    }
    var isValidInformation : Status {
        if length < 0 { return .empty }
        if isBlank { return .allSpaces }
        return .valid
    }
    var isValidAddress : Status {
        if length < 0 { return .empty }
        //  if length > 50 { return .empty}
        if isBlank { return .notSelected }
        return .valid
    }
    var isValidDob : Status {
        if length < 0 { return .empty }
        if isBlank { return .allSpaces }
        if self.compare2date(date2 : Date().toString()) { return .inValid}
        return .valid
    }
    
    
    
    
    func compare2date(date2 : String) -> Bool{
        let dateformat = DateFormatter()
        dateformat.dateFormat = "dd/MM/yyyy"
        let dateSelected = dateformat.date(from: self) ?? Date()
        let todayDate = dateformat.date(from: date2) ?? Date()
        
        if dateSelected >= todayDate {
            return true
        }
        
        return false
    }
    
    
    
    var isValidCase : Status {
        if (self.toInt() ?? 0) <= 0 { return .notSelected }
        return .valid
    }
    
    
    var isValidExtension : Status {
        if hasSpecialCharcters { return .hasSpecialCharacter }
        if self.characters.count < 6  && isNumber { return .valid }
        if self.characters.count == 0 { return .valid }
        return .inValid
    }
    
    var isValidPhoneNumber : Status {
        if length <= 0 { return .empty }
        if isBlank { return .allSpaces }
        if isEveryCharcterZero { return .allZeros }
        if hasOnlyDigit { return .digitsOnly }
        if characters.count >= 6 && self.characters.count <= 15 { return .valid
        }else{
            return .mobileNumberLength
        }
    }
    
    var isValidName : Status {
        if length < 0 { return .empty }
        if isBlank { return .allSpaces }
        if length > 25 {return .nameLength }
        if hasOnlyLetterAndSpaces { return .hasSpecialCharacter }
        return .valid
    }
    
    func isValidCardNumber(length max:Int ) -> Status {
        if length < 0 { return .empty }
        if isBlank { return .allSpaces }
        if hasSpecialCharcters { return .hasSpecialCharacter }
        if isEveryCharcterZero { return .allZeros }
        if characters.count >= 16 && characters.count <= max{
            return .valid
        }
        return .inValid
    }
    
    var isValidCVV : Status {
        if hasSpecialCharcters { return .hasSpecialCharacter }
        if isEveryCharcterZero { return .allZeros }
        if isNumber{
            if self.characters.count >= 3 && self.characters.count <= 4{
                return .valid
            }else{ return .inValid }
        }else { return .notANumber }
    }
    
    var isValidZipCode : Status {
        if length < 0 { return .empty }
        if isEveryCharcterZero { return .allZeros }
        if isBlank { return .allSpaces }
        if hasSpecialCharcters {return.zip}
        if length != 6 {return .pinCode}
        // if !isNumber{ return .notANumber }
        
        return .valid
    }
    
    var isValidAmount :  Status {
        if length < 0 { return .empty }
        if isBlank { return .allSpaces }
        if !isNumber{ return .notANumber }
        return .valid
    }
    var  isValidExpiry : Status {
        if let range = self.range(of: "/") {
            let year = self[range.upperBound...].trimmingCharacters(in: .whitespaces)
            let month = String(self.characters.prefix(2))
            let date = Date()
            let calendar = Calendar.current
            let yy = "\(calendar.component(.year, from: date))"
            let mm = calendar.component(.month, from: date)
            let compareYear = String(yy.characters.suffix(2))
            
            if /Int(year) < /Int(compareYear) || /Int(month) > 12{
                return .inValid
            }
            else if /Int(year) == /Int(compareYear) {
                if /Int(month) < mm && /Int(month) <= 12{
                    return .inValid
                }else {
                    return .valid
                }
            }
                
            else {
                return .valid
            }
        }
        return .valid
    }
}



