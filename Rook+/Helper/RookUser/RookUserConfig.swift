//
//  RookUserConfig.swift
//  RookPlus
//
//  Created by Delmwin Baeka on 3/15/19.
//  Copyright © 2019 Delmwin Baeka. All rights reserved.
//

import Foundation
/**
 RookUserConfig class, let you declare your `RookUserConfig` Configs before setup
 
 RookUserConfig Object:
 ==================
 - timeout: Double
 - retrylogin: Boolean that indicates if the should save the user password encrypted and use it when server returns 401
 - loginStrategy: A login strategy see `RookUserLoginStrategy` ( user defined functions for login ), if empty the default one will be used
 - signupStrategy: A signup strategy see `RookUserSignupStrategy` ( user defined functions for signup ), if empty the default one will be used
 - logoutStrategy: A logout strategy see `RookUserLogoutStrategy` ( user defined functions for logout: called on logout or on user not authorized ), if empty the default one will be used
 
 */
public class RookUserConfig {
    
    var timeout : TimeInterval
    var retrylogin : Bool
    var loginStrategy : RookUserLoginStrategy
    var signupStrategy : RookUserSignupStrategy
    var logoutStrategy : RookUserLogoutStrategy
    
    public init(timeout:Double = 10.0, retrylogin:Bool = true, loginStrategy: RookUserLoginStrategy = RookUserDefaultLoginStrategy(), signupStrategy: RookUserSignupStrategy = RookUserDefaultSignupStrategy(), logoutStrategy: RookUserLogoutStrategy = RookUserDefaultLogoutStrategy()) {
        self.timeout = timeout
        self.retrylogin = retrylogin
        self.loginStrategy = loginStrategy
        self.signupStrategy = signupStrategy
        self.logoutStrategy = logoutStrategy
    }
}

/**
 Protocol RookUserLoginStrategy
 
 you should extend this protocol for your custom login strategy
 */
public protocol RookUserLoginStrategy {
    /// override for login, you can use the default one like this
    ///     RookUserDefaultLoginStrategy().login(...)
    func login(email: String, password: String, completion: @escaping RookUser.RookUserCompletion)
    /// override for social login, you can use the default one like this
    ///     RookUserDefaultLoginStrategy().socialLogin(...)
    func socialLogin(to: RookUser.socialTypes, token: String, completion: @escaping RookUser.RookUserCompletion)
}

/**
 Protocol RookUserSignupStrategy
 
 you should extend this protocol for your custom signup strategy
 */
public protocol RookUserSignupStrategy {
    /// override for signup, you can use the default one like this
    ///     RookUserDefaultSignupStrategy().signup(...)
    func signup(email: String, password: String, completion: @escaping RookUser.RookUserCompletion)
}

/**
 Protocol RookUserLogoutStrategy
 
 you should extend this protocol for your custom logout strategy
 */
public protocol RookUserLogoutStrategy {
    /// Function called when the user is not authorized
    /// usually you should logout the user here
    func notAuthorized()
    /// Function called onlogout
    /// usually you invalidate personal user settings
    func logout()
}

public class RookUserDefaultLoginStrategy: RookUserLoginStrategy {
    public init(){}
    
    public func login(email: String, password: String, completion: @escaping RookUser.RookUserCompletion) {
        assert(email != "" && password != "", "Email or password for user login cannot be empty")
        RookUser.shared.post(url: "/login.php", parameters: ["email": email, "password":password, "firebaseToken": RookUser.getAppcode()!, "type": "email"], completion: { (success, data, error) in
            if success {
                if RookUser.getConfig().retrylogin { RookUser.saveUserPass(pass: password) }
                RookUser.shared.user = RookUserModel.init(withDictionary: data as! [String:AnyObject], pushToken: RookUser.shared.user.pushToken, pushEnabled:RookUser.shared.user.pushEnabled)
                RookUser.saveCurrentUser()
            }
            completion(success, data, error)
        })
    }
    
    public func socialLogin(to: RookUser.socialTypes, token: String, completion: @escaping RookUser.RookUserCompletion) {
        assert(token != "", "Token for social login cannot be empty")
        RookUser.shared.post(url: "/social/"+to.rawValue, parameters: ["oauth_token": token, "oauth_secret": token], completion: { (success, data, error) in
            if success {
                if RookUser.getConfig().retrylogin { RookUser.saveUserPass(pass: token) }
                RookUser.shared.user = RookUserModel.init(withDictionary: data as! [String:AnyObject], pushToken: RookUser.shared.user.pushToken, pushEnabled:RookUser.shared.user.pushEnabled, socialLogin:true, socialType: to.rawValue)
                RookUser.saveCurrentUser()
            }
            completion(success,data,error)
        })
    }
}

public class RookUserDefaultSignupStrategy : RookUserSignupStrategy {
    public init(){}
    
    public func signup(email: String, password: String, completion: @escaping RookUser.RookUserCompletion) {
        assert(email != "" && password != "", "Email or password for user creation cannot be empty")
        RookUser.shared.post(url: "/user", parameters: ["email" : email, "password" : password], completion: {
            (success, data, error) in
            if success {
                RookUser.shared.user = RookUserModel.init(withDictionary: data as! [String:AnyObject])
                RookUser.saveCurrentUser()
            }
            completion(success, data, error)
        })
    }
}

public class RookUserDefaultLogoutStrategy : RookUserLogoutStrategy {
    public init(){}
    
    public func notAuthorized() {
        print("NEED TO IMPLEMENT NOT AUTHORIZED CUSTOM ACTION")
    }
    public func logout() {
        RookUser.deleteCurrentUser()
    }
}
