//
//  WebViewController.swift
//  vk-login-geekbrains
//
//  Created by Aleksey on 13.05.2020.
//  Copyright © 2020 Aleksey Mikhlev. All rights reserved.
//
//
//  WebViewController.swift
//  vk-login-geekbrains
//
//  Created by Aleksey on 13.05.2020.
//  Copyright © 2020 Aleksey Mikhlev. All rights reserved.
//
import Alamofire
import Firebase
import UIKit
import WebKit

class WebViewController: UIViewController, WKNavigationDelegate {

    private var usersID = [FirebaseUser]()
    private let ref = Database.database().reference(withPath: "usersID")
    
    @IBOutlet weak var webview: WKWebView!{
        didSet{
            webview.navigationDelegate = self
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: self)

    }
    override func viewDidLoad() {
        super.viewDidLoad()

        var urlComponents = URLComponents()

        urlComponents.scheme = "https"
        urlComponents.host = "oauth.vk.com"
        urlComponents.path = "/authorize"
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: "7463799"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "scope", value: "262150"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "v", value: "5.68")
        ]

        let request = URLRequest(url: urlComponents.url!)
        webview.load(request)

    }

    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {

        guard let url = navigationResponse.response.url, url.path == "/blank.html", let fragment = url.fragment  else {
            decisionHandler(.allow)
            return
        }

        let params = fragment
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=") }
            .reduce([String: String]()) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
        }

        let token = params["access_token"]!
        let id = params["user_id"]!

        Session.instance.id = Int(id) ?? 0

        Session.instance.token = token
        let user = FirebaseUser(id: Session.instance.id)
        let userRef = self.ref.child(String(Session.instance.id))
        userRef.setValue(user.toAnyObject())


        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "TapBar") as! UITabBarController
        self.present(newViewController, animated: true, completion: nil)
        newViewController.modalPresentationStyle = .fullScreen

        print(Session.instance.token)

      //  let apiPhotos = "https://api.vk.com/method/photos.getAll?v=5.52&access_token=" + Session.instance.token

     //   let apiGroups = "https://api.vk.com/method/groups.get?v=5.52&access_token=" + Session.instance.token

        decisionHandler(.cancel)
    }
}

