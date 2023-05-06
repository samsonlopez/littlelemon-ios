//
//  MenuView.swift
//  Restaurant
//
//  Created by Samson Lopez on 04/05/2023.
//

import SwiftUI
import CoreData

struct MenuView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @State var searchText = ""
    @State var categorySelected = Category.all
    
    @State var showProfileView = false
    
    @State var isError = false
    @State var errorMessage: String = ""
    
    let networkURLString = "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json"
    
    var body: some View {
        VStack {
            MenuNavigationBar(onProfileSelected: {
                print("profile selected")
                showProfileView = true
            })
            NavigationLink(
                destination: ProfileView(),
                isActive: $showProfileView,
                label: { EmptyView() }
            )
            ScrollView {
                VStack(spacing: 0) {
                    HeroView()
                    SearchBar(searchText: $searchText)
                }.background(Colors.primaryColor1)
                
                CategoryView(onCatagorySelected: { category in
                    categorySelected = category
                })

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
        .navigationBarBackButtonHidden(true)
        .background(

        )
    }
    
    @MainActor
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
        if (categorySelected == .all) {
            if searchText.isEmpty {
                return NSPredicate(value: true)
            } else {
                return NSPredicate(format: "title CONTAINS[cd] %@", searchText)
            }
        } else {
            if searchText.isEmpty {
                return NSPredicate(format: "category == %@", categorySelected.value)
            } else {
                return NSPredicate(format: "title CONTAINS[cd] %@ AND category == %@", searchText, categorySelected.value)
            }
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
                .foregroundColor(Colors.primaryColor1)
                .padding(.trailing, 10)
                
                TextField(
                    "Search menu",
                    text: $searchText
                )
            }
            .padding(10)
        }
        .background(Color.white.opacity(0.5))
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .padding(12)
    }
}

private struct MenuNavigationBar: View {
    var onProfileSelected: () -> Void
    
    var body: some View {
        ZStack(alignment: .trailing) {
            Image("logo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 200)
                .frame(maxWidth: .infinity)
            Button {
                onProfileSelected()
            } label: {
                Image("profile-image-placeholder")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 45)
            }.padding(.trailing, 12)
        }.padding(.vertical, 20)
            .frame(maxWidth: .infinity)
    }
}

struct Menu_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
