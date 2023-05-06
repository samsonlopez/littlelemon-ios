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
    
    @State var isLoggedIn = false
    
    let kFirstName = "FirstNameKey"
    let kLastName = "LastNameKey"
    let kEmail = "EmailKey"
    let kIsLoggedIn = "IsLoggedInKey"
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            NavigationLink(destination: HomeView(), isActive: $isLoggedIn) { }
            Text("First name *")
                .onboardingTextStyle()
            TextField("", text: $firstName)
                .onboardingTextFieldStyle()
            Text("Last name *")
                .onboardingTextStyle()
            TextField("", text: $lastName)
                .onboardingTextFieldStyle()
            Text("E-mail *")
                .onboardingTextStyle()
            TextField("", text: $email)
                .onboardingTextFieldStyle()
                .keyboardType(.emailAddress)
        }.padding()
        
        Button {
            if(!firstName.isEmpty &&
               !lastName.isEmpty &&
               !email.isEmpty) &&
                isValidEmail(email) {
                saveRegistrationFields()
                isLoggedIn = true
            }
        } label: {
            Text("Register")
                .font(Fonts.labelText())
        }
        .buttonStyle(CustomButtonStyle())
        .padding()
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    fileprivate func saveRegistrationFields() {
        let userDefaults = UserDefaults.standard
        userDefaults.set(firstName, forKey: kFirstName)
        userDefaults.set(lastName, forKey: kLastName)
        userDefaults.set(email, forKey: kEmail)
        userDefaults.set(isLoggedIn, forKey: kIsLoggedIn)
    }
}

struct RegistrationFormView_Previews: PreviewProvider {
    
    @State static var firstName = "Jane"
    @State static var lastName = "Smith"
    @State static var email = "jane.smith@world.com"
    
    static var previews: some View {
        RegistrationFormView(firstName: $firstName, lastName: $lastName, email: $email)
    }
}
