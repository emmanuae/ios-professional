//
//  AppDelegate.swift
//  Bankey
//
//  Created by E A on 15/08/22.
//

import UIKit

let appColor:UIColor = .systemTeal

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    let loginViewController = LoginViewController()
    let obcViewController = ObcViewController()
    let dummyViewController = DummyViewController()
    let mainViewController = MainViewController()
    
    func application(_ application: UIApplication,didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemBackground
        
        loginViewController.delegate = self
        obcViewController.delegate = self
        dummyViewController.logoutDelegate = self
        
        window?.rootViewController = mainViewController
   
        mainViewController.selectedIndex = 0
        return true
    }

}

extension AppDelegate:LoginViewControllerDelegate {
    func didLogin() {
        if LocalState.hasOnboarded {
            setRootViewController(dummyViewController)
        }else {
            setRootViewController(obcViewController)
        }

    }
}
extension AppDelegate:ObcViewControllerDelecate {
    func didFinishOnboarding() {
        
        LocalState.hasOnboarded = true
        setRootViewController(dummyViewController)
    }
}
extension AppDelegate: LogoutDelegate {
    func didLogout() {
       
        setRootViewController(loginViewController)
    }
}

extension AppDelegate {
    func setRootViewController(_ vc:UIViewController,animated:Bool = true) {
        guard animated, let window = self.window else {
            self.window?.rootViewController = vc
            self.window?.makeKeyAndVisible()
            return
        }
        window.rootViewController = vc
        window.makeKeyAndVisible()
        UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: nil, completion: nil)
    }
    
}
