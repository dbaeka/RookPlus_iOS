//
//  SRPTest.swift
//  RookPlus
//
//  Created by Delmwin Baeka on 3/10/19.
//  Copyright © 2019 Delmwin Baeka. All rights reserved.
//

import UIKit
import Cryptor

class dummyView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        start()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        start()
    }
    
    func start() {
        // This is a database of users, along with their salted verification keys
        let userStore: [String: (salt: Data, verificationKey: Data)] = [
            "alice": createSaltedVerificationKey(username: "alice", password: "password123"),
            "bob": createSaltedVerificationKey(username: "bob", password: "qwerty12345"),
            ]
        
        // Alice wants to authenticate, she sends her username to the server.
        let client = Client(username: "alice", password: "password123")
        let (username, A) = client.startAuthentication()
    
        //Get random s
        print("Salt: \(userStore[username]!.salt.hexEncodedString().toBase64())")
        //Get v from x infunc, username and password
        print("Verifier: \(userStore[username]!.verificationKey.hexEncodedString())")
        
        
        let saltTemp = Data(base64Encoded: "NGY2MjJlN2E5M2E3MDBmYmFkMDQzY2FmZmM3MDgwNDY5YWYyMzNmZDUwYTRhY2I0NDNlYmY1ZmU0ZDZkZjU2ZGQ1MTJjNWJlNjMwMjYyZTg0OTUzYzQzNTMzNmFjZGY0NDIwZGNjZjFjNWMxN2Q1NWRjMzZkOWU2YzcxNWY3ZjM=")
        let verTemp = Data(base64Encoded: "MjdiODljZTVmODIyYjk3MzRmM2Q0YzNkOTNkYjk4ZGUzMTNlZmRiMjYyZGZjMTRhMTAxOTc1MWQ2ZjI5NmI2NTFiZWQwYzQ2ZjVjOWU5YmMzYTUxMmNhY2U3ZmZjMTJiNjVjNDAxYjU1ZmY3Y2IzNTRiNzMwZDY3MjcwNTg0MDRhOTQ3ODdlMjUxMmU0NTAwNzNhZjFjOTcxOTJmMzBiMjYwNWIyOGMxOGIzMGNkMzIzYWI3NDJkN2EzNjMwZmIxYTRjMDg0ZTQ0NWVkNDlhYzk4YjA5ZDdhNDRhNjBkZTA5NTc1YzViODI5ZmM0MWQzYWVhZGUyOGFjYzdkZDEzYTEzZTRkNTM0NjU3NWNjZDkzNTRhNmNmM2E1NmZiMGZiN2Q1NDJmNjNkZWQ5MjBlNTFhNTEzYjYxMjNmYTgwNjBiMjFhZGIxMmUwODVjYWEwNTQyOGM5OTliYTJjNDIzN2M5NmJjYTRkMzU3ZjU4YjJjNWU1NmRjYzllZDkwMGMxMDk4MTE2MTlmNDMyMzVlZjdmMGUyNWEyODUyYzg1OTYzZDZjYmE4NGY5ODIzYTFhYTZiZDkzNTEyMzc4ZjU2ZjhlODA0YjQwZjgzM2ZiYjcwYWM5OGNjMjUxOWMzZmNkYzQ2YWViNGNlZTMxNTBiNzMyMTJlZTE1YzExZjI2OTM=")
        
        let server = Server(username: username, salt: saltTemp!, verificationKey: verTemp!)
        
//        let server = Server(
//            username: username,
//            salt: userStore[username]!.salt,
//            verificationKey: userStore[username]!.verificationKey)
        
        // The server shares Alice's salt and its public key (the challenge).
      //  let (salt, serverPublicKey) = server.getChallenge()
        
        // Alice generates a sessionKey and proofs she generated the correct
        // session key based on her password and the challenge.
        let B = Data(base64Encoded: "MWQ5NjdiOGJlYTc1MmI3NjZlZDQzNWU5NTE5MWMxNmFmNWEyZmJjNmU1NGYzZTc1MTQyYmQzZTY5NTk1OTVlMzNiMDQwNTNhYTE1NTRkYTI0NGJlMTU3MjFlNDU0ZTYxMzAyYjdjMTgzOTc1MjE0MDRhNWYwNTY5MmFlOTViODkyNTM5YTA5M2M4ODkyNzJiNzA0NjUzMWZmMzMxN2VkNjYwZWM3ZDBiNTMwZWZhNmViMjExMDcwMGQxZDJhZGM4NmFiMTdmN2ZiZTE0MmVmMWI4MjVlN2RjMmFhMTUxYWUyMzJiYzQ1NDg4YjA5YzYzYzAzYjQ5ODhkNjk4MDNjZGUzMTI2NWM0YTEyMzA5Zjk2MTI1MmNiMThkOGQxMDdlYzRlODMzZTIxMWVmZGIwZTY5YWZiNDA5OTQ0OWZiNjg3Y2FhNDU3OWE2N2FkYTJlMjMyMjc4Y2VjODY5ZmY3NGJhOGU1MGM2MTJjOTE3YjMzMjM4NWNmYTBjNjBiODRlMTM2ZDk2ZDZiZTRjMDYxNDFiZDI4OTIwYWNlMjEzM2Y5NGRlOTA5NDM3MTJmMDQ5YWY5YzkwNzUwMTNjMTI1ZjBkNjQyNTRjY2MzNTczNTA1ODIwZjQyMzljOGY3NjkwZjMzZTlkZjVhZTg3Y2E2NThjNTMyMTA3YjZiZmU4YmU1OGYzOGNjYTYxOTEyZGFlNDdhYTU4YzBhYjBjNjliZDRjNjMzYTQxNDQxYzY3MDFkNmJiMDZmNjUxZjEyMjgz")
        
        
        do {
            let clientKeyProof = try client.processChallenge(salt: saltTemp!, publicKey: B!)
            
            // The server verifies Alices' proof and generates their proof.
            let serverKeyProof = try server.verifySession(publicKey: A, keyProof: clientKeyProof)
            
            // The client verifies the server's proof.
            try client.verifySession(keyProof: serverKeyProof)
        } catch {
            print("Error")
        }
        
        // At this point, authentication has completed.
        assert(server.isAuthenticated)
        assert(client.isAuthenticated)
        
        // Both now have the same session key. This key can be used to encrypt
        // further communication between client and server.
        assert(server.sessionKey == client.sessionKey)
    }
    
}
