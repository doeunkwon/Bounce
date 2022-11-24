//
//  CoreDataManager.swift
//  Bounce
//
//  Created by Doeun Kwon on 2022-11-24.
//

import UIKit
import CoreData

class CoreDataManager {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func loadSchedule(_ scheduleArray: inout [Schedule]) {
        let request : NSFetchRequest<Schedule> = Schedule.fetchRequest()
        do {
            scheduleArray = try context.fetch(request)
        } catch {
            print("Error fetching data from context \(error)")
        }
    }
    
    func loadPreference(_ preferenceArray: inout [Preference]) {
        let request : NSFetchRequest<Preference> = Preference.fetchRequest()
        do {
            preferenceArray = try context.fetch(request)
        } catch {
            print("Error fetching data from context \(error)")
        }
    }
    
    func loadEvents(_ eventArray: inout [Event]) {
        let request : NSFetchRequest<Event> = Event.fetchRequest()
        do {
            eventArray = try context.fetch(request)
        } catch {
            print("Error fetching data from context \(error)")
        }
    }
    
    func save() {
        do {
            try context.save()
        } catch {
            print("Error saving context \(error)")
        }
    }
    
    func delete(_ entity: NSManagedObject) {
        context.delete(entity)
    }
    
}
