//
// Dish+Extension.swift

import Foundation
import CoreData

extension Dish {
    
    static func createDishesFrom(menuItems:[MenuItem],
                                 _ context:NSManagedObjectContext) {
        for menuItem in menuItems {
            if !exists(name: menuItem.title, context) {
                let dish = Dish(context: context)
                dish.title = menuItem.title
                dish.desc = menuItem.description
                dish.image = menuItem.image
                dish.price = menuItem.price
                dish.category = menuItem.category
            }
        }
    }
    
    static func exists(name: String,
                       _ context:NSManagedObjectContext) -> Bool {
        let request = Dish.fetchRequest()
        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", name)
        request.predicate = predicate
        
        do {
            guard let results = try context.fetch(request) as? [Dish]
            else {
                return false
            }
            return results.count > 0
        } catch (let error){
            print(error.localizedDescription)
            return false
        }
    }
    
    static func deleteAllDishes(_ context: NSManagedObjectContext) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Dish")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch {
            print("Error deleting objects")
        }
    }
}

