//
//  Onboarding.swift
//  Restaurant
//
//  Created by Samson Lopez on 03/05/2023.
//

import SwiftUI

struct OnboardingView: View {
    @Binding var isLoggedIn: Bool

    @State var firstName = ""
    @State var lastName = ""
    @State var email = ""
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: HomeView(), isActive: $isLoggedIn) {
                    EmptyView()
                }
                LogoView()
                HeroView()
                RegistrationFormView(
                    firstName: $firstName,
                    lastName: $lastName,
                    email: $email,
                    isLoggedIn: $isLoggedIn
                )
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
    @State static var isLoggedIn = true
    
    static var previews: some View {
        OnboardingView(isLoggedIn: $isLoggedIn)
    }
}
