//
//  UserProfile.swift
//  Restaurant
//
//  Created by Samson Lopez on 04/05/2023.
//

import SwiftUI

struct UserProfile: View {
    @Environment(\.presentationMode) var presentation
    var body: some View {
        let userDefaults = UserDefaults.standard
        let firstName = userDefaults.string(forKey: "kFirstNameKey") ?? ""
        let lastName = userDefaults.string(forKey: "kLastNameKey") ?? ""
        let email = userDefaults.string(forKey: "kEmailKey") ?? ""
        VStack {
            Text("Personal information")
            Image("profile-image-placeholder")
            Text(firstName)
            Text(lastName)
            Text(email)
            Button(action: {
                UserDefaults.standard.set(false, forKey: "IsLoggedInKey")
                self.presentation.wrappedValue.dismiss()
            }, label: {
                Text("Logout")
            })
            Spacer()
        }
    }
}

struct UserProfile_Previews: PreviewProvider {
    static var previews: some View {
        UserProfile()
    }
}
