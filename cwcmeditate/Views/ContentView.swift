//
//  ContentView.swift
//  cwcmeditate
//
//  Created by Chris Ching on 2022-06-28.
//

import SwiftUI

struct ContentView: View {
    
    @State var isPaywallPresented = false
    
    @EnvironmentObject var userViewModel: UserViewModel
    
    var body: some View {
        
        TabView {
            
            NavigationView {
                
                ScrollView (showsIndicators: false) {
                    
                    VStack (alignment: .leading) {
                        
                        if !userViewModel.isSubscriptionActive {
                        
                            // CTA to sign up
                        ZStack {
                            
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.white, lineWidth: 3)
                                
                            
                            VStack (alignment: .leading){
                                Text("Sign up for our monthly plan to access all the meditations!")
                                
                                Button {
                                    // TODO
                                    isPaywallPresented = true
                                    
                                } label: {
                                    Text("Let's do it")
                                }
                                .padding(10)
                                .background(Color.blue)
                                .cornerRadius(10)
                                .foregroundColor(Color.white)
                            }
                            .padding(20)
                        }
                        .padding([.top, .bottom], 20)
                        
                        }
                        
                        ForEach(Meditation.getSampleMeditations()) { meditation in
                            
                            Button {
                                
                                if userViewModel.isSubscriptionActive {
                                    // TODO: Show  meditation
                                }
                                else {
                                isPaywallPresented = true
                                }
                                
                            } label: {
                                Card(meditation: meditation)
                                    .padding(.bottom, 20)
                            }
                            
                        }
                    }
                    .padding(.horizontal, 1.5)
                }
                .padding(.horizontal)
                .navigationTitle("Meditations")
                
            }
            
            .tabItem {
                VStack {
                    Image(systemName: "lasso.and.sparkles")
                    Text("Meditate")
                }
            }
            
            ProfileView()
                .tabItem {
                    VStack {
                        Image(systemName: "person.crop.circle")
                        Text("Account")
                        
                    }
                }
            
        }
        .sheet(isPresented: $isPaywallPresented, onDismiss: nil) {
            
            Paywall(isPaywallPresented: $isPaywallPresented)
        }
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
