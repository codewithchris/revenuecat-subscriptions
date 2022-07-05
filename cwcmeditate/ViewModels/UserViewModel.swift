//
//  UserViewModel.swift
//  cwcmeditate
//
//  Created by Chris Ching on 2022-07-02.
//

import Foundation
import SwiftUI
import RevenueCat

class UserViewModel: ObservableObject {
    
    @Published var isSubscriptionActive = false
    
    init() {
        
        Purchases.shared.getCustomerInfo { (customerInfo, error) in
            
                
            self.isSubscriptionActive = customerInfo?.entitlements.all["pro"]?.isActive == true
            
        }
    }
    
}
