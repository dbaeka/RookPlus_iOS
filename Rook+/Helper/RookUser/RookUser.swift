//
//  RookUser.swift
//  RookPlus
//
//  Created by Delmwin Baeka on 3/15/19.
//  Copyright © 2019 Delmwin Baeka. All rights reserved.
//

import Foundation
import UserNotifications
import UIKit
import Cryptor


/// The `RookUser` class.
/// usage is as follows:
///
/// In your app delegate you should setup RookUser
///
///     let config = RookUserConfig()
///
/// Here you can declare some variables, See `RookUserConfig` for more data
///
///     RookUser.setup(url: "your url", appcode: "your appcode", config: config)
///
/// Now you are ready to user RookUser


public class RookUser {
        
    static let shared = RookUser()
    
    private var _user = RookUser.getSavedUser()
    
    var user: RookUserModel {
        get {
            guard let user = _user else { return RookUserModel() }
            return user
        }
        set {
            self._user = newValue
        }
    }
    
    internal var base_url : String?
    private var appcode : String?
    internal var config : RookUserConfig!
    
    private var version = "v0.0"
    
    
    private init() {}
    
    // MARK : Setters and Getters
    
    /**
     RookUser setup, call this function in your AppDelegate.
     
     RookUser Object:
     ==================
     - timeout: Double
     - retrylogin: Boolean that indicates if the should save the user password encrypted and use it when server returns 401
     - loginStrategy: A login strategy ( user defined functions for login ), if empty the default one will be used
     - signupStrategy: A signup strategy ( user defined functions for signup ), if empty the default one will be used
     - logoutStrategy: A logout strategy ( user defined functions for logout: called on logout or on user not authorized ), if empty the default one will be used
     
     - parameters:
     - url: Rook+ url
     - appcode: Rook+ Appcode
     - config : a RookUserConfig Object
     */
    public static func setup(url: String, appcode: String, config: RookUserConfig = RookUserConfig()) {
        precondition(shared.base_url == nil && shared.appcode == nil, "Cannot invoke setup, already done")
        precondition(url != "","missing url in setup")
        precondition(UIApplication.shared.canOpenURL(URL(string:url)!), "Setup url not valid")
        precondition(appcode != "", "missing appcode in setup")
        
        shared.base_url = url
        shared.appcode = appcode
        shared.config = config
    }
    
    /**
     Returns the appcode declared in setup.
     
     - return : appcode from setup
     
     */
    public static func getAppcode() -> String? {
        return self.shared.appcode
    }
    
    /**
     Returns the url declared in setup.
     
     - return : url from setup
     
     */
    public static func getBaseUrl() -> String? {
        return self.shared.base_url
    }
    
    /**
     Returns the config declared in setup.
     
     - return : A RookUserConfig object
     
     */
    public static func getConfig() -> RookUserConfig {
        return self.shared.config
    }
    
    internal func check() {
        precondition(base_url != nil && appcode != nil, "Setup not done, you must call RookUser.setup in your AppDelegate")
    }
    
    // MARK: User Management
    
    /**
     Login the user specified in the parameters
     
     - parameters:
     - username: The username of the user you want to login
     - password: The password of the user you want to login
     */
    public func login(email: String, password: String, completion: @escaping RookUserCompletion ) {
        check()
        self.config.loginStrategy.login(email: email, password: password, completion: {(success, data, error) in
            completion(success, data, error)
        })
    }
    
    /**
     Login the user specified in the parameters with the specified social platform
     
     - parameters:
     - to: The platform you want to login ( .facebook, .google )
     - token: The token that will be used for the login, you can get it via the third party sdks
     */
    public func socialLogin(to: socialTypes, id: String, completion: @escaping RookUserCompletion ) {
        self.config.loginStrategy.socialLogin(to: to, id: id, completion: {(success, data, error) in
            completion(success, data, error)
        })
    }
    
    /**
     Create a user with the specified data
     
     - parameters:
     - email: The email that will be used for the user
     - password: The password that will be used for the user
     
     */
    public func createUser(type: RookUser.signUpType, parameters: [String: Any], completion: @escaping RookUserCompletion ) {
        self.config.signupStrategy.signup(type: type, parameters: parameters, completion: {(success, data, error) in
            completion(success, data, error)
        })
    }
    
    /**
     Get the details of a specified user
     
     - parameters:
     - username: the username to fetch
     */
    public func getUser(parameters: [String: Any], completion: @escaping RookUserCompletion ) {
        assert(parameters["email"] as! String != "", "Email of user to fetch cannot be empty")
        post(url: "/auth/check_user.php", parameters: parameters, completion: { (success, data, error) in
            completion(success, data, error)
        })
    }
    /**
     Get a list of users
     
     - parameters:
     - parameters: Dictionary of query criteria
     */
    public func getUserList(parameters : [String:AnyHashable] = [:], completion: @escaping RookUserCompletion) {
        get(url: "/users", parameters: parameters, completion: { (success, data, error) in
            completion(success, data, error)
        })
    }
    /**
     Try reset password of the specified user
     
     Note
     ====
     
     The user need to have the "email" field in the visibleByTheUser dictionary
     
     - parameters:
     - email: the email to try reset
     */
    public func resetPassword(email: String, completion: @escaping RookUserCompletion) {
        assert(email != "", "Email of user to try reset password cannot be empty")
        get(url: "/user/"+email+"/password/reset", parameters: [:], completion: { (success, data, error) in
            completion(success, data, error)
        })
    }
    
    private static func getSavedUser() -> RookUserModel? {
        if let encodedUser = UserDefaults.standard.object(forKey: saved_rook_user) {
            guard let data = NSKeyedUnarchiver.unarchiveObject(with: encodedUser as! Data) as? Data else { return nil}
            do {
                let user = try PropertyListDecoder().decode(RookUserModel.self, from: data)
                return user
            } catch {
                return RookUserModel()
            }
        }
        return RookUserModel()
    }
    
    /**
     Saves the current stored user
     */
    public static func saveCurrentUser() {
        do {
            let data = try PropertyListEncoder().encode(RookUser.shared.user)
            let encodedUser = NSKeyedArchiver.archivedData(withRootObject: data)
            UserDefaults.standard.set(encodedUser, forKey: saved_rook_user)
        } catch{
            print("Save failed")
        }
    }
    /**
     Remove the current stored user
     */
    public static func deleteCurrentUser() {
        UserDefaults.standard.removeObject(forKey: saved_rook_user)
        UserDefaults.standard.removeObject(forKey: saved_rook_pass)
    }
    
    
    static let saved_rook_pass = "saved_rook_pass"
    
    /**
     Saves the current stored user pass encrypted
     */
    public static func saveUserPass(pass: String) {
        let key = UIDevice.current.identifierForVendor!.uuidString
        do {
            let encryptedPass = try RookCryption.encrypt(password: pass, withKey: key)
            UserDefaults.standard.set(encryptedPass, forKey: saved_rook_pass)
        } catch {
            print(error)
        }
        
    }
    
    internal static func getUserPass() -> String? {
        let key = UIDevice.current.identifierForVendor!.uuidString
        if let data = UserDefaults.standard.object(forKey: saved_rook_pass) {
            do {
                let datapass = try RookCryption.decrypt(data: data as! Data, withKey: key)
                let pass = String(data: datapass, encoding: .utf8)!
                return pass
            } catch {
                print(error)
                return nil
            }
        }
        return nil
    }
    
    
    // MARK: Follow
    
    /**
     Get the follows of a specified user
     
     - parameters:
     - username: the username to fetch
     */
    public func getFollows(email: String, completion: @escaping RookUserCompletion) {
        assert(email != "", "Email cannot be empty")
        get(url: "/following/"+email, parameters: [:], completion: { (success, data, error) in
            completion(success, data, error)
        })
    }
    /**
     Get the followers of a specified user
     
     - parameters:
     - username: the username to fetch
     */
    public func getFollowers(email: String, completion: @escaping RookUserCompletion) {
        assert(email != "", "Email cannot be empty")
        get(url: "/followers/"+email, parameters: [:], completion: { (success, data, error) in
            completion(success, data, error)
        })
    }
    
    // MARK: Documents
    
    /**
     Create a document on the specified collection
     
     - parameters:
     - inCollection: The collection where you want to create the document
     - body: Body of the document
     */
    public func createDocument(inCollection coll:String, body: [String: Any], completion: @escaping RookUserCompletion){
        assert(coll != "", "Collection name cannot be empty")
        post(url: "/document/"+coll, parameters: body, completion: { ( success, data, error ) in
            completion(success, data, error)
        })
    }
    
    /**
     delete a document on the specified collection
     
     - parameters:
     - fromCollection: The collection where you want to delete the document
     - id: id of the document
     */
    public func deleteDocument(fromCollection coll: String, id: String, completion:@escaping RookUserCompletion) {
        assert(coll != "" && id != "", "Collection name and id of document cannot be empty")
        delete(url: "/document/"+coll+"/"+id, parameters: [:], completion: { (success, data, error) in
            completion(success, data, error)
        })
    }
    
    /**
     Get a document/ a list of documents from the specified collection, you can pass query and pagination criteria
     
     - parameters:
     - fromCollection: The collection where you want to retrieve the document
     - withID: (Optional) the id of the document
     - parameters: (Optional) query criteria
     */
    public func getDocuments(fromCollection coll: String, withID id: String = "", parameters: [String: AnyHashable] = [:], completion: @escaping RookUserCompletion) {
        assert(coll != "", "Collection name cannot be empty")
        get(url: "/document/"+coll+(id != "" ? "/"+id : ""), parameters: parameters, completion: {(success, data, error) in
            completion(success, data, error)
        })
    }
    
    /**
     Get the number of documents from the specified collection, you can pass query and pagination criteria
     
     - parameters:
     - inCollection: The collection where you want to count the documents
     - parameters: (Optional) query criteria
     */
    public func countDocuments(inCollection coll: String, parameters: [String:AnyHashable] = [:], completion: @escaping RookUserCompletion) {
        assert(coll != "", "Collection name cannot be empty")
        get(url: "/document/"+coll+"/count", parameters: parameters, completion: {(success, data, error) in
            completion(success, data, error)
        })
    }
    /**
     update a document from the specified collection
     
     - parameters:
     - inCollection: The collection where you want to update the document
     - withID: the id of the document
     - body: (Optional) : new body of the document
     
     NOTE
     ====
     
     The whole document will be overwrited
     */
    public func updateDocument(inCollection coll: String, withID id: String, body: [String: Any], completion: @escaping RookUserCompletion) {
        assert(coll != "", "Collection name cannot be empty")
        put(url: "/document/"+coll+"/"+id, parameters: body, completion: {(success, data, error) in
            completion(success,data,error)
        })
    }
    
    /**
     Grant access to the specified user to the specified document
     
     - parameters:
     - toDocument: Id of the document
     - inCollection: Name of the collection
     - toUser: Username of the user
     - accessType: enumeration of types of access ( read, delete, all, update )
     */
    public func grantUserAccess(toDocument id: String, inCollection coll: String, toUser user: String, accessType: docAccessTypes, completion: @escaping RookUserCompletion) {
        assert(coll != "" && id != "" && user != "", "Collection name, id of document and username cannot be empty")
        put(url: "/document/"+coll+"/"+id+"/"+accessType.rawValue+"/user/"+user, parameters: [:], completion: {(success, data, error) in
            completion(success, data, error)
        })
    }
    
    /**
     Grant access to the specified role to the specified document
     
     - parameters:
     - toDocument: Id of the document
     - inCollection: Name of the collection
     - toRole: name of the role
     - accessType: enumeration of types of access ( read, delete, all, update )
     */
    public func grantRoleAccess(toDocument id: String, inCollection coll: String, toRole roleid: String, accessType: docAccessTypes, completion: @escaping RookUserCompletion) {
        assert(coll != "" && id != "" && roleid != "", "Collection name, id of document and role cannot be empty")
        put(url: "/document/"+coll+"/"+id+"/"+accessType.rawValue+"/role/"+roleid, parameters: [:], completion: {(success, data, error) in
            completion(success, data, error)
        })
    }
    
    /**
     Revoke access to the specified user to the specified document
     
     - parameters:
     - toDocument: Id of the document
     - inCollection: Name of the collection
     - toUser: Username of the user
     - accessType: enumeration of types of access ( read, delete, all, update )
     */
    public func revokeUserAccess(toDocument id: String, inCollection coll: String, toUser user: String, accessType: docAccessTypes, completion: @escaping RookUserCompletion) {
        assert(coll != "" && id != "" && user != "", "Collection name, id of document and username cannot be empty")
        delete(url: "/document/"+coll+"/"+id+"/"+accessType.rawValue+"/user/"+user, parameters: [:], completion: {(success, data, error) in
            completion(success, data, error)
        })
    }
    
    /**
     Revoke access to the specified role to the specified document
     
     - parameters:
     - toDocument: Id of the document
     - inCollection: Name of the collection
     - toRole: name of the role
     - accessType: enumeration of types of access ( read, delete, all, update )
     */
    public func revokeRoleAccess(toDocument id: String, inCollection coll: String, toRole roleid: String, accessType: docAccessTypes, completion: @escaping RookUserCompletion) {
        assert(coll != "" && id != "" && roleid != "", "Collection name, id of document and role cannot be empty")
        delete(url: "/document/"+coll+"/"+id+"/"+accessType.rawValue+"/role/"+roleid, parameters: [:], completion: {(success, data, error) in
            completion(success, data, error)
        })
    }
    
    // MARK: Links
    
    /**
     Create a link within two documents with a label
     
     - parameters:
     - label: Label of the link
     - sourceID: Id of the first document
     - destinationID: Id of the second document
     */
    public func createLink(label: String, sourceID source: String, destinationID dest: String, completion: @escaping RookUserCompletion) {
        assert(label != "" && source != "" && dest != "", "Label, source and destination for link cannot be empty")
        post(url: "/link/"+source+"/"+label+"/"+dest, parameters: [:], completion: {(success, data, error) in
            completion(success, data, error)
        })
    }
    
    /**
     Get list of linked documents, you can pass query and pagination criteria
     
     - parameters:
     - withID: (Optional) The id of the link you want to retrieve
     - parameters: (Optional) query criteria
     */
    public func getLinks(withID id: String = "", parameters: [String:AnyHashable] = [:], completion: @escaping RookUserCompletion) {
        get(url: "/link"+(id != "" ? "/"+id : ""), parameters: parameters, completion: {(success, data, error) in
            completion(success, data, error)
        })
    }
    
    /**
     Delete the link with the provided id
     
     - parameters:
     - withID: The id of the link you want to delete
     */
    public func deleteLink(withID id: String, completion: @escaping RookUserCompletion) {
        assert(id != "", "Link id for deletion cannot be empty")
        delete(url: "/link/"+id, parameters: [:], completion: {(success, data, error) in
            completion(success, data, error)
        })
    }
    
    // MARK: Files
    
    /**
     Upload the file given as data
     
     - parameters:
     - data: data of the file you want to upload
     - attachedData : More data you want to store
     - permissions : The permissions of the file uploaded ( see ACL )
     
     */
    public func uploadFile(data: Data, attachedData: [String:AnyHashable] = [:], permissions: [String:AnyHashable] = [:], completion: @escaping RookUserCompletion) {
        postImage(url: "/file", image:data, attachedData: attachedData, permissions:permissions, completion: {(success, data, error) in
            completion(success, data, error)
        })
    }
    
    /**
     Delete the file with the provided id
     
     - parameters:
     - withID: id of the file to delete
     
     */
    public func deleteFile(withID id: String, completion: @escaping RookUserCompletion) {
        assert(id != "", "File id for deletion cannot be empty")
        delete(url: "/file/"+id, parameters: [:], completion: {(success, data, error) in
            completion(success, data, error)
        })
    }
    
    /**
     Get the file with the provided id
     
     - parameters:
     - withID: id of the file to get
     
     */
    public func getFile(withID id: String, completion: @escaping RookUserCompletion) {
        assert(id != "", "File id cannot be empty")
        guard id != "" else {
            completion(false, nil, NSError.init(domain: domain, code: -1, userInfo: ["error":"Id of file not provided"]))
            return
        }
        getFile(url: "/file/"+id, completion: {(success, data, error) in
            completion(success, data, error)
        })
    }
    
    /**
     Get the file details with the provided id
     
     - parameters:
     - withID: id of the file to get
     
     */
    public func getFileDetails(withID id: String, completion: @escaping RookUserCompletion) {
        assert(id != "", "File id for details cannot be empty")
        guard id != "" else {
            completion(false, nil, NSError.init(domain: domain, code: -1, userInfo: ["error":"Id of file not provided"]))
            return
        }
        get(url: "/file/details/"+id, parameters: [:], completion: {(success, data, error) in
            completion(success, data, error)
        })
    }
    
    /**
     Get a list of file details, you can pass query criteria
     
     - parameters:
     - parameters: Query criteria
     
     */
    public func getFilesDetails(parameters: [String: AnyHashable] = [:], completion: @escaping RookUserCompletion) {
        get(url: "/file/details", parameters: parameters, completion: {(success,data,error) in
            completion(success, data, error)
        })
    }
    
    /**
     Grant access to the specified user to the specified file
     
     - parameters:
     - toFile: Id of the document
     - inCollection: Name of the collection
     - toUser: Username of the user
     - accessType: enumeration of types of access ( read, delete, all, update )
     */
    public func grantUserAccess(toFile id: String, toUser userid: String, accessType: docAccessTypes, completion: @escaping RookUserCompletion) {
        assert(id != "" && userid != "", "ID of file and username cannot be empty")
        put(url: "/file/"+id+"/"+accessType.rawValue+"/user/"+userid, parameters: [:], completion: {(success, data, error) in
            completion(success, data, error)
        })
    }
    
    /**
     Grant access to the specified role to the specified file
     
     - parameters:
     - toFile: Id of the document
     - inCollection: Name of the collection
     - toRole: name of the role
     - accessType: enumeration of types of access ( read, delete, all, update )
     */
    public func grantRoleAccess(toFile id: String, toRole roleid: String, accessType: docAccessTypes, completion: @escaping RookUserCompletion) {
        assert(id != "" && roleid != "", "ID of file and role cannot be empty")
        put(url: "/file/"+id+"/"+accessType.rawValue+"/role/"+roleid, parameters: [:], completion: {(success, data, error) in
            completion(success, data, error)
        })
    }
    
    /**
     Revoke access to the specified user to the specified file
     
     - parameters:
     - toFile: Id of the document
     - inCollection: Name of the collection
     - toUser: Username of the user
     - accessType: enumeration of types of access ( read, delete, all, update )
     */
    public func revokeUserAccess(toFile id: String, toUser userid: String, accessType: docAccessTypes, completion: @escaping RookUserCompletion) {
        assert(id != "" && userid != "", "ID of file and username cannot be empty")
        delete(url: "/file/"+id+"/"+accessType.rawValue+"/user/"+userid, parameters: [:], completion: {(success, data, error) in
            completion(success, data, error)
        })
    }
    
    /**
     Revoke access to the specified role to the specified file
     
     - parameters:
     - toFile: Id of the document
     - inCollection: Name of the collection
     - toRole: name of the role
     - accessType: enumeration of types of access ( read, delete, all, update )
     */
    public func revokeRoleAccess(toFile id: String, toRole roleid: String, accessType: docAccessTypes, completion: @escaping RookUserCompletion) {
        assert(id != "" && roleid != "", "ID of file and role cannot be empty")
        delete(url: "/file/"+id+"/"+accessType.rawValue+"/role/"+roleid, parameters: [:], completion: {(success, data, error) in
            completion(success, data, error)
        })
    }
    
    // MARK: Assets
    
    /**
     Retrieve the asset with the specified name
     
     - parameters:
     - name: name of the asset
     */
    public func getAsset(name: String, completion: @escaping RookUserCompletion) {
        assert(name != "", "Name of the asset cannot be empty")
        guard name != "" else {
            completion(false, nil, NSError.init(domain: domain, code: -1, userInfo: ["error":"name of the asset not provided"]))
            return
        }
        getFile(url: "/asset/"+name, completion: {(success, data, error) in
            completion(success,data,error)
        })
    }
    
    // MARK: Push Notifications
    
    /**
     Ask the user to enable push notification.
     You need to add to your AppDelegate:
     
     import UserNotification
     extension UNUserNotificationDelegate
     if #available(iOS 10.0, *){
     UNUserNotificationCenter.current().delegate = self
     }
     
     for ios10
     
     */
    public func askToEnablePushNotifications() {
        if #available(iOS 10.0, *){
            UNUserNotificationCenter.current().requestAuthorization(options: [.badge, .sound, .alert], completionHandler: {(granted, error) in
                if (granted)
                {
                    UIApplication.shared.registerForRemoteNotifications()
                }
            })
        } else {
            let type: UIUserNotificationType = [UIUserNotificationType.badge, UIUserNotificationType.alert, UIUserNotificationType.sound];
            let setting = UIUserNotificationSettings(types: type, categories: nil);
            UIApplication.shared.registerUserNotificationSettings(setting);
            UIApplication.shared.registerForRemoteNotifications();
        }
    }
    
    /**
     Add this method in AppDelegate:
     
     didRegisterForRemoteNotificationsWithDeviceToken
     
     */
    public func enablePushNotifications(deviceToken: Data, completion: @escaping RookUserCompletion) {
        let token = deviceToken.reduce("", {$0 + String(format: "%02X", $1)})
        self.user.pushToken = token
        if !self.user.pushEnabled {
            put(url: "/push/enable/ios/"+token, parameters: [:], completion: {(success, data, error) in
                if success {
                    self.user.pushEnabled = true
                }
                completion(success, data, error)
            })
        }
    }
    
    /**
     Sends a push notification to the specified users
     */
    public func sendNotification(message: String, users: [String], profiles: [pushProfiles] = [.one], sound:String = "", badge: Int = 1, actionLocalizedKey: String = "", localizedKey: String = "", localizedArguments: [String] = [], custom: [String: AnyHashable] = [:], collapse_key:String = "", time_to_live: Int = 2419200, content_available: Int = 1, category: String = "", completion:@escaping RookUserCompletion) {
        postNotif(url: "/push/message", parameters: ["message":message, "users":users, "profiles":profiles, "sound":sound, "badge":badge, "actionLocalizedKey":actionLocalizedKey, "localizedKey":localizedKey, "localizedArguments":localizedArguments, "custom":custom, "collapse_key":collapse_key, "time_to_live":time_to_live, "content-available": content_available, "category":category], completion: {(success, data, error) in
            completion(success, data, error)
        })
    }
    
    // MARK: Pass Through
    
    internal func getHeaders(contType: String = "application/json") -> [String: String] {
        var h = [String:String]()
        h["cache-control"] = "no-cache"
        h["Content-Type"] = contType
        h["x-ROOK-appcode"] = self.appcode
        h["User-Agent"] = "Rook+ iOS App - "+self.version
        if self.user.isAuthenticated() {
            h["x-ROOK-token"] = self.user.token
        }
        return h
    }
   
    
    // MARK: Variables
    
    public typealias RookUserCompletion = (( _ success : Bool, _ data : Any?, _ error: Error? ) -> Void)
    public typealias RookFileCompletion = (( _ success : Bool, _ data : Data?, _ error: Error? ) -> Void)
    
    // MARK: Enums
    
    public enum signUpType {
        case email, social
    }
    
    /// Enum the possible social logins offered by Rook+
    public enum socialTypes : String {
        /// Facebook string for social login
        case facebook = "facebook"
        /// Linkedin string for social login
        case linkedin = "linkedin"
        /// Twitter string for social login
        case twitter = "twitter"
        
    }
    /// Enum the possible access types for documents and files
    public enum docAccessTypes : String {
        /// User/role can read
        case read = "read"
        /// User/role can update
        case update = "update"
        /// User/role can delete
        case delete = "delete"
        /// User/role can read/update/delete
        case all = "all"
        /// Used internally to
        case none = ""
    }
    /// Enum the possible app profiles for push notifications
    public enum pushProfiles : Int {
        /// First profile
        case one = 1
        /// Second profile
        case two = 2
        /// Third profile
        case three = 3
    }
    
    internal let domain = "com.delmwin.RealRook"
    internal let boundary = "ROOK_BOUNDARY_STRING"
    static let saved_rook_user = "saved_rook_user"
    internal var isRetry = false
}

extension Dictionary {
    func stringFromHttpParameters() -> String {
        let parameterArray = self.map { (key, value) -> String in
            let percentEscapedKey = (key as! String).addingPercentEncodingForURLQueryValue()!
            let percentEscapedValue = (value as! String).addingPercentEncodingForURLQueryValue()!
            return "\(percentEscapedKey)=\(percentEscapedValue)"
        }
        return parameterArray.joined(separator: "&")
    }
    func convertToData() -> Data? {
        do {
            return try JSONSerialization.data(withJSONObject: self, options: [])
        } catch let error {
            print("errore convert", error)
        }
        return nil
    }
}
extension String {
    func addingPercentEncodingForURLQueryValue() -> String? {
        let allowedCharacters = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-._~")
        return self.addingPercentEncoding(withAllowedCharacters: allowedCharacters)
    }
}
extension Data {
    func convertToDictionary() -> [String: AnyObject]? {
        do {
            return try JSONSerialization.jsonObject(with: self, options: []) as? [String:AnyObject]
        } catch let error as NSError {
            print("ERRORE CONVERT TO JSON",error)
        }
        return nil
    }
}
