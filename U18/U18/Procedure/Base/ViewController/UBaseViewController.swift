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
    
    func configNavigationBar()   {
//         guard let 判断 就不执行了
        /*
         visibleViewController 当前显示的控制器
         topViewController 是某个导航栈的栈顶视图
     visibleViewController跟导航栈没有关系，只是当前显示的控制器，也就是说任意一个导航的visibleViewController所返回的值应该是一样的,
         
         */
        
        guard let navi = navigationController else { return  }
        if navi.visibleViewController == self{
            
        }
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    @objc  func pressBack()  {
        navigationController?.popViewController(animated: true)
    }
    
    func configUI() {}

}

extension UBaseViewController{
    override var preferredStatusBarStyle: UIStatusBarStyle
        {
        return .lightContent
    }
}
