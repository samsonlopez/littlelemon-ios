//
//  Home.swift
//  Restaurant
//
//  Created by Samson Lopez on 04/05/2023.
//

import SwiftUI

struct Home: View {
    var body: some View {
        TabView {
            Text("Menu")
                .tabItem({
                    Label("Menu", systemImage: "list.dash")
                })
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
