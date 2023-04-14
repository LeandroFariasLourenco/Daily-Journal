//
//  Entry+CoreDataProperties.swift
//  Daily Journal
//
//  Created by Leandro Farias Lourenco on 17/02/23.
//
//

import Foundation
import CoreData


extension Entry {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Entry> {
        return NSFetchRequest<Entry>(entityName: "Entry")
    }

    @NSManaged public var date: Date?
    @NSManaged public var text: String?

}

extension Entry : Identifiable {
    
    private func handleDateFormat(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: date!).uppercased()
    }
    
    func month() -> String {
        return self.handleDateFormat(format: "MMM")
    }
    
    func day() -> String {
        return self.handleDateFormat(format: "d")
    }
    
}
