//
//  SignupCompleteView.swift
//  CreativeLens
//
//  Created by Boseok Son on 7/10/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct SignupCompleteView: View {
    @State private var isOk = false
    
    var body: some View {
        VStack(spacing: 50) {
            VStack {
                // AnimatedImage: Partying Face
                AnimatedImage(url: URL(string: "https://raw.githubusercontent.com/Tarikul-Islam-Anik/Animated-Fluent-Emojis/master/Emojis/Smilies/Partying%20Face.png"))
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 186)
                    .padding(.bottom, 10)
                
                // Text: congratulations
                Text("축하합니다.")
                    .font(.system(size: 32))
                    .fontWeight(Font.Weight.heavy)
                    .foregroundStyle(Color(red: 92 / 255, green: 138 / 255, blue: 255 / 255))
                Text("회원가입에 성공하셨어요!")
                    .font(.system(size: 24))
                    .fontWeight(Font.Weight.semibold)
                    .foregroundStyle(Color(red: 148 / 255, green: 148 / 255, blue: 148 / 255))
            }
            .padding(.bottom, 140)
            
            // Button: OK
            Button(action: { isOk = true }) {
                Text("알겠어요")
                    .foregroundStyle(Color.white)
                    .fontWeight(Font.Weight.semibold)
                    .frame(width: 250)
                    .padding(20)
                    .background(Color(red: 92 / 255, green: 138 / 255, blue: 255 / 255))
                    .clipShape(RoundedRectangle(cornerRadius: 20))
            }
        }
        .padding(.top, 100)
        .navigationDestination(isPresented: $isOk) {
            LoginView()
                .toolbar(.hidden)
        }
    }
}

#Preview {
    SignupCompleteView()
}
