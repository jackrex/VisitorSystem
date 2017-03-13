//
//  MainView.swift
//  KeepExpress
//
//  Created by jackrex on 29/12/2016.
//  Copyright © 2016 jackrex. All rights reserved.
//

import UIKit

class MainView: UIView {

    override func awakeFromNib() {
        super.awakeFromNib()
        let image = Info.imageByScalingAndCropping(for: CGSize(width:Utils.screenWidth() * 2,height:Utils.screenHeight() * 2), sourceImage: UIImage.init(named: "bg")!)
        self.backgroundColor = UIColor.init(patternImage: image!)
        
    }

}
