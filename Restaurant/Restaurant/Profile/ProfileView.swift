//
//  UserProfile.swift
//  Restaurant
//
//  Created by Samson Lopez on 04/05/2023.
//

import SwiftUI

struct ProfileView: View {
    @Environment(\.presentationMode) var presentation
    @Environment(\.managedObjectContext) private var viewContext

    @State var navigateToOnboardingView = false

    var body: some View {
        let userDefaults = UserDefaults.standard
        let firstName = userDefaults.string(forKey: "FirstNameKey") ?? ""
        let lastName = userDefaults.string(forKey: "LastNameKey") ?? ""
        let email = userDefaults.string(forKey: "EmailKey") ?? ""
        VStack {
            ProfileNavigationBar(onBackButtonSelected: {
                print("back button selected")
                self.presentation.wrappedValue.dismiss()
            })
            NavigationLink(
                destination: HomeView(),
                isActive: $navigateToOnboardingView,
                label: { EmptyView() }
            )
            Text("Personal information")
            Image("profile-image-placeholder")
            Text(firstName)
            Text(lastName)
            Text(email)
            Button(action: {
                UserDefaults.standard.set(false, forKey: "IsLoggedInKey")
                navigateToOnboardingView = true
            }, label: {
                Text("Logout")
            })
            Spacer()
        }
        .navigationBarHidden(true)
    }
}

private struct ProfileNavigationBar: View {
    var onBackButtonSelected: () -> Void
    
    var body: some View {
        ZStack() {
            Image("logo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 200)
                .frame(maxWidth: .infinity)
            HStack {
                Button {
                    onBackButtonSelected()
                } label: {
                    Circle()
                        .foregroundColor(Colors.primaryColor1)
                        .frame(width: 35, height: 35)
                        .overlay(
                            Image(systemName: "arrow.backward")
                                .foregroundColor(.white)
                        )
                }.padding(.leading, 12)
                Spacer()
                Image("profile-image-placeholder")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 45)
                    .padding(.trailing, 12)
            }.frame(maxWidth: .infinity)
            
        }.padding(.vertical, 20)
            .frame(maxWidth: .infinity)
    }
}

struct UserProfile_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
