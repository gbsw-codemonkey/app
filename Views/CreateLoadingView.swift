//
//  CreateLoadingView.swift
//  CreativeLens
//
//  Created by Boseok Son on 7/11/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct CreateLoadingView: View {
    
    @State private var isComplete: Bool = false
    @State private var progress = 0.0
    let timer = Timer.publish(every: 0.005, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            // AnimatedImage: SmilingFace
            AnimatedImage(url: URL(string: "https://raw.githubusercontent.com/Tarikul-Islam-Anik/Animated-Fluent-Emojis/master/Emojis/Smilies/Yawning%20Face.png"))
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 156)
                .padding(.bottom, 10)
            
            Text("영상이 만들어지고 있어요..")
                .font(.system(size: 20, weight: .bold))
                .foregroundStyle(Color(red: 92 / 255, green: 138 / 255, blue: 255 / 255))
        }
        .onReceive(timer) { _ in
            if progress < 1 {
                progress += 0.001
                return
            }
            
            progress = 1
            isComplete = true
        }
        .navigationDestination(isPresented: $isComplete) {
            CreateCompleteView()
                .toolbar(.hidden)
        }
        .onAppear() {
            
            // Business Logic
        }
    }
}

#Preview {
    CreateLoadingView()
}
