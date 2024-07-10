//
//  SplashView.swift
//  CreativeLens
//
//  Created by Boseok Son on 7/9/24.
//

import SwiftUI

struct SplashView: View {
    @State private var isEnd = false
    @State private var progress = 0.0
    let timer = Timer.publish(every: 0.005, on: .main, in: .common).autoconnect()
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(red: 92 / 255, green: 138 / 255, blue: 255 / 255)
                
                VStack {
                    Image("LogoWhite")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 149)
                    
                    ProgressView(value: progress)
                        .background(Color(red: 79 / 255, green: 113 / 255, blue: 234 / 255))
                        .accentColor(Color.white)
                        .frame(width: 214, height: 7)
                        .scaleEffect(x: 1, y: 2, anchor: .center)
                        .clipShape(RoundedRectangle(cornerRadius: 6))
                        .padding(.top, 20)
                }
            }
            .ignoresSafeArea()
            .onReceive(timer) { _ in
                if progress < 1 {
                    progress += 0.003
                    return
                }
                
                progress = 1
                isEnd = true
            }
            .navigationDestination(isPresented: $isEnd) {
                StartView()
                    .toolbar(.hidden)
            }
        }
    }
}

#Preview {
    SplashView()
}
