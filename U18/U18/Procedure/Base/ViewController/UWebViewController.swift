//
//  UWebViewController.swift
//  U18
//
//  Created by 叶子 on 2019/9/27.
//  Copyright © 2019 叶子. All rights reserved.
//

import Foundation
import UIKit
import WebKit

class UWebViewController: UBaseViewController {
    var requeset : URLRequest!
    lazy var webView:WKWebView = {
        let ww  = WKWebView()
        ww.allowsBackForwardNavigationGestures = true
        ww.navigationDelegate = self;
        ww.uiDelegate = self;
        
      return ww
    }()
    
    lazy var progressView:UIProgressView = {
        let pw = UIProgressView()
        pw.trackImage = UIImage.init(named: "nav_bg")
        pw.progressTintColor = UIColor.white
        return pw;
        }()
    
    convenience init (url:String?){
        self.init()
        self.requeset = URLRequest(url: URL(string: url ?? "")!)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
        webView.load(requeset)
    }
    
    override func configUI() {
        view.addSubview(webView)
        webView.snp.makeConstraints{ $0.edges.equalTo(self.view.usnp.edges) }
        
        view.addSubview(progressView)
        progressView.snp.makeConstraints{
            $0.left.top.right.equalToSuperview()
            $0.height.equalTo(2)
        }
    }
    
    override func configNavigationBar() {
        super.configNavigationBar()
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "nav_reload"),
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(reload))
    }
    
    @objc func reload(){
        webView.reload()
    }
    
    override func pressBack() {
        if webView.canGoBack {
            webView.goBack()
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
    
    deinit {
        webView.removeObserver(self, forKeyPath: "estimatedProgress")
    }
    
    
}

extension UWebViewController:WKNavigationDelegate,WKUIDelegate{
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
//         设置进度条的透明度
        if keyPath == "estimatedProgress" {
            progressView.isHidden = webView.estimatedProgress >= 1
            progressView.setProgress(Float(webView.estimatedProgress), animated: true)
            
        }
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
//         设置进度条的进度
        progressView.setProgress(0.0, animated: false)
        navigationItem.title = title ?? (webView.title ?? webView.url?.host)

    }
    
}

