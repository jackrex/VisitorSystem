//
//  Utils.swift
//  KeepExpress
//
//  Created by jackrex on 29/12/2016.
//  Copyright © 2016 jackrex. All rights reserved.
//

import UIKit

class Utils: NSObject {
    class func layerColor() -> UIColor {
        return UIColor.init(colorLiteralRed: 66/255.0, green: 56/255.0, blue: 70/255.0, alpha: 1)
    }
    
    class func screenWidth() -> CGFloat {
        return UIScreen.main.applicationFrame.size.width
    }
    
    class func screenHeight() -> CGFloat {
        return UIScreen.main.applicationFrame.size.height
    }
}
