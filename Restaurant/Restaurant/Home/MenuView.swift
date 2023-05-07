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
    
    @StateObject private var menuViewModel: MenuViewModel = MenuViewModel()
        
    var body: some View {
        VStack {
            MenuNavigationBar(onProfileSelected: {
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
            do {
                try await menuViewModel.getMenuData(context: viewContext)
            } catch {
                errorMessage = "Unable to fetch data"
                isError = true
            }
        }
        .alert(isPresented: $isError) {
            Alert(title: Text(errorMessage))
        }
        .navigationBarBackButtonHidden(true)
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
    static let persistence = PersistenceController.shared
    
    static var previews: some View {
        MenuView()
            .environment(\.managedObjectContext, persistence.container.viewContext)
    }
}
