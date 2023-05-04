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
    
    @State var isError = false
    @State var errorMessage: String = ""
    
    let networkURLString = "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json"
    
    var body: some View {
        VStack {
            Text("Little Lemon")
            Text("Chicago")
            Text("[Description]")
            FetchedObjects() { (dishes: [Dish]) in
                List {
                    if dishes.count != 0 {
                        ForEach(dishes, id: \.self) { dish in
                            HStack {
                                VStack (alignment: .leading) {
                                    Text(dish.title!).font(Font.headline.weight(.bold))
                                    Spacer()
                                    Text("$" + dish.price!)
                                }
                                Spacer()
                                AsyncImage(url: URL(string: dish.image!)) {image in image.resizable().aspectRatio(contentMode: .fit).frame(width: 150, height: 100)
                                } placeholder: {
                                    ProgressView()
                                }
                            }
                        }
                    }
                }.listStyle(PlainListStyle())
            }
        }
        .padding()
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
}

struct Menu_Previews: PreviewProvider {
    static var previews: some View {
        Menu()
    }
}
