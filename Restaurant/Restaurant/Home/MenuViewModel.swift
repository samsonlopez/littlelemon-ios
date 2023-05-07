//
//  HomeViewModel.swift
//  Restaurant
//
//  Created by Samson Lopez on 07/05/2023.
//

import Foundation
import CoreData

class MenuViewModel: ObservableObject {
    private let networkURLString = "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json"

    // This method directly accesses URLSession to fetch data.
    // There is no separate network layer, focus is on SwiftUI and UI/UX Design.
    // Futher architecture and layering is not considered at this time to keep it simple.
    
    @MainActor
    func getMenuData(context: NSManagedObjectContext) async throws {
        let url = URL(string: networkURLString)!
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let menuList = try JSONDecoder().decode(MenuList.self, from: data)
            Dish.createDishesFrom(menuItems: menuList.menu, context)
            try? context.save()
        } catch {
            throw error
        }
    }
}
