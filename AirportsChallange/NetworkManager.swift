//
//  NetworkManager.swift
//  AirportsChallange
//
//  Created by karthik on 6/16/17.
//  Copyright © 2017 com.honeywell. All rights reserved.
//

import UIKit
import Alamofire
typealias succesblock = ([String: Any], Error?)->Void
class NetworkManager: NSObject {
    
    public static let shared:NetworkManager={
        let instance=NetworkManager()
        return instance
    }()
    
   private  override init() {
    
    }
    
    func getAirports(param:[String:Any],completionHandler:@escaping succesblock) -> Void {
        
        var parammutable=param
        parammutable.updateValue("cb128aa11db39f18fdfbf4000bbf3b3d", forKey: "session_id")
        parammutable.updateValue("550299", forKey: "gdc_id")
        parammutable.updateValue("550299", forKey: "Password")
        parammutable.updateValue("200869", forKey: "customer_id")
        
        
        Alamofire.request("http://bronze-qa1.mygdc.com/~devel/ipadredesignqa/index.php/web_services/AirportInfo/getAirportInfo/format/json", method: .post, parameters: parammutable).responseJSON { (response) in
                if let JSON = response.result.value {
                    print("JSON: \(JSON)")
                    completionHandler(JSON as! [String: Any],nil)
            }
        }
        
    }
    
    
    
}
