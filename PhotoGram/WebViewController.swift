//
//  WebViewController.swift
//  PhotoGram
//
//  Created by 선상혁 on 2023/08/29.
//

import UIKit
import WebKit


class WebViewController: UIViewController, WKUIDelegate {
    
    var webView: WKWebView!
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myURL = URL(string:"https://www.apple.com")
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
    }
    
    func reloadButtonPressed() {
        webView.reload()
    }
    
    func goBackButtonPressed() {
        if webView.canGoBack {
            webView.goBack()
        }
    }
    
    func goForwardButtonPressed() {
        if webView.canGoForward {
            webView.goForward()
        }
    }

}
