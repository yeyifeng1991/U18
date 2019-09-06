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


// tag 测试使用
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

let screenWidth = UIScreen.main.bounds.width
let screenHeight = UIScreen.main.bounds.height

var topVC:UIViewController? {

    var resultVC:UIViewController?
    resultVC = _topVC(UIApplication.shared.keyWindow?.rootViewController)
    while resultVC?.presentationController != nil {
        resultVC = _topVC(resultVC?.presentedViewController)
    }
    return resultVC;

}

var isIphoneX:Bool{
    return UI_USER_INTERFACE_IDIOM() == .phone
        && (max(UIScreen.main.bounds.height, UIScreen.main.bounds.width) == 812
            || max(UIScreen.main.bounds.height, UIScreen.main.bounds.width) == 896)
    
}
/*
 当有返回值的方法未得到接收和使用时通常会出现图片中的提示：
 Result of call is unused
 在正式编译中不会影响编译结果，但是也妨碍代码的美观整洁，在方法上加上“@discardableResult”就可以取消这个警告
where Base : UIImageView Base 自带的基础属性
 
 */

extension Kingfisher where Base : UIImageView{
    @discardableResult
    public  func setImage(urlString:String?,placeHolder:Placeholder? = UIImage(named: "normal_placeholder_h")) -> RetrieveImageTask {
        return setImage(with: URL(string: urlString ?? ""),
                        placeholder: placeHolder,
                     options: [.transition(.fade(0.5))]
                         )
    }
}

extension Kingfisher where Base: UIButton {
    @discardableResult
    public func setImage(urlString: String?, for state: UIControl.State, placeholder: UIImage? = UIImage(named: "normal_placeholder_h")) -> RetrieveImageTask {
        return setImage(with: URL(string: urlString ?? ""),
                        for: state,
                        placeholder: placeholder,
                        options: [.transition(.fade(0.5))])
        
    }
}

/*
 ConstraintView  谁在做约束
 个 snp 属性的类型就是结构体 ConstraintViewDSL
 
 */
extension ConstraintView{
    var usnp:ConstraintAttributesDSL{
        if #available(iOS 11.0, *) {
            return self.safeAreaLayoutGuide.snp
        }
        else{
            return self.snp
        }
    }
    
}


extension UICollectionView{
    func  reloadData(animation :Bool = true) {
        if animation {
            reloadData()
        } else {
//             去掉隐式动画 解决刷新跳动
            UIView .performWithoutAnimation {
                reloadData()
            }
        }
    }
    
}

 //MARK: print
//MARK: print
func uLog<T>(_ message: T, file: String = #file, function: String = #function, lineNumber: Int = #line) {
    #if DEBUG
    let fileName = (file as NSString).lastPathComponent
    print("[\(fileName):funciton:\(function):line:\(lineNumber)]- \(message)")
    #endif
}

 //MARK:  私有函数

private func _topVC(_ vc:UIViewController?) -> UIViewController? {
    
    if vc is UINavigationController{
        return _topVC((vc as? UINavigationController)?.topViewController)
    }
    else if vc is UITabBarController{
        return _topVC((vc as? UITabBarController)?.selectedViewController)
    }
    return vc
    
    
}

