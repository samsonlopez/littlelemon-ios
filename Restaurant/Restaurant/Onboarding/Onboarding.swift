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
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: HomeView(), isActive: $isLoggedIn) {
                    EmptyView()
                }
                Image("logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200)
                    .padding(.vertical, 20)
                HeroView()
                RegistrationFormView(
                    firstName: $firstName,
                    lastName: $lastName,
                    email: $email
                )
                .padding(.vertical, 20)
                .frame(maxWidth: .infinity)
                Spacer()
                
            }
        }
        .onAppear(){
            if UserDefaults.standard.bool(forKey: "IsLoggedInKey") {
                isLoggedIn = true
            }
        }
    }
}

struct Onboarding_Previews: PreviewProvider {
    static var previews: some View {
        Onboarding()
    }
}
