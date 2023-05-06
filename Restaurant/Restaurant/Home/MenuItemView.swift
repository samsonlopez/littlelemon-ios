//
//  MenuItemView.swift
//  Restaurant
//
//  Created by Samson Lopez on 05/05/2023.
//

import SwiftUI

struct MenuItemView: View {
    @ObservedObject var dish: Dish

    var body: some View {
        HStack(alignment: .center) {
            VStack (alignment: .leading) {
                Text(dish.title!).font(Font.headline.weight(.bold))
                Text(dish.desc ?? "")
                    .font(Fonts.paragraphText())
                    .foregroundColor(Colors.highlightColor2)
                    .lineLimit(2)
                    .padding(.bottom, 15)
                    .frame(maxWidth: .infinity, alignment: .leading)

                Text("$" + dish.price!)
            }
            Spacer()
            AsyncImage(url: URL(string: dish.image!)) {image in
                image.resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 140, height: 100)
                    .clipped()
            } placeholder: {
                ProgressView()
            }
        }.padding(20)
    }
}

