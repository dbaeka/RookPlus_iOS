//
//  RookUser+Router.swift
//  RookPlus
//
//  Created by Delmwin Baeka on 3/17/19.
//  Copyright © 2019 Delmwin Baeka. All rights reserved.
//

import Foundation
import UserNotifications

extension RookUser {
    
    /**
     HTTP GET, you can use this to call plugins
     
     - parameters:
     - url: the endpoint to call ( note: without the base url ) eg: /plugins/baasbox.plugin
     - parameters: list of parameters for the query
     */
    public func get(url: String, parameters:[String:AnyHashable], completion: @escaping RookUserCompletion) {
        check()
        let requestUrl = self.base_url!+url+"?"+parameters.stringFromHttpParameters()
        let request = NSMutableURLRequest(url: URL(string: requestUrl)!, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: self.config.timeout)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = getHeaders()
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                completion(false, nil, error)
            } else {
                if let data = data {
                    let json = data.convertToDictionary()
                    let sc = (response as! HTTPURLResponse).statusCode
                    if sc >= 400 {
                        if self.config.retrylogin && sc == 401 && !self.isRetry {
                            self.retryRequest(request: request, error: NSError.init(domain: self.domain, code: sc, userInfo: ["message":json?["errorMessage"] as! String]), completion: { (success, data, error) in
                                completion(success,data,error)
                            })
                        } else {
                            if sc == 401 && !self.config.retrylogin { self.config.logoutStrategy.notAuthorized() }
                            completion(false, nil, NSError.init(domain: self.domain, code: sc, userInfo: ["message":json?["errorMessage"] as! String]))
                        }
                        return
                    }
                    if (json?["success"] as! Bool == true ) {
                        completion(true, json?["result"], nil)
                    } else { completion(false, nil, NSError.init(domain: self.domain, code: sc, userInfo: ["message":json?["errorMessage"] as! String])) }
                }
            }
        })
        dataTask.resume()
    }
    /**
     HTTP POST, you can use this to call plugins
     
     - parameters:
     - url: the endpoint to call ( note: without the base url ) eg: /plugins/baasbox.plugin
     - parameters: list of parameters for the query
     */
    public func post(url: String, parameters:[String:Any], completion: @escaping RookUserCompletion) {
        check()
        let requestUrl = self.base_url!+url
        let request = NSMutableURLRequest(url: URL(string: requestUrl)!, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: self.config.timeout)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = getHeaders()
        guard let body = parameters.convertToData() else {
            fatalError("Cannot convert parameters to data")
        }
        request.httpBody = body
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                completion(false, nil, error)
            } else {
                if let data = data {
                    let json = data.convertToDictionary()
                    let sc = (response as! HTTPURLResponse).statusCode
                    if sc >= 400 {
                        if self.config.retrylogin && sc == 401 && !self.isRetry {
                            self.retryRequest(request: request, error: NSError.init(domain: self.domain, code: sc, userInfo: ["message":json?["errorMessage"] as! String]), completion: { (success, data, error) in
                                completion(success,data,error)
                            })
                        } else {
                            if sc == 401 && !self.config.retrylogin { self.config.logoutStrategy.notAuthorized() }
                            completion(false, nil, NSError.init(domain: self.domain, code: sc, userInfo: ["message":json?["errorMessage"] as! String]))
                        }
                        return
                    }
                    if ( json?["success"] as! Bool == true ) {
                        completion(true, json?["result"], nil)
                    } else { completion(false, nil, NSError.init(domain: self.domain, code: 2, userInfo: ["message":json?["errorMessage"] as! String])) }
                }
            }
        })
        
        dataTask.resume()
    }
    /**
     HTTP PUT, you can use this to call plugins
     
     - parameters:
     - url: the endpoint to call ( note: without the base url ) eg: /plugins/baasbox.plugin
     - parameters: list of parameters for the query
     */
    public func put(url: String, parameters:[String:Any], completion: @escaping RookUserCompletion) {
        check()
        let requestUrl = self.base_url!+url
        let request = NSMutableURLRequest(url: URL(string: requestUrl)!, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: self.config.timeout)
        request.httpMethod = "PUT"
        request.allHTTPHeaderFields = getHeaders()
        guard let body = parameters.convertToData() else {
            fatalError("Cannot convert parameters to data")
        }
        request.httpBody = body
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                completion(false, nil, error)
            } else {
                if let data = data {
                    let json = data.convertToDictionary()
                    let sc = (response as! HTTPURLResponse).statusCode
                    if sc >= 400 {
                        if self.config.retrylogin && sc == 401 && !self.isRetry {
                            self.retryRequest(request: request, error: NSError.init(domain: self.domain, code: sc, userInfo: ["message":json?["errorMessage"] as! String]), completion: { (success, data, error) in
                                completion(success,data,error)
                            })
                        } else {
                            if sc == 401 && !self.config.retrylogin { self.config.logoutStrategy.notAuthorized() }
                            completion(false, nil, NSError.init(domain: self.domain, code: sc, userInfo: ["message":json?["errorMessage"] as! String]))
                        }
                        return
                    }
                    if ( json?["success"] as! Bool == true ) {
                        completion(true, json?["result"], nil)
                    } else { completion(false, nil, NSError.init(domain: self.domain, code: 2, userInfo: ["message":json?["errorMessage"] as! String])) }
                }
            }
        })
        dataTask.resume()
    }
    /**
     HTTP DELETE, you can use this to call plugins
     
     - parameters:
     - url: the endpoint to call ( note: without the base url ) eg: /plugins/baasbox.plugin
     - parameters: list of parameters for the query
     */
    public func delete(url: String, parameters:[String:Any], completion: @escaping RookUserCompletion) {
        check()
        let requestUrl = self.base_url!+url
        let request = NSMutableURLRequest(url: URL(string: requestUrl)!, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: self.config.timeout)
        request.httpMethod = "DELETE"
        request.allHTTPHeaderFields = getHeaders()
        guard let body = parameters.convertToData() else {
            fatalError("Cannot convert parameters to data")
        }
        request.httpBody = body
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                completion(false, nil, error)
            } else {
                if let data = data {
                    let json = data.convertToDictionary()
                    let sc = (response as! HTTPURLResponse).statusCode
                    if sc >= 400 {
                        if self.config.retrylogin && sc == 401 && !self.isRetry {
                            self.retryRequest(request: request, error: NSError.init(domain: self.domain, code: sc, userInfo: ["message":json?["errorMessage"] as! String]), completion: { (success, data, error) in
                                completion(success,data,error)
                            })
                        } else {
                            if sc == 401 && !self.config.retrylogin { self.config.logoutStrategy.notAuthorized() }
                            completion(false, nil, NSError.init(domain: self.domain, code: sc, userInfo: ["message":json?["errorMessage"] as! String]))
                        }
                        return
                    }
                    if ( json?["success"] as! Bool == true ) {
                        completion(true, json?["result"], nil)
                    } else { completion(false, nil, NSError.init(domain: self.domain, code: 2, userInfo: ["message":json?["errorMessage"] as! String])) }
                }
            }
        })
        dataTask.resume()
    }
    private func retryRequest(request: NSMutableURLRequest, isPostImage:Bool = false, error:Error, completion: @escaping RookUserCompletion) {
        guard let pass = RookUser.getUserPass() else {
            print("pass not saved")
            completion(false, nil, error)
            return
        }
        print("retying login")
        DispatchQueue(label: "retry").async {
            self.retryLogin(pass: pass, completion: {(success) in
                if !success {
                    self.config.logoutStrategy.notAuthorized()
                    completion(false, nil, error)
                } else {
                    let session = URLSession.shared
                    request.allHTTPHeaderFields = !isPostImage ? self.getHeaders() : self.getHeaders(contType: "multipart/form-data; boundary="+self.boundary)
                    let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
                        if (error != nil) {
                            completion(false, nil, error)
                        } else {
                            if let data = data {
                                let json = data.convertToDictionary()
                                let sc = (response as! HTTPURLResponse).statusCode
                                if sc >= 400 {
                                    completion(false, nil, NSError.init(domain: self.domain, code: sc, userInfo: ["message":json?["errorMessage"] as! String]))
                                    return
                                }
                                if ( json?["success"] as! Bool == true ) {
                                    completion(true, json?["result"], nil)
                                } else { completion(false, nil, NSError.init(domain: self.domain, code: 2, userInfo: ["message":json?["errorMessage"] as! String])) }
                            }
                        }
                    })
                    dataTask.resume()
                }
            })
        }
    }
    
    private func retryLogin(pass: String, completion: @escaping (Bool) -> Void) {
        self.isRetry = true
        if !RookUser.shared.user.isSocialLogin {
            self.config.loginStrategy.login(email: self.user.email, password: pass, completion: {(success, data, error) in
                self.isRetry = false
                completion(success)
            })
        } else {
            self.config.loginStrategy.socialLogin(to: getSocialType(s: self.user.socialType), id: pass, completion: { (success, data, error) in
                self.isRetry = false
                completion(success)
            })
        }
    }
    private func getSocialType(s: String) -> socialTypes {
        switch s {
        case "facebook":
            return .facebook
        case "linkedin":
            return .linkedin
        case "twitter":
            return .twitter
        default:
            return .facebook
        }
    }
    
    
    internal func postImage(url: String, image:Data, attachedData: [String: AnyHashable] = [:], permissions: [String: AnyHashable] = [:], completion: @escaping RookUserCompletion) {
        check()
        let requestUrl = self.base_url!+url
        let request = NSMutableURLRequest(url: URL(string: requestUrl)!, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: self.config.timeout)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = getHeaders(contType: "multipart/form-data; boundary="+boundary)
        request.httpBody = createImageBody(image: image, attachedData: attachedData, permissions: permissions)
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                completion(false, nil, error)
            } else {
                if let data = data {
                    let json = data.convertToDictionary()
                    let sc = (response as! HTTPURLResponse).statusCode
                    if sc >= 400 {
                        if self.config.retrylogin && sc == 401 {
                            self.retryRequest(request: request, isPostImage: true, error: NSError.init(domain: self.domain, code: sc, userInfo: ["message":json?["errorMessage"] as! String]), completion: { (success, data, error) in
                                completion(success,data,error)
                            })
                        } else {
                            if sc == 401 && !self.config.retrylogin { self.config.logoutStrategy.notAuthorized() }
                            completion(false, nil, NSError.init(domain: self.domain, code: sc, userInfo: ["message":json?["errorMessage"] as! String]))
                        }
                        return
                    }
                    if ( json?["result"] as! String == "ok" ) {
                        completion(true, json?["result"], nil)
                    } else { completion(false, nil, NSError.init(domain: self.domain, code: 2, userInfo: ["message":json?["errorMessage"] as! String])) }
                }
            }
        })
        dataTask.resume()
    }
    
    private func createImageBody(image: Data, attachedData: [String:AnyHashable] = [:], permissions: [String:AnyHashable] = [:]) -> Data {
        let body = NSMutableData()
        let mimetype = "image/jpeg"
        body.append("--\(boundary)\r\n".data(using: String.Encoding.utf8)!)
        body.append("Content-Disposition:form-data; name=\"file\"; filename=\"\(NSUUID().uuidString)\"\r\n".data(using: String.Encoding.utf8)!)
        body.append("Content-Type: \(mimetype)\r\n\r\n".data(using: String.Encoding.utf8)!)
        body.append(image)
        body.append("\r\n".data(using: String.Encoding.utf8)!)
        body.append("--\(boundary)--\r\n".data(using: String.Encoding.utf8)!)
        body.append("Content-Disposition:form-data; name=\"attachedData\"\r\n\r\n".data(using: String.Encoding.utf8)!)
        guard let json = attachedData.convertToData() else {
            fatalError("Cannot convert parameters to data")
        }
        body.append(json)
        body.append("\r\n".data(using: String.Encoding.utf8)!)
        body.append("--\(boundary)\r\n".data(using: String.Encoding.utf8)!)
        body.append("Content-Disposition:form-data; name=\"acl\"\r\n\r\n".data(using: String.Encoding.utf8)!)
        guard let perm = permissions.convertToData() else {
            fatalError("Cannot convert parameters to data")
        }
        body.append(perm)
        body.append("\r\n".data(using: String.Encoding.utf8)!)
        body.append("--\(boundary)\r\n".data(using: String.Encoding.utf8)!)
        
        return body as Data
    }
    
    internal func getFile(url: String, completion: @escaping RookFileCompletion) {
        let request = NSMutableURLRequest(url: URL(string: self.base_url!+url)!, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: self.config.timeout)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = getHeaders()
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                completion(false, nil, error)
            } else {
                if let data = data {
                    let sc = (response as! HTTPURLResponse).statusCode
                    if sc >= 400 {
                        let json = data.convertToDictionary()
                        completion(false, nil, NSError.init(domain: self.domain, code: sc, userInfo: ["message":json?["errorMessage"] as! String]))
                        return
                    }
                    completion(true, data, nil)
                }
            }
        })
        dataTask.resume()
    }
    
    internal func postNotif(url: String, parameters:[String:Any], completion: @escaping RookUserCompletion) {
        check()
        let requestUrl = self.base_url!+url
        let request = NSMutableURLRequest(url: URL(string: requestUrl)!, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: self.config.timeout)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = getHeaders()
        guard let body = parameters.convertToData() else {
            fatalError("Cannot convert parameters to data")
        }
        request.httpBody = body
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                completion(false, nil, error)
            } else {
                if let data = data {
                    let json = data.convertToDictionary()
                    let sc = (response as! HTTPURLResponse).statusCode
                    if sc >= 400 {
                        if self.config.retrylogin && sc == 401 {
                            self.retryRequest(request: request, error: NSError.init(domain: self.domain, code: sc, userInfo: ["message":json?["errorMessage"] as! String]), completion: { (success, data, error) in
                                completion(success,data,error)
                            })
                        } else {
                            completion(false, nil, NSError.init(domain: self.domain, code: sc, userInfo: ["message":json?["errorMessage"] as! String]))
                        }
                        return
                    }
                    completion(true, json, nil)
                }
            }
        })
        dataTask.resume()
    }
}
