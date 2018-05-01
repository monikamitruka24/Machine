
//
//  Constants.swift
//  cozo
//
//  Created by Sierra 4 on 05/05/17.
//  Copyright © 2017 monika. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

enum Alert : String{
    case success = "Success"
    case oops = "Oops"
    case login = "Login Successfull"
    case ok = "Ok"
    case cancel = "Cancel"
    case error = "Error"
    case alert = "Alert"
}

infix operator =>
infix operator =|
infix operator =<
infix operator =*
infix operator =^
infix operator =~


typealias OptionalJSON = [String : JSON]?

func =>(key : ParamKeys, json : OptionalJSON) -> String?{
    return json?[key.rawValue]?.stringValue
}

func <=(key : ParamKeys, json : OptionalJSON) -> [String : JSON]?{
    return json?[key.rawValue]?.dictionaryValue
}

func =|(key : ParamKeys, json : OptionalJSON) -> [JSON]?{
    return json?[key.rawValue]?.arrayValue
}

func =*(key : ParamKeys, json : OptionalJSON) -> Int?{
    return json?[key.rawValue]?.intValue
}

func =^(key : ParamKeys, json : OptionalJSON) -> Bool? {
    return json?[key.rawValue]?.boolValue
}
func =~(key : ParamKeys, json : OptionalJSON) -> Float? {
    return json?[key.rawValue]?.floatValue
}

prefix operator /
prefix func /(value : String?) -> String {
    return value ?? ""
}
prefix func /(value : Bool?) -> Bool {
    return value ?? false
}
prefix func /(value : Int?) -> Int {
    return value ?? 0
}

prefix func /(value : Float?) -> Float {
    return value ?? 0.0
}
