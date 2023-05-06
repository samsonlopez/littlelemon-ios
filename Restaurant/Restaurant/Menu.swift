//
//  Menu.swift
//  Restaurant
//
//  Created by Samson Lopez on 04/05/2023.
//

import SwiftUI
import CoreData

struct Menu: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @State var searchText = ""
    
    @State var isError = false
    @State var errorMessage: String = ""
    
    let networkURLString = "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json"
    
    var body: some View {
        VStack {
            ScrollView {
                Image("logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200)
                    .padding(.vertical, 20)
                
                VStack(spacing: 0) {
                    HeroView()
                    SearchBar(searchText: $searchText)
                }.background(Colors.primaryColor1)

                FetchedObjects(predicate: buildPredicate(), sortDescriptors: buildSortDescriptors()) { (dishes: [Dish]) in
                    ForEach(dishes, id: \.self) { dish in
                        MenuItemView(dish: dish)
                    }
                }
            }
        }
        .task {
            await getMenuData()
        }
        .alert(errorMessage, isPresented: $isError) {
        }
    }
    
    func getMenuData() async {
        let url = URL(string: networkURLString)!
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let fullMenu = try JSONDecoder().decode(MenuList.self, from: data)
            Dish.createDishesFrom(menuItems: fullMenu.menu, viewContext)
            try? viewContext.save()
            
        } catch {
            print(error)
            errorMessage = "Unable to fetch data"
            isError = true
        }
    }
    
    func buildSortDescriptors() -> [NSSortDescriptor] {
        return [NSSortDescriptor (key: "title", ascending: true, selector: #selector(NSString.localizedStandardCompare))]
    }
    
    func buildPredicate() -> NSPredicate {
        if searchText.isEmpty {
            return NSPredicate(value: true)
        } else {
            return NSPredicate(format: "title CONTAINS[cd] %@", searchText)
        }
    }
}

private struct SearchBar: View {
    
    @Binding var searchText: String
    
    var body: some View {
        VStack() {
            HStack() {
                Image(
                    systemName: "magnifyingglass"
                )
                .foregroundColor(.gray)
                .padding(.trailing, 10)
                
                TextField(
                    "Enter search phrase",
                    text: $searchText
                )
            }
            .padding()
        }
        .background(Color.white.opacity(0.5))
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .padding(12)
    }
}

struct Menu_Previews: PreviewProvider {
    static var previews: some View {
        Menu()
    }
}
