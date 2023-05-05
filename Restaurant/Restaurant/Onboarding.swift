//
//  Onboarding.swift
//  Restaurant
//
//  Created by Samson Lopez on 03/05/2023.
//

import SwiftUI

struct Onboarding: View {
    @State var firstName = ""
    @State var lastName = ""
    @State var email = ""
    
    @State var isLoggedIn = false
    
    let kFirstName = "FirstNameKey"
    let kLastName = "LastNameKey"
    let kEmail = "EmailKey"
    let kIsLoggedIn = "IsLoggedInKey"
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: Home(), isActive: $isLoggedIn) {
                    EmptyView()
                }
                TextField("First name", text: $firstName)
                TextField("Last name", text: $lastName)
                TextField("Email", text: $email).keyboardType(.emailAddress)
                
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
                }
                
            }
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding(20)
        }
        .onAppear(){
            if UserDefaults.standard.bool(forKey: kIsLoggedIn) {
                isLoggedIn = true
            }
        }
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    fileprivate func saveRegistrationFields() {
        print("Saving registration fields")
        let userDefaults = UserDefaults.standard
        userDefaults.set(firstName, forKey: kFirstName)
        userDefaults.set(lastName, forKey: kLastName)
        userDefaults.set(email, forKey: kEmail)
        userDefaults.set(isLoggedIn, forKey: kIsLoggedIn)
    }
}

struct Onboarding_Previews: PreviewProvider {
    static var previews: some View {
        Onboarding()
    }
}
