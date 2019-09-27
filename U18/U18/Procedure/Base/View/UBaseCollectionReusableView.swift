//
//  UBaseCollectionReusableView.swift
//  U18
//
//  Created by 叶子 on 2019/9/27.
//  Copyright © 2019 叶子. All rights reserved.
//

import Foundation
import Reusable
// UICollectionView
class UBaseCollectionReusableView: UICollectionReusableView, Reusable {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func configUI() {}
}
