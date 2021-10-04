//
//  Movie+CoreDataProperties.swift
//  CoreDataProject
//
//  Created by Alex Oliveira on 04/10/21.
//
//

import Foundation
import CoreData


extension Movie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Movie> {
        return NSFetchRequest<Movie>(entityName: "Movie")
    }

    @NSManaged public var title: String?
    @NSManaged public var director: String?
    @NSManaged public var year: Int16
    
    public var wrappedTitle: String {  // This way the whole rest of the code doesn't have to worry about CoreData's optionality
        return title ?? "Unknown title" // And changes to default values can be done in a single file
    }

}

extension Movie : Identifiable {

}
