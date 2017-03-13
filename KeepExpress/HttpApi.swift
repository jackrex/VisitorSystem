//
//  HttpApi.swift
//  KeepExpress
//
//  Created by jackrex on 11/1/2017.
//  Copyright © 2017 jackrex. All rights reserved.
//

import UIKit
import Alamofire

class HttpApi: NSObject {

    static let host = "http://10.2.3.203:9998"
    
    static func fullPath(path : String) -> String {
        return host + path
    }
    
    
}
