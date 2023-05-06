//
//  Style.swift
//  Restaurant
//
//  Created by Samson Lopez on 05/05/2023.
//

import Foundation
import SwiftUI

extension Text {
    func textStyle() -> some View {
        self
            .frame(maxWidth: .infinity, alignment: .leading)
            .foregroundColor(Colors.primaryColor1)
            .font(Fonts.labelText())
            .padding(.bottom, 8)
    }
}

extension TextField {
    func textFieldStyle() -> some View {
        self.padding(10)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .strokeBorder(Color.gray, lineWidth: 1)
            ).accentColor(.yellow)
                .padding(.bottom, 16)
    }
}

struct PrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity)
            .padding(10)
            .foregroundColor(Colors.highlightColor2)
            .background(
                configuration.isPressed ? Colors.primaryColor2.opacity(0.8) : Colors.primaryColor2
            )
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
            .stroke(
                Colors.secondaryColor1, lineWidth: 1)
            )
            
    }
}

struct SecondaryButtonStyle1: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity)
            .padding(10)
            .foregroundColor(Colors.highlightColor1)
            .background(
                configuration.isPressed ? Colors.primaryColor1.opacity(0.8) : Colors.primaryColor1
            )
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
            .stroke(
                Colors.primaryColor1, lineWidth: 1)
            )
            
    }
}

struct SecondaryButtonStyle2: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity)
            .padding(10)
            .foregroundColor(Colors.highlightColor2)
            .background(
                configuration.isPressed ? Colors.primaryColor1.opacity(0.1) : Colors.primaryColor1.opacity(0.3)
            )
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
            .stroke(
                Colors.primaryColor1, lineWidth: 1)
            )
            
    }
}

