//
//  ProfileView.swift
//  cwcmeditate
//
//  Created by Chris Ching on 2022-06-29.
//

import SwiftUI
import RevenueCat

struct ProfileView: View {
    
    @EnvironmentObject var userViewModel: UserViewModel
    
    var body: some View {
        
        
        GeometryReader { proxy in
            VStack (alignment: .leading, spacing: 30) {
            Text("Account")
                .bold()
                .font(Font.largeTitle)
                .padding(.bottom, 20)
            
                HStack {
            Text("Subscription Status:")
                .bold()
            
                    Text(userViewModel.isSubscriptionActive ? "Pro" : "Free")
                
                }
            
            Button {
                // Restore Purchases
                Purchases.shared.restorePurchases { (customerInfo, error) in
                    //... check customerInfo to see if entitlement is now active
                    
                    userViewModel.isSubscriptionActive = customerInfo?.entitlements.all["pro"]?.isActive == true
                }
                
            } label: {
                
                Text("Restore Purchases")
                    .padding()
                    .background(.blue)
                    .cornerRadius(10)
                    .foregroundColor(.white)
                
            }

        }
            .padding(.top, 50)
            .padding(.horizontal)
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
