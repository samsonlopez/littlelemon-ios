//
//  HomeView.swift
//  Restaurant
//
//  Created by Samson Lopez on 04/05/2023.
//

import SwiftUI

struct HomeView: View {
    let persistence = PersistenceController.shared
    
    var body: some View {
        TabView {
            MenuView()
                .environment(\.managedObjectContext, persistence.container.viewContext)
                .tabItem({
                    Label("Menu", systemImage: "list.dash")
                })
            ProfileView()
                .tabItem({
                    Label("Profile", systemImage: "square.and.pencil")
                })
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
