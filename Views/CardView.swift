//
//  CardView.swift
//  CreativeLens
//
//  Created by Boseok Son on 7/11/24.
//

import SwiftUI
import AVKit
import SDWebImageSwiftUI

struct CardView: View {
    var body: some View {
        VStack(alignment: .leading) {
            VideoPlayer(player: AVPlayer(url: URL(string: "https://creativelens-bucket.s3.ap-northeast-2.amazonaws.com/converted_video.mp4")!))
                .frame(width: 340, height: 230)
                .clipShape(RoundedRectangle(cornerRadius: 20))
            
            Text("고양이 코딩하는 영상")
                .font(.system(size: 24, weight: .bold))
            
            HStack {
                HStack {
                    Image("Profile")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 28, height: 28)
                        .clipShape(Circle())
                    
                    Text("dya_only")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundStyle(Color(red: 56 / 255, green: 126 / 255, blue: 231 / 255))
                }
                
                Spacer()
                    .frame(width: 186)
                
                Text("27")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(Color(red: 255 / 255, green: 88 / 255, blue: 88 / 255))
                
                Image("HeartRegular")
                    .renderingMode(.template)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 23)
                    .foregroundStyle(Color(red: 255 / 255, green: 88 / 255, blue: 88 / 255))
            }
        }
        .padding(.bottom, 60)
    }
}

#Preview {
    CardView()
}
