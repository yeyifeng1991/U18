//
//  UNavigationController.swift
//  U18
//
//  Created by 叶子 on 2019/9/27.
//  Copyright © 2019 叶子. All rights reserved.
//

import UIKit

class UNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        
//        https://www.jianshu.com/p/6241293c3c75 检测手势是否有值 没有添加手势可以返回
        guard let interactiveGes = interactivePopGestureRecognizer else { return  }
        guard let targetView = interactiveGes.view else { return  }
        guard let internalTargets = interactiveGes.value(forKey: "targets") as? [NSObject] else { return  }
        guard let internalTarget = internalTargets.first?.value(forKey: "target") else { return }
        let action = Selector(("handleNavigationTransition"))
        
        let fullScreenGesture = UIPanGestureRecognizer(target: internalTarget, action: action)
        fullScreenGesture.delegate = self as? UIGestureRecognizerDelegate
        targetView.addGestureRecognizer(fullScreenGesture)
        interactiveGes.isEnabled = false

    }
    
//     push控制器的时候隐藏下部tab栏
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if viewControllers.count > 0  {
            viewController.hidesBottomBarWhenPushed = true
        }
        super .pushViewController(viewController, animated: animated)
    }

}

extension UNavigationController: UIGestureRecognizerDelegate {
    
  //开始进行手势识别时调用的方法，返回NO则结束识别，不再触发手势，用处：可以在控件指定的位置使用手势识别
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
//        userInterfaceLayoutDirection 状态条的方向
        let isLeftToRight = UIApplication.shared.userInterfaceLayoutDirection == .leftToRight
        guard let ges = gestureRecognizer as? UIPanGestureRecognizer else { return true }
        if ges.translation(in: gestureRecognizer.view).x * (isLeftToRight ? 1 : -1) <= 0 || disablePopGesture
         {
//            || disablePopGesture
            return false
        }
        return viewControllers.count != 1;
    }
}

extension UNavigationController{
  
    override var preferredStatusBarStyle: UIStatusBarStyle {
        guard let topVC = topViewController else { return .lightContent }
        return topVC.preferredStatusBarStyle
    }
}

enum UNavigationBarStyle {
    case theme
    case clear
    case white
}

extension UINavigationController{
    
    private struct AssociatedKeys{
      static  var disablePopGesture: Void?
    }
    
    var disablePopGesture: Bool {
        get{
           return objc_getAssociatedObject(self, &AssociatedKeys.disablePopGesture) as? Bool ?? false
            
        }
        set{
            objc_setAssociatedObject(self, &AssociatedKeys.disablePopGesture, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    func barStyle(_ style: UNavigationBarStyle){
        switch style {
        case .theme:
//barStyle 导航栏的颜色
            navigationBar.barStyle = .black
            navigationBar.setBackgroundImage(UIImage(named: "nav_bg"), for: .default)
            navigationBar.shadowImage = UIImage()
        case .clear:
            navigationBar.barStyle = .black
            navigationBar.setBackgroundImage(UIImage(), for: .default)
            navigationBar.shadowImage = UIImage()
        case .white:
            navigationBar.barStyle = .default
//            navigationBar.setBackgroundImage(UIColor.white.image(), for: .default)
            navigationBar.shadowImage = nil
        }
        
        
     }
 }


