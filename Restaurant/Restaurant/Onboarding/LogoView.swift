//
//  LogoView.swift
//  Restaurant
//
//  Created by Samson Lopez on 06/05/2023.
//

import SwiftUI

struct LogoView: View {
    var body: some View {
        Image("logo")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 200)
            .padding(.vertical, 20)
    }
}
