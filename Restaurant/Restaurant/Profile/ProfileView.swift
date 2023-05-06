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
    
    @State var firstName = ""
    @State var lastName = ""
    @State var email = ""
    
    @State private var showAlert = false
    @State private var alertMessage = ""

    var body: some View {
        VStack {
            ProfileNavigationBar(onBackButtonSelected: {
                self.presentation.wrappedValue.dismiss()
            })
            NavigationLink(
                destination: HomeView(),
                isActive: $navigateToOnboardingView,
                label: { EmptyView() }
            )
            
            PersonalInformationView(
                firstName: $firstName,
                lastName: $lastName,
                email: $email
            )
            .padding(.vertical, 20)
            .frame(maxWidth: .infinity)
            Spacer()

            Button(action: {
                UserSettings.shared.clear()
                navigateToOnboardingView = true
            }, label: {
                Text("Logout")
            })
            .buttonStyle(
                PrimaryButtonStyle()
            ).padding()
            
            HStack {
                Button {
                    discardProfileChanges()
                } label: {
                    Text("Discard Changes")
                        .font(Fonts.labelText())
                }.buttonStyle(
                    SecondaryButtonStyle2()
                )
                Spacer().frame(width: 20)
                Button {
                    if (firstName.trim.isEmpty || lastName.trim.isEmpty || email.trim.isEmpty) {
                        alertMessage = "Please enter all required fields"
                        showAlert.toggle()
                    } else if !email.isValidEmail() {
                        alertMessage = "Please enter a valid email"
                        showAlert.toggle()
                    } else {
                        saveProfileChanges()
                    }
                } label: {
                    Text("Save Changes")
                        .font(Fonts.labelText())
                }.buttonStyle(
                    SecondaryButtonStyle1()
                )
            }.padding(.horizontal, 16)
            Spacer()
        }
        .navigationBarHidden(true)
        .alert(isPresented: $showAlert) {
            Alert(title: Text(alertMessage))
        }
    }
    
    fileprivate func saveProfileChanges() {
        let userSettings = UserSettings.shared
        userSettings.firstName = firstName
        userSettings.lastName = lastName
        userSettings.email = email
    }
    
    fileprivate func discardProfileChanges() {
        let userSettings = UserSettings.shared
        firstName = userSettings.firstName
        lastName = userSettings.lastName
        email = userSettings.email
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
