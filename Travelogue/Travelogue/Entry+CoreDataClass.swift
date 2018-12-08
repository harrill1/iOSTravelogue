//
//  Entry+CoreDataClass.swift
//  Travelogue
//
//  Created by Hayden Harrill on 12/6/18.
//  Copyright © 2018 Hayden Harrill. All rights reserved.
//
//

import UIKit
import CoreData

@objc(Entry)
public class Entry: NSManagedObject {
    var date: Date? {
        get {
            return rawDate as Date?
        }
        set {
            rawDate = newValue as NSDate?
        }
    }
    //ADD PHOTO FUNCTIONALITY
    convenience init?(title: String?, body: String?, date: Date?){
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        guard let context = appDelegate?.persistentContainer.viewContext
            else {
                return nil
        }
        self.init(entity: Trip.entity(), insertInto: context)
        
        self.title = title
        self.date = date
        self.body = body
        
    }
}
