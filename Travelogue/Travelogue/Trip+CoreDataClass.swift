//
//  Trip+CoreDataClass.swift
//  Travelogue
//
//  Created by Hayden Harrill on 12/6/18.
//  Copyright © 2018 Hayden Harrill. All rights reserved.
//
//

import UIKit
import CoreData

@objc(Trip)
public class Trip: NSManagedObject {
    var entrys: [Entry]? {
        return self.entry?.array as? [Entry]
    }
    
    convenience init?(title: String?){
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        guard let context = appDelegate?.persistentContainer.viewContext
            else {
                return nil
        }
        
        self.init(entity: Trip.entity(), insertInto: context)
        
        self.title = title
        
    }
}
