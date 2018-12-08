//
//  Entry+CoreDataProperties.swift
//  Travelogue
//
//  Created by Hayden Harrill on 12/6/18.
//  Copyright © 2018 Hayden Harrill. All rights reserved.
//
//

import Foundation
import CoreData


extension Entry {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Entry> {
        return NSFetchRequest<Entry>(entityName: "Entry")
    }

    @NSManaged public var title: String?
    @NSManaged public var rawDate: NSDate?
    @NSManaged public var body: String?
    //@NSManaged public var photo: NSData?
    //@NSManaged public var filePath: String?
    @NSManaged public var trip: Trip?

}
