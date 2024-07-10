//
//  StartView.swift
//  CreativeLens
//
//  Created by Boseok Son on 7/10/24.
//

import SwiftUI

struct StartView: View {
    var body: some View {
        VStack(spacing: 50) {
            VStack {
                Image("LogoBlue")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 180)
                    .padding(.bottom, 20)
                
                Text("AI Video Sharing")
                    .font(.system(size: 30, weight: .light))
                    .foregroundStyle(Color(red: 135 / 255, green: 154 / 255, blue: 255 / 255))
                    .padding(.bottom, -20)
                
                Text("CreativeLens")
                    .font(.system(size: 35, weight: .light))
                    .fontWeight(Font.Weight.semibold)
                    .foregroundStyle(Color(red: 79 / 255, green: 113 / 255, blue: 234 / 255))
            }
            .padding(.bottom, 100)
            
            NavigationLink {
                LoginView()
            } label: {
                Text("시작하기")
                    .foregroundStyle(Color.white)
                    .fontWeight(Font.Weight.semibold)
                    .frame(width: 250)
                    .padding(20)
                    .background(Color(red: 92 / 255, green: 138 / 255, blue: 255 / 255))
                    .clipShape(RoundedRectangle(cornerRadius: 20))
            }
                
        }
        .padding(.top, 200)
    }
}

#Preview {
    StartView()
}
