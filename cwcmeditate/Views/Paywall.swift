//
//  Paywall.swift
//  cwcmeditate
//
//  Created by Chris Ching on 2022-06-29.
//

import SwiftUI
import RevenueCat

struct Paywall: View {
    
    @Binding var isPaywallPresented: Bool
    
    @State var currentOffering: Offering?
    
    @EnvironmentObject var userViewModel: UserViewModel
    
    var body: some View {
        
        VStack (alignment: .leading, spacing: 20) {
            Text("Meditate Plus")
                .bold()
                .font(Font.largeTitle)
            
            Text("Unlock all guided meditations and deeper analytics.")
            
            
            Spacer()
            
            VStack (spacing: 40) {
                HStack {
                    Image(systemName: "brain.head.profile")
                    Text("Clear your head and improve your memory")
                }
                
                HStack {
                    Image(systemName: "checkmark.icloud")
                    Text("Download meditations for offline sessions")
                }
                
                HStack {
                    Image(systemName: "shareplay")
                    Text("Destress and get better sleep")
                }
            }
            Spacer()
            
            if currentOffering != nil {
                
                ForEach(currentOffering!.availablePackages) { pkg in
                    
                    Button {
                        // BUY
                        Purchases.shared.purchase(package: pkg) { (transaction, customerInfo, error, userCancelled) in
                            
                            if customerInfo?.entitlements.all["pro"]?.isActive == true {
                                // Unlock that great "pro" content
                                
                                userViewModel.isSubscriptionActive = true
                                isPaywallPresented = false
                            }
                        }
                        
                    } label: {
                        
                        ZStack {
                            Rectangle()
                                .frame(height: 55)
                                .foregroundColor(.blue)
                                .cornerRadius(10)
                            
                            
                            Text("\(pkg.storeProduct.subscriptionPeriod!.periodTitle) \(pkg.storeProduct.localizedPriceString)")
                                .foregroundColor(.white)
                        }
                    }
                }
                
                
            }
            
            
            Spacer()
            
            Text("Better sleep, less stress and a clear head is just around the corner.")
            
        }
        .padding(50)
        .onAppear {
            
            Purchases.shared.getOfferings { offerings, error in
                
                if let offer = offerings?.current, error == nil {
                    
                    currentOffering = offer
                }
            }
        }
    }
}

struct Paywall_Previews: PreviewProvider {
    static var previews: some View {
        Paywall(isPaywallPresented: .constant(false))
    }
}
