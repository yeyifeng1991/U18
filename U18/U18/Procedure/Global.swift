//
//  Global.swift
//  U18
//
//  Created by 叶义峰 on 2019/8/28.
//  Copyright © 2019 叶子. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher
import SnapKit
import MJRefresh

//MARK:应用默认颜色
extension UIColor{
    
    /*
     在方法的func关键字之前加上关键字static或者class都可以用于指定类方法.
     不同的是用class关键字指定的类方法可以被子类重写, 如下:
     
     */
    class var background: UIColor {
        return UIColor(red: 242, green: 242, blue: 242, alpha: 1)
    }
    
    class var theme: UIColor {
        return UIColor(red: 29, green: 221, blue: 43, alpha: 1)
    }
    
}

extension String{
    static let searchHistoryKey = "searchHistory"
    static let sexTypeKey = "sexTypeKey"
}

extension Notification.Name{
  static let USexTypeDidChange = Notification.Name("USexTypeDidChange")
}


