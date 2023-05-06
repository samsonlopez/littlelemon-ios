//
//  RestaurantApp.swift
//  Restaurant
//
//  Created by Samson Lopez on 03/05/2023.
//

import SwiftUI

@main
struct RestaurantApp: App {
    let persistence = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            HomeView()
                .environment(\.managedObjectContext, persistence.container.viewContext)
        }
    }
}
