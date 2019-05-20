//
//  RookUserModel.swift
//  RookPlus
//
//  Created by Delmwin Baeka on 3/15/19.
//  Copyright © 2019 Delmwin Baeka. All rights reserved.
//


import Foundation
import SwiftyJSON

/**
 class BaasUser
 
 manages the `BaasBox` logged in user
 
 You can get the user data and manages it from here
 
 */
public class RookUserModel: NSObject, Codable {
    
    // MARK: Variables
    
    /// Session token from Rook+
    var token: String
//    /// User id from Rook+
//    var id : String
    /// Firebase Token
    var firebaseToken: String?
    /// First name of user
    var firstName: String?
    /// Last name of user
    var lastName: String?
    /// Email
    var email : String
    /// Gender
    var gender: String?
    /// Date of Birth
    var dateOfBirth: String?
    /// Temp password holder for user creation
    var tempPassword: String?
    /// Phone number
    var phone: String?
    /// social ID
    var socialID: String?
    /// avatar URL
    var avatar: String?
    /// location
    var location: String?
    /// nationality
    var nationality: String?
    /// marital status
    var maritalStatus: String?
    /// employment status
    var employmentStatus: String?
    /// social Token
    var socialToken: String?
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
    /// Structure representing aptitude
    var aptitude: AptitudeItem?
    /// Structure representing education
    var education: [EducationItem]?
    /// Structure representing experience
    var experience: [ExperienceItem]?
    /// Structure representing interests
    var interests: [InterestItem]?
    /// Structure representing skills
    var skills: [SkillItem]?
    /// Structure representing portfolio
    var portfolio: [PortfolioItem]?
    /// Structure representing stats
    var stats: StatsItem?
    
    var fullname: String {
        guard let fname = firstName, let lname = lastName else { return "" }
        return fname + " " + lname
    }
    
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
        self.firstName = user["fname"] as? String
        self.lastName = user["lname"] as? String
        self.gender = (user["gender"] as? String == "m") ? "male" : "female"
        self.location = user["city"] as? String
        self.avatar = user["avatar"] as? String
        self.dateOfBirth = user["dob"] as? String
        self.phone = user["phone"] as? String
        self.nationality = user["nationality"] as? String
        self.maritalStatus = user["marital_status"] as? String
        self.employmentStatus = user["employment_staus"] as? String
      //  self.status = user["status"] as! String
        self.firebaseToken = user["firebaseToken"] as? String
        self.aptitude = RookUserModel.serialize(user["aptitude"], with: AptitudeItem.self)
        self.stats = RookUserModel.serialize(user["stats"], with: StatsItem.self)
        self.education = RookUserModel.serialize(user["education"], with: [EducationItem].self)
        self.experience = RookUserModel.serialize(user["experience"], with: [ExperienceItem].self)
        self.portfolio = RookUserModel.serialize(user["portfolio"], with: [PortfolioItem].self)
        self.interests = RookUserModel.serialize(user["interests"], with: [InterestItem].self)
        self.skills = RookUserModel.serialize(user["skills"], with: [SkillItem].self)
        self.pushToken = pushToken
        self.pushEnabled = pushEnabled
        self.isSocialLogin = socialLogin
        self.socialType = socialType
    }
    
    /**
     Coding Keys for encoded object
     */
    enum CodingKeys: String, CodingKey {
        case email
        case token
        case pushToken
        case pushEnabled
        case isSocialLogin
        case socialType
        case firebaseToken
        case firstName = "firstname"
        case lastName = "lastname"
        case gender
        case dateOfBirth
        case phone
        case socialID
        case avatar
        case location
        case socialToken
        case nationality
        case employmentStatus
        case maritalStatus
        case stats
        case aptitude
        case education
        case experience
        case portfolio
        case interests
        case skills
    }
    
    /**
     Decodes the saved object
     */
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        email = try container.decode(String.self, forKey: .email)
        token = try container.decode(String.self, forKey: .token)
        pushToken = try container.decode(String.self, forKey: .pushToken)
        pushEnabled = try container.decode(Bool.self, forKey: .pushEnabled)
        isSocialLogin = try container.decode(Bool.self, forKey: .isSocialLogin)
        socialType = try container.decode(String.self, forKey: .socialType)
        firebaseToken = try container.decode(String?.self, forKey: .firebaseToken)
        firstName = try container.decode(String?.self, forKey: .firstName)
        lastName = try container.decode(String?.self, forKey: .lastName)
        gender = try container.decode(String?.self, forKey: .gender)
        dateOfBirth = try container.decode(String?.self, forKey: .dateOfBirth)
        phone = try container.decode(String?.self, forKey: .phone)
        socialID = try container.decode(String?.self, forKey: .socialID)
        avatar = try container.decode(String?.self, forKey: .avatar)
        location = try container.decode(String?.self, forKey: .location)
        socialToken = try container.decode(String?.self, forKey: .socialToken)
        nationality = try container.decode(String?.self, forKey: .nationality)
        employmentStatus = try container.decode(String?.self, forKey: .employmentStatus)
        maritalStatus = try container.decode(String?.self, forKey: .maritalStatus)
        aptitude = try container.decode(AptitudeItem?.self, forKey: .aptitude)
        stats = try container.decode(StatsItem?.self, forKey: .stats)
        education = try container.decode([EducationItem]?.self, forKey: .education)
        experience = try container.decode([ExperienceItem]?.self, forKey: .experience)
        portfolio = try container.decode([PortfolioItem]?.self, forKey: .portfolio)
        interests = try container.decode([InterestItem]?.self, forKey: .interests)
        skills = try container.decode([SkillItem]?.self, forKey: .skills)
    }
    
    private class func serialize<T>(_ data: AnyObject?, with type: T.Type) -> T? where T: Decodable {
        let decoder = JSONDecoder()
        guard let rawdata = data else { return nil }
        do {
            let data = try JSON(rawdata).rawData()
            let response = try decoder.decode(type, from: data)
            return response
        } catch {
            print(error)
            return nil
        }
    }
    
    private class func serialize<T>(_ data: AnyObject?, with type: [T].Type) -> [T]? where T: Decodable {
        let decoder = JSONDecoder()
        var result: [T] = []
        guard let rawdata = data else { return nil }
        do {
            let data = try JSON(rawdata).rawData()
            let response = try decoder.decode(type, from: data)
            for item in response {
                result.append(item)
            }
            return result
        } catch {
            print(error)
            return nil
        }
    }
    
    /**
     Encodes the saved object
     */
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(email, forKey: .email)
        try container.encode(token, forKey: .token)
        try container.encode(pushToken, forKey: .pushToken)
        try container.encode(pushEnabled, forKey: .pushEnabled)
        try container.encode(isSocialLogin, forKey: .isSocialLogin)
        try container.encode(socialType, forKey: .socialType)
        try container.encode(firebaseToken, forKey: .firebaseToken)
        try container.encode(firstName, forKey: .firstName)
        try container.encode(lastName, forKey: .lastName)
        try container.encode(gender, forKey: .gender)
        try container.encode(dateOfBirth, forKey: .dateOfBirth)
        try container.encode(phone, forKey: .phone)
        try container.encode(socialID, forKey: .socialID)
        try container.encode(avatar, forKey: .avatar)
        try container.encode(location, forKey: .location)
        try container.encode(socialToken, forKey: .socialToken)
        try container.encode(nationality, forKey: .nationality)
        try container.encode(maritalStatus, forKey: .maritalStatus)
        try container.encode(employmentStatus, forKey: .employmentStatus)
        try container.encode(aptitude, forKey: .aptitude)
        try container.encode(stats, forKey: .stats)
        try container.encode(education, forKey: .education)
        try container.encode(experience, forKey: .experience)
        try container.encode(portfolio, forKey: .portfolio)
        try container.encode(interests, forKey: .interests)
        try container.encode(skills, forKey: .skills)
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
