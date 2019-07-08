//
//  Settlement.swift
//  Ooze
//
//  Created by 中原雄太 on 2019/06/11.
//  Copyright © 2019 中原雄太. All rights reserved.
//

//import UIKit
//import Firebase
//
//var functions = Functions.functions()
//
//func createCustomerId(email: String, completion: ((String?, Error?) -> Void)?){
//    let data: [String: Any] = [
//        "email": email
//    ]
//    functions.httpsCallable("createStripeCustomer")
//        .call(data) { result, error in
//
//            if let error = error {
//                completion(nil, error)
//            } else if let data = result?.data as? [String: Any],
//                let customerId = data["customerId"] as? String {
//                completion(customerId, nil)
//            }
//    }
//}
