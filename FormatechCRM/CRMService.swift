//
//  CRMService.swift
//  FormatechCRM
//
//  Created by Nicholas Credli on 3/15/16.
//  Copyright © 2016 Novium Collective SARL. All rights reserved.
//

import Foundation
import Alamofire

let baseURL = "http://dev.local:30080"

class CRMService {
    // This makes our class a singleton service by ensuring it will be instantiated only once.
    // Now we can grab a unique instance using this call: CRMService.sharedService.AnyFunctionName()
    static var sharedService: CRMService {
        struct Static {
            static var onceToken: dispatch_once_t = 0
            static var instance: CRMService? = nil
        }
        dispatch_once(&Static.onceToken) {
            Static.instance = CRMService()
        }
        return Static.instance!
    }
    
    // This is a trick to prevent users from instantiating this class directly, our only allowed method is to use the singleton above.
    // By changing init visibility to private, calling "let service = CRMService()" will fail.
    private init() { }
    
    /*  Performs a GET http request to baseURL/customer, it is expected to return a JSON array (NSArray) of dictionaries (NSDictionary)
        I want you to pay special attention to the weirdly looking parameter data type:
        
            callback: ((customers: [Customer]?, error: NSError?) -> Void))
    
        This type of param is called a "Closure", it basically expects you to pass in a nameless function as a parameter
        In our case, the function expects two optionals, a customers array and error objects, and returns nothing (Void).
        For more info on closures, read this link https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Closures.html
    
        Our CRMServer will query the web service, then it will fill both customers array or error object adequately based on the service response.
        Hence, if we want to call this service from your ViewControllers, we can either do:
            
            CRMService.sharedService.getCustomers({
                customers, error in
    
                if error != nil {
                    showErrorMessage()
                    return
                }
    
                self.customers = customers
            })
    
            Or better yet, since there is no additional parameter after the block we can move the block outside the paranthesis and call it this way:
            
            CRMService.sharedService.getCustomers() {
                customers, error in
            
                if error != nil {
                    showErrorMessage()
                    return
                }
    
                self.customers = customers
            }
    
    */
    func getCustomers(callback: ((customers: [Customer]?, error: NSError?) -> Void)) {
        // Start an http request to /customers url, request type is .GET, and there are no parameters
        Alamofire.request(.GET, "\(baseURL)/customers", parameters: nil)
            .responseJSON { response in
                
                // When we receive the response, we need to check if result is a Success or Failure
                switch response.result {
                case .Success(let JSON):
                    // Parse the returned json
                    var customers = [Customer]()
                    let responseArray = JSON as! NSArray //since we got an array of dictionaries
                    for dict in responseArray { //for each element in the array, read as a dictionary
                        let id: String = dict.objectForKey("id") as! String
                        let name: String = dict.objectForKey("name") as! String
                        let balance: Double = dict.valueForKey("balance") as! Double
                        customers.append(Customer(id: id, name: name, balance: balance)) //Make a customer model from received data
                    }
                    // Finally, we invoke the Closure that was passed by the developer along with the result and a nil error (which says there was no error and everything was fine)
                    callback(customers: customers, error: nil)
                case .Failure(let error):
                    // In case of failure, we invoke the Closure but this time we pass nil as customers and the actual NSError which was received by Alamofire.
                    callback(customers: nil, error: error)
                }
        }
    }
}