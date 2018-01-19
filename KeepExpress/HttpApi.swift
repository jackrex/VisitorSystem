//
//  HttpApi.swift
//  KeepExpress
//
//  Created by jackrex on 11/1/2017.
//  Copyright © 2017 jackrex. All rights reserved.
//

import UIKit
import Moya

enum HttpApi {
    case getEmployeeWithName(String)
    case getEmployeeWithPhone(String)
    case sendMessageWithParam(Dictionary<String, Any>)
    case vistorWithParam(Dictionary<String, Any>)
    
}

extension HttpApi : TargetType {
    /// The target's base `URL`.
    var baseURL: URL {
        return URL.init(string: "http://10.2.3.202:9998")!
    }
    
    /// The path to be appended to `baseURL` to form the full `URL`.
    var path: String {
        switch self {
        case .getEmployeeWithName(_):
            return "/employee/query"
        case .getEmployeeWithPhone(let phone):
            return "/employee/phone/\(phone)"
        case .sendMessageWithParam(_):
            return "/save/express"
        case .vistorWithParam(_):
            return "/visitor"
        }
    }
    
    /// The HTTP method used in the request.
    var method: Moya.Method {
        switch self {
        case .sendMessageWithParam(_), .vistorWithParam(_):
            return .post
        default:
            return .get
        }
    }
    static let host = "http://10.2.3.202:9998"
    
    /// The parameters to be incoded in the request.
    var parameters: [String: Any]? {
        switch self {
        case .sendMessageWithParam(let dic), .vistorWithParam(let dic):
            return dic
        case .getEmployeeWithName(let name):
            return ["name": name]
        default:
            return nil
        }
    }
    
    /// The method used for parameter encoding.
    var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }
    
    /// Provides stub data for use in testing.
    var sampleData: Data {
        return "".data(using: String.Encoding.utf8)!
    }
    
    /// The type of HTTP task to be performed.
    var task: Task {
        return .request
    }
    /// Whether or not to perform Alamofire validation. Defaults to `false`.
    var validate: Bool {
        return false
    }
    
}
