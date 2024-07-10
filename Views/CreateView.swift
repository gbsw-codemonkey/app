//
//  CreateView.swift
//  CreativeLens
//
//  Created by Boseok Son on 7/11/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct CreateView: View {
    
    init() {
        UITextView.appearance().backgroundColor = .clear
    }
    
    @State private var prompt: String = ""
    
    var body: some View {
        VStack {
            
            Spacer()
            
            // AnimatedImage: FaceWithMonocle
            AnimatedImage(url: URL(string: "https://raw.githubusercontent.com/Tarikul-Islam-Anik/Animated-Fluent-Emojis/master/Emojis/Smilies/Face%20with%20Monocle.png"))
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 107)
                .padding(.bottom, 50)
            
            Text("Prompt")
                .font(.system(size: 16, weight: .semibold))
                .foregroundStyle(Color(red: 92 / 255, green: 138 / 255, blue: 255 / 255))
                .padding(.trailing, 230)
            TextEditor(text: $prompt)
                .frame(width: 290, height: 200)
                .scrollContentBackground(.hidden)
                .background(Color(red: 241 / 255, green: 241 / 255, blue: 241 / 255))
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .padding(.bottom, 20)
            
            NavigationLink {
                CreateLoadingView()
                    .toolbar(.hidden)
            } label: {
                Text("만들기")
                    .foregroundStyle(Color.white)
                    .fontWeight(Font.Weight.semibold)
                    .frame(width: 250)
                    .padding(20)
                    .background(Color(red: 92 / 255, green: 138 / 255, blue: 255 / 255))
                    .clipShape(RoundedRectangle(cornerRadius: 20))
            }
            
            Spacer()
        }
    }
}

#Preview {
    CreateView()
}
