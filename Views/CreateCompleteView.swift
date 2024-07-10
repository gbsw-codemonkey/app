//
//  CreateCompleteView.swift
//  CreativeLens
//
//  Created by Boseok Son on 7/11/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct CreateCompleteView: View {
    var body: some View {
        VStack {
            
            // AnimatedImage: ClappingHands
            AnimatedImage(url: URL(string: "https://raw.githubusercontent.com/Tarikul-Islam-Anik/Animated-Fluent-Emojis/master/Emojis/Hand%20gestures/Clapping%20Hands.png"))
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 186)
                .padding(.bottom, 10)
            
            Text("영상이 잘 만들어졌어요!")
                .font(.system(size: 20, weight: .bold))
                .foregroundStyle(Color(red: 92 / 255, green: 138 / 255, blue: 255 / 255))
                .padding(.bottom, 200)
            
            NavigationLink {
                ProfileView()
                    .navigationBarBackButtonHidden()
            } label: {
                Text("고마워요!")
                    .foregroundStyle(Color.white)
                    .fontWeight(Font.Weight.semibold)
                    .frame(width: 250)
                    .padding(20)
                    .background(Color(red: 92 / 255, green: 138 / 255, blue: 255 / 255))
                    .clipShape(RoundedRectangle(cornerRadius: 20))
            }
                
        }
        .padding(.top, 180)
    }
}

#Preview {
    CreateCompleteView()
}
