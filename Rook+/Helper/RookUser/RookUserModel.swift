//
//  RookUserModel.swift
//  RookPlus
//
//  Created by Delmwin Baeka on 3/15/19.
//  Copyright © 2019 Delmwin Baeka. All rights reserved.
//


import Foundation

/**
 class BaasUser
 
 manages the `BaasBox` logged in user
 
 You can get the user data and manages it from here
 
 */
public class RookUserModel: NSObject, NSCoding {
    
    // MARK: Variables
    
    /// Session token from Rook+
    var token: String
//    /// User id from Rook+
//    var id : String
    var firebaseToken: String?
    /// Email
    var email : String
    /// Status of the user: ACTIVE, SUSPENDED
    //var status : String
    /// PushToken, saved here after the push notification are enabled
    var pushToken : String
    /// Bool checking if push notification are enabled
    var pushEnabled : Bool
    /// Bool for checking if is a social login
    var isSocialLogin: Bool
    /// String representing the social login
    var socialType : String
    
    init(auth : String = "", email: String = "", status: String = "", pushToken: String = "", pushEnabled: Bool = false, socialLogin:Bool = false, socialType: String = "") {
        self.token = auth
        self.email = email
     //   self.status = status
        self.pushToken = pushToken
        self.pushEnabled = pushEnabled
        self.isSocialLogin = socialLogin
        self.socialType = socialType
    }
    init(withDictionary dict: [String: AnyObject], pushToken: String = "", pushEnabled: Bool = false, socialLogin: Bool = false, socialType: String = "", token: String = "") {
        self.token = token == "" ? dict["jwt"] as! String : token
        let user = dict["user"] as! [String: AnyObject]
        self.email = user["email"] as! String
      //  self.status = user["status"] as! String
        self.firebaseToken = user["firebaseToken"] as? String
        self.pushToken = pushToken
        self.pushEnabled = pushEnabled
        self.isSocialLogin = socialLogin
        self.socialType = socialType
    }
    /**
     Decodes the saved object
     */
    required convenience public init?(coder aDecoder: NSCoder) {
        let token = aDecoder.decodeObject(forKey: "token") as! String
        let email = aDecoder.decodeObject(forKey: "email") as! String
   //     let status = aDecoder.decodeObject(forKey: "status") as! String
        let pushToken = aDecoder.decodeObject(forKey: "pushtoken") as! String
        let pushEnabled = aDecoder.decodeBool(forKey: "pushenabled")
        let social = aDecoder.decodeBool(forKey: "sociallogin")
        let socialType = aDecoder.decodeObject(forKey: "socialtype") as! String
        self.init(auth: token, email:email, status:"", pushToken: pushToken, pushEnabled:pushEnabled, socialLogin:social, socialType:socialType)
    }
    /**
     Encodes the saved object
     */
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(token, forKey: "token")
        aCoder.encode(email, forKey: "email")
       // aCoder.encode(status, forKey: "status")
        aCoder.encode(pushToken, forKey: "pushtoken")
        aCoder.encode(pushEnabled, forKey: "pushenabled")
        aCoder.encode(isSocialLogin, forKey: "sociallogin")
        aCoder.encode(socialType, forKey: "socialtype")
    }
    /**
     Returns a bool if the user is locally authenticated
     
     - return: Boolean for local authentication
     */
    public func isAuthenticated() -> Bool {
        return token != ""
    }
    
    // MARK: User Management
    
    /**
     Upload the saved user updates to the Rook+ server
     
     */
    public func update(completion: @escaping RookUser.RookUserCompletion) {
        RookUser.shared.put(url: "/me", parameters: [:], completion: { ( success, data, error ) in
            if success {
                RookUser.saveCurrentUser()
            }
            completion(success, data, error)
        })
    }
    
    /**
     Logout function, will call the function you pass in logoutStrategy on completion
     
     */
    public func logout(pushToken: String = "",completion: @escaping RookUser.RookUserCompletion ) {
        let url = pushToken == "" ? "/logout" : "/logout/"+pushToken
        RookUser.shared.post(url: url, parameters: [:], completion: { ( success, data, error ) in
            RookUser.getConfig().logoutStrategy.logout()
            completion(success, data, error)
        })
    }
    
    /**
     Refresh the saved data of the user from the server
     
     */
    public func refresh(completion: @escaping RookUser.RookUserCompletion ) {
        RookUser.shared.get(url: "/users/profile.php", parameters: [:], completion: { ( success, data, error ) in
            if success {
                RookUser.shared.user = RookUserModel.init(withDictionary: data as! [String:AnyObject], pushToken: RookUser.shared.user.pushToken, pushEnabled:RookUser.shared.user.pushEnabled, socialLogin: RookUser.shared.user.isSocialLogin, socialType: RookUser.shared.user.socialType, token: RookUser.shared.user.token)
                RookUser.saveCurrentUser()
            }
            completion(success, data, error )
        })
    }
    /**
     Change the user password.
     
     NOTE:
     =====
     
     Your session code will change
     
     - parameters:
     - from : Old password
     - to : New password
     */
    public func changePassword(from: String, to: String, completion: @escaping RookUser.RookUserCompletion) {
        RookUser.shared.put(url: "/me/password", parameters: ["old": from, "new" : to], completion: {( success, data, error ) in
            if success {
                RookUser.shared.login(email: RookUser.shared.user.email, password: to, completion: {(success, data, error) in
                    completion(success, data, error)
                })
            }
            completion(success, data, error )
        })
    }
    
    /**
     Link the user with a social login
     
     - parameters:
     - to: `RookUser.socialTypes`, the type of the social login
     - token: The token provided by the third party social sdk
     */
    public func link(to: RookUser.socialTypes, token: String, completion: @escaping RookUser.RookUserCompletion) {
        RookUser.shared.put(url: "/social/"+to.rawValue, parameters: ["oauth_token": token, "oauth_secret": token], completion: { (success, data, error) in
            completion(success,data,error)
        })
    }
    
    // MARK: Follow
    
    
    /**
     Follows a user
     
     - parameters:
     -username: The username of the user to follow
     */
    public func follow(username: String, completion: @escaping RookUser.RookUserCompletion) {
        RookUser.shared.post(url: "/follow/"+username, parameters: [:], completion: { (success, data, error) in
            completion(success,data,error)
        })
    }
    
    /**
     Unfollows a user
     
     - parameters:
     -username: The username of the user to unfollow
     */
    public func unfollow(username: String, completion: @escaping RookUser.RookUserCompletion) {
        RookUser.shared.delete(url: "/follow/"+username, parameters: [:], completion: { (success, data, error) in
            completion(success,data,error)
        })
    }
    
    /**
     Get the user follows
     
     */
    public func getFollows(completion: @escaping RookUser.RookUserCompletion) {
        RookUser.shared.get(url: "/following/"+self.email, parameters: [:], completion: { (success, data, error) in
            completion(success, data, error)
        })
    }
    
    /**
     Get the user followers
     
     */
    public func getFollowers(completion: @escaping RookUser.RookUserCompletion) {
        RookUser.shared.get(url: "/followers/"+self.email, parameters: [:], completion: { (success, data, error) in
            completion(success, data, error)
        })
    }
}
