//
//  WebViewController.swift
//  mebel
//
//  Created by Dima Chibuk on 7/21/21.
//  Copyright © 2021 DS. All rights reserved.
//

import Foundation
import UIKit
import WebKit
import SwiftUI
import Alamofire

class WebViewController: UIViewController, WKNavigationDelegate {
    
    @IBOutlet weak var dialogStack: UIStackView!
    @IBOutlet weak var dialogName: UILabel!
    
    @IBOutlet weak var cancelStack: UIStackView!
    @IBOutlet weak var cancelName: UILabel!
    
    @IBOutlet weak var webView:WKWebView!;
    
    public static var payData:EPOS.EposPayData!
    public static var sum:Float = 0
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeIcons()
        
    }
    
    
    func makeIcons(){
        
        dialogName.text = "ОПЛАТА"
        dialogName.textColor = Colors.hexStringToUIColor(hex: Colors.appColor)
        
        dialogStack.layoutMargins = Paddings.plus15
        dialogStack.isLayoutMarginsRelativeArrangement = true
        dialogStack.layer.cornerRadius = 20
        dialogStack.layer.shadowColor = Colors.hexStringToUIColor(hex: Colors.appColor).cgColor
        dialogStack.layer.shadowOffset = CGSize(width: 0, height: 3)
        dialogStack.layer.shadowOpacity = 0.7
        dialogStack.layer.shadowRadius = 4.0
        dialogStack.layer.masksToBounds = false
        
        cancelStack.layoutMargins = Paddings.plus10
        cancelStack.isLayoutMarginsRelativeArrangement = true
        cancelStack.layer.cornerRadius = 15
        cancelStack.layer.shadowColor = Colors.hexStringToUIColor(hex: Colors.appColor4).cgColor
        cancelStack.layer.shadowOffset = CGSize(width: 3, height: 3)
        cancelStack.layer.shadowOpacity = 0.7
        cancelStack.layer.shadowRadius = 4.0
        cancelStack.layer.masksToBounds = false
        
        let tapCancel = UITapGestureRecognizer(target: self,
                                                action: #selector(cancelDialog(_:)))
        tapCancel.numberOfTapsRequired = 1;
        cancelStack.addGestureRecognizer(tapCancel)
        cancelStack.isUserInteractionEnabled = true
        
        //UserDefaults.standard.register(defaults: ["UserAgent": URLs.getStaticUserAgent()])
        webView.navigationDelegate = self
        webView.configuration.preferences.javaScriptEnabled = true
        
        let url = WebViewController.payData.paymentUrl.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
        let urlRequset = URL(string: url!)
        let request = URLRequest(url: urlRequset!)
        webView.load(request)
    }
    
    @objc func cancelDialog(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        ProgressBar.show()
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        ProgressBar.dismiss()
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Swift.Void) {
        let url = webView.url?.absoluteString
        if url != nil {
            if url!.starts(with: EPOS.errorUrl){
                DialogMessage.show(viewController: BasketActivity.context, title: "Ошибка", message: "Произошла неизвестаная ошибка!")
                decisionHandler(.cancel)
                cancelDialog(self)
                return
            } else if url!.starts(with: EPOS.successUrl){
                BasketActivity.checkPay(id: WebViewController.payData.id, sum: WebViewController.sum)
                decisionHandler(.cancel)
                cancelDialog(self)
                return
            }
        }
        decisionHandler(.allow)
    }
    
}
