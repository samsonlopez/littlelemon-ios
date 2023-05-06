//
//  RegistrationFormView.swift
//  Restaurant
//
//  Created by Samson Lopez on 05/05/2023.
//

import SwiftUI

struct RegistrationFormView: View {
    @Binding var firstName: String
    @Binding var lastName: String
    @Binding var email: String
    @Binding var isLoggedIn: Bool
    
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    let kFirstName = "FirstNameKey"
    let kLastName = "LastNameKey"
    let kEmail = "EmailKey"
    let kIsLoggedIn = "IsLoggedInKey"
    
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 0) {
                Text("First name *")
                    .textStyle()
                TextField("", text: $firstName)
                    .textFieldStyle()
                Text("Last name *")
                    .textStyle()
                TextField("", text: $lastName)
                    .textFieldStyle()
                Text("E-mail *")
                    .textStyle()
                TextField("", text: $email)
                    .textFieldStyle()
                    .keyboardType(.emailAddress)
            }.padding()
            
            Button {
                if (firstName.trim.isEmpty || lastName.trim.isEmpty || email.trim.isEmpty) {
                    alertMessage = "Please enter all required fields"
                    showAlert.toggle()
                } else if !email.isValidEmail() {
                    alertMessage = "Please enter a valid email"
                    showAlert.toggle()
                } else {
                    isLoggedIn = true
                    saveProfile()
                }
            } label: {
                Text("Register")
                    .font(Fonts.labelText())
            }
            .buttonStyle(PrimaryButtonStyle())
            .padding()
            .alert(isPresented: $showAlert) {
                Alert(title: Text(alertMessage))
            }
            
            Spacer()
        }
    }
    
    fileprivate func saveProfile() {
        let userSettings = UserSettings.shared
        userSettings.firstName = firstName
        userSettings.lastName = lastName
        userSettings.email = email
        userSettings.isLoggedIn = isLoggedIn
    }
}

struct RegistrationFormView_Previews: PreviewProvider {
    @State static var firstName = "Jane"
    @State static var lastName = "Smith"
    @State static var email = "jane.smith@world.com"
    @State static var isLoggedIn = false
    
    static var previews: some View {
        RegistrationFormView(firstName: $firstName, lastName: $lastName, email: $email, isLoggedIn: $isLoggedIn)
    }
}
