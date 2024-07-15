//
//  TopNavView.swift
//  CreativeLens
//
//  Created by Boseok Son on 7/11/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct TopNavView: View {
    var body: some View {
        VStack {
            ZStack {
                VStack {
                    
                    HStack {
                        Spacer()
                            .frame(width: 25)
                        
                        NavigationLink(destination:
                                        MainView().navigationBarBackButtonHidden(true)) {
                            Image("LogoBlue")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 39)
                        }
                        
                        Spacer()
                        
                        NavigationLink(destination:
                                        ProfileView().navigationBarBackButtonHidden(true)) {
                            AnimatedImage(url: URL(string: "https://raw.githubusercontent.com/Tarikul-Islam-Anik/Animated-Fluent-Emojis/master/Emojis/Smilies/Smiling%20Face%20with%20Smiling%20Eyes.png"))
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 44)
                                .clipShape(Circle())
                        }
                        
                        Spacer()
                            .frame(width: 25)
                    }
                    .padding(.top, 90)
                }
                .frame(height: 50)
            }
            .ignoresSafeArea()
            .frame(maxWidth: .infinity)
            .background(Color.white)
            
            Spacer()
        }
        .frame(height: 100)
        .background(Color.white)
        .zIndex(5)
    }
}

#Preview {
    TopNavView()
}
