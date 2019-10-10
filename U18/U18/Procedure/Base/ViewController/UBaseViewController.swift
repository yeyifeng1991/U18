//
//  UBaseViewController.swift
//  U18
//
//  Created by 叶子 on 2019/9/27.
//  Copyright © 2019 叶子. All rights reserved.
//

import Foundation
import SnapKit
import Then
import Reusable
import Kingfisher

class UBaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.background
        
        if #available(iOS 11.0, *) {
            UIScrollView.appearance().contentInsetAdjustmentBehavior = .never
        }else{
            automaticallyAdjustsScrollViewInsets = false;
        }
        
        configUI()
        
        
    }
    func configUI() {}

    func configNavigationBar() {
            //         guard let 判断 就不执行了
            //        guard语句判断其后的表达式布尔值为false时，才会执行之后代码块里的代码，如果为true，则跳过整个guard语句，我们举例来看看
            /*
             visibleViewController 当前显示的控制器
             topViewController 是某个导航栈的栈顶视图
             visibleViewController跟导航栈没有关系，只是当前显示的控制器，也就是说任意一个导航的visibleViewController所返回的值应该是一样的,
             
             */
            guard let navi = navigationController else { return }
            if navi.visibleViewController == self {
                navi.barStyle(.theme)
                navi.disablePopGesture = false
                navi.setNavigationBarHidden(false, animated: true)
                if navi.viewControllers.count > 1 {
//                    navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "nav_back_white"),
//                                                                       target: self,
//                                                                       action: #selector(pressBack))
                }
            }
  
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    @objc  func pressBack()  {
        navigationController?.popViewController(animated: true)
    }
    

}

extension UBaseViewController{
    override var preferredStatusBarStyle: UIStatusBarStyle
        {
        return .lightContent
    }
}
