//
//  StripeProvider.swift
//  Ooze
//
//  Created by 中原雄太 on 2019/06/11.
//  Copyright © 2019 中原雄太. All rights reserved.
//

//
//import UIKit
//import Stripe
//
//class StripeProvider: NSObject, STPCustomerEphemeralKeyProvider {
//    lazy var functions = Functions.functions()
//    let customerId: String
//    
//    init(customerId: String){
//        self.customerId = customerId
//    }
//    
//    func createCustomerKey(withAPIVersion apiVersion: String, completion: @escaping STPJSONResponseCompletionBlock) {
//        let data: [String: Any] = [
//            "customerId": customerId,
//            "stripe_version": apiVersion
//        ]
//        functions
//            .httpsCallable("createStripeEphemeralKeys")
//            .call(data) { result, error in
//                
//                if let error = error {
//                    completion(nil, error)
//                } else if let data = result?.data as? [String: Any] {
//                    completion(data, nil)
//                }
//        }
//    }
//}

