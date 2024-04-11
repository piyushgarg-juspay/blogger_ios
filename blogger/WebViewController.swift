//
//  WebViewController.swift
//  blogger
//
//  Created by piyush garg on 22/12/23.
//

import SwiftUI
import UIKit
import WebKit
import LocalAuthentication

//class WebViewController: UIViewController, WKNavigationDelegate {
//    @State private var isUnlocked = false
//    
//    var webView: WKWebView!
//    
//    func auth() {
//        let context = LAContext()
//        context.localizedCancelTitle = "Enter Username/Password"
//        var error: NSError?
//        
//        // Check for biometric authentication
//        // permissions
//        let permissions = context.canEvaluatePolicy(
//            .deviceOwnerAuthentication,
//            error: &error
//        )
//        
//        if permissions {
//            let reason = "Log in with Face ID"
//            context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason) { success, authenticationError in
//                        // authentication has now completed
//                        if success {
//                            self.isUnlocked = true;
//                        } else {
//                            self.isUnlocked = false;
//                        }
//                        
//                    }
//        }
//        else {
//            self.isUnlocked = false;
//            // Handle permission denied or error
//        }
//    }
//
//    
//    override func loadView() {
//        webView = WKWebView()
//        webView.navigationDelegate = self
//        view = webView
//    }
//    
//    override func viewDidLoad() {
//        if(isUnlocked) {
//            print("Unlocked")
//            super.viewDidLoad()
//            let url = URL(string: "https://blogger.com")!
//            webView.load(URLRequest(url: url))
//        }
//        else {
//            auth();
//            print("Locked")
//        }
//    }
//
//}
//
//struct WebView_UI: UIViewControllerRepresentable {
//    func makeUIViewController(context: Context) -> some UIViewController {
//        let vc = WebViewController()
//        return vc
//    }
//    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
//        
//    }
//}

struct WebView: UIViewRepresentable {
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        let url = URL(string: "https://blogger.com")!
        webView.load(URLRequest(url: url))
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        // This space can be left blank
    }
}

struct WebView_UI: View {
    @State private var isUnlocked = false
    
    func auth() {
        let context = LAContext()
        context.localizedCancelTitle = "Enter Username/Password"
        var error: NSError?

        // Check for biometric authentication
        // permissions
        let permissions = context.canEvaluatePolicy(
            .deviceOwnerAuthentication,
            error: &error
        )

        if permissions {
            let reason = "Log in with Face ID"
            context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason) { success, authenticationError in
                        // authentication has now completed
                        if success {
                            isUnlocked = true;
                        } else {
                            isUnlocked = false;
                        }

                    }
        }
        else {
            isUnlocked = false;
            // Handle permission denied or error
        }
    }
    
    var body: some View {
        VStack {
            if isUnlocked {
                WebView()
            } else {
                Text("Can't authenticate. Please retry again.")
                Button(action: auth) {
                    Text("Sign In")
                }
            }
        }
        .onAppear(perform: auth)
    }
}

#Preview {
    WebView_UI()
}
