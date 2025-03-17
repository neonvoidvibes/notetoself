//
//  JournalEntry+CoreDataProperties.swift
//  Note to Self
//
//  Created by Stefan Ekwall on 2025-03-17.
//
//

import Foundation
import CoreData


extension JournalEntry {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<JournalEntry> {
        return NSFetchRequest<JournalEntry>(entityName: "JournalEntry")
    }

    @NSManaged public var text: String?
    @NSManaged public var mood: String?
    @NSManaged public var timestamp: Date?

}

extension JournalEntry : Identifiable {

}
