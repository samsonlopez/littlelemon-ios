//
//  PersonalInformationView.swift
//  Restaurant
//
//  Created by Samson Lopez on 06/05/2023.
//

import SwiftUI

struct PersonalInformationView: View {
    @Binding var firstName: String
    @Binding var lastName: String
    @Binding var email: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Personal Information")
                .font(Fonts.sectionTitle())
                .padding(.bottom, 16)
            
            Text("First Name")
                .textStyle()
            TextField("", text: $firstName)
                .textFieldStyle()
            
            Text("Last Name")
                .textStyle()
            TextField("", text: $lastName)
                .textFieldStyle()
            
            Text("Email")
                .textStyle()
            TextField("", text: $email)
                .textFieldStyle()
        }
        .padding()
        .onAppear() {
            getProfile()
        }
    }
    
    func getProfile() {
        let userSettings = UserSettings.shared
        firstName = userSettings.firstName
        lastName = userSettings.lastName
        email = userSettings.email
    }
}
