//
//  CoreDataFunCls.swift
//  Fundo
//
//  Created by BridgeLabz Solutions LLP  on 6/3/19.
//  Copyright © 2019 Apple Inc. All rights reserved.
//

import Foundation
import UIKit
import CoreData
public class CoreDataHelper {
    
    
    static var appDel:AppDelegate!
    static var entityDescription:NSEntityDescription!
    static var moc:NSManagedObjectContext!
    static var arrayNames=[String]()
    static var arrayEmails=[String]()
    static var arrayPasswords=[String]()
    
    static func getDataFromFields(name:String,email:String,password:String)  {
        appDel=UIApplication.shared.delegate as? AppDelegate
        moc=appDel.persistentContainer.viewContext
        entityDescription=NSEntityDescription.entity(forEntityName:"Users", in: moc)
        let mngdObj=NSManagedObject(entity: entityDescription, insertInto: moc)
        mngdObj.setValue(name, forKey:"name")
        mngdObj.setValue(email, forKey:"email")
        mngdObj.setValue(password, forKey:"password")
        
        do{
            try moc.save()
            print("DONE USER SAVED TO COREDATA")
        }catch{
            print("ERROR SAVING TO COREDATA")
            
        }
        arrayNames.append(mngdObj.value(forKey: "name") as! String)
        arrayEmails.append(mngdObj.value(forKey: "email") as! String)
        arrayPasswords.append(mngdObj.value(forKey: "password") as! String)
        for i in 0..<arrayNames.count{
            print("USER-\(i)")
            print("*******")
            print(arrayNames[i])
            print(arrayEmails[i])
            print(arrayPasswords[i])
        }
        
        
    }
    static func checkForUser (email:String,password:String)-> Bool{
        
        var result = false
        appDel=UIApplication.shared.delegate as? AppDelegate
        moc=appDel.persistentContainer.viewContext
        entityDescription=NSEntityDescription.entity(forEntityName:"Users", in: moc)
        let frequest=NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        frequest.predicate=NSPredicate(format: "email = %@", email)
        do{
            var fetchArray=try moc.fetch(frequest)
            for i in 0..<fetchArray.count{
                let mngObj2=fetchArray[i] as! NSManagedObject
                let dBEmail=mngObj2.value(forKey: "email") as! String
                let dBPassword = mngObj2.value(forKey: "password") as! String
                if email == dBEmail && password == dBPassword {
                    print("User Exist")
                    result = true
                }else{
                    result = false
                }
            }
        }catch{
            print("error in fetching")
        }
        return result
    }
    static func deleteDataFromCoreData(){
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try moc.execute(batchDeleteRequest)
            print("Deleted all objects from coredata")
            
        } catch {
            print("Error deleting all data from coredata")
        }
        
    }
    
    
}

