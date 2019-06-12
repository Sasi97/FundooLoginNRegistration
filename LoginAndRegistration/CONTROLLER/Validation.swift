//
//  Validation.swift
//  Fundo
//
//  Created by BridgeLabz Solutions LLP  on 6/3/19.
//  Copyright © 2019 Apple Inc. All rights reserved.
//

import Foundation
import CoreData
import UIKit
public class Validation{
    static var result=NSArray()
   
    
    static func isEmailValid(email:String)->Bool{
        
        let regex="[A-Za-z0-9.@%#!-]+@[A-Za-z0-9.-]+.[A-Za-z0-9]{2,3}"
        let test = NSPredicate(format:"SELF MATCHES[c] %@", regex)
         return test.evaluate(with: email)
    }
    static func isPasswordValid(password : String) -> Bool{
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "[A-Za-z0-9\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }
   
    static func checkForEmailAndPasswordMatch( email: String, password : String)->Bool
    {
        let app = UIApplication.shared.delegate as! AppDelegate
         var success = false
        
        let context = app.persistentContainer.viewContext
        
        let fetchrequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        
        let predicate = NSPredicate(format: "email = %@", email)
        
        fetchrequest.predicate = predicate
        do
        {
            result = try context.fetch(fetchrequest) as NSArray
            
            if result.count>0
            {
                let objectentity = result.filtered(using: predicate) as! Users
                
                if objectentity.email == email && objectentity.password == password {
                
                    print("Login Succesfully")
                    success = true
                }
                else
                {
                    print("Wrong username or password !!!")
                    success = false
                }
        
            }
        }
            
        catch
        {
            let fetch_error = error as NSError
            print("error", fetch_error.localizedDescription)
        }
        
        return success
    }
    
    
}
