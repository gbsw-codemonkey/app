//
//  SplashView.swift
//  CreativeLens
//
//  Created by Boseok Son on 7/9/24.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        ZStack {
            Color(red: 92 / 255, green: 138 / 255, blue: 255 / 255)
            
            VStack {
                Image("LogoWhite")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 149)
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    SplashView()
}
