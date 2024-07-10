//
//  MainView.swift
//  CreativeLens
//
//  Created by Boseok Son on 7/10/24.
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

struct HomeView: View {
    var body: some View {
        ZStack {
            Color(red: 250 / 255, green: 250 / 255, blue: 250 / 255)
            
            VStack {
                ScrollView(showsIndicators: false) {
                    Spacer()
                        .frame(height: 150)
                    
                    CardView()
                    CardView()
                    CardView()
                    CardView()
                    CardView()
                    CardView()
                }
                
                Spacer()
            }
        }
        .ignoresSafeArea()
        .toolbarBackgroundVisibility(.visible, for: .navigationBar)
        .navigationBarTitle(Text(""), displayMode: .inline)
        .navigationBarItems(
            leading:
                VStack {
                    Image("LogoBlue")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 39)
                        .padding(EdgeInsets(top: -20, leading: 10, bottom: 0, trailing: 0))
                    
                    Spacer()
                        .frame(height: 3)
                },
            
            trailing:
                VStack {
                    Image("Profile")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 44)
                        .clipShape(Circle())
                        .padding(EdgeInsets(top: -20, leading: 0, bottom: 0, trailing: 10))
                    
                    Spacer()
                        .frame(height: 3)
                }
        )
    }
}

struct MainView: View {
    @State private var selectedIndex = 0
    
    var body: some View {
        VStack {
            ZStack {
                switch selectedIndex {
                case 0:
                    HomeView()
                case 1:
                    CreateView()
                default:
                    Text("A")
                }
            }
            Spacer()
            HStack {
                Spacer()
                
                //VStack: Home
                VStack {
                    Image("HouseSolid")
                        .renderingMode(.template)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 27)
                        .foregroundColor(selectedIndex == 0 ? Color(red: 92 / 255, green: 138 / 255, blue: 255 / 255) : Color(.tertiaryLabel))
                        .padding(.bottom, -10)
                }
                .gesture(
                    TapGesture()
                        .onEnded { _ in
                            selectedIndex = 0
                        }
                )
                
                Spacer()
                
                //VStack: Create
                VStack {
                    Image("SquarePlusRegular")
                        .renderingMode(.template)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 30)
                        .foregroundColor(selectedIndex == 1 ? Color(red: 92 / 255, green: 138 / 255, blue: 255 / 255) : Color(.tertiaryLabel))
                        .padding(.bottom, -10)
                }
                .gesture(
                    TapGesture()
                        .onEnded { _ in
                            selectedIndex = 1
                        }
                )
                
                Spacer()
                
                //VStack: Search
                VStack {
                    Image("SearchSolid")
                        .renderingMode(.template)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 25)
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(selectedIndex == 2 ? Color(red: 92 / 255, green: 138 / 255, blue: 255 / 255) : Color(.tertiaryLabel))
                        .padding(.bottom, -10)
                }
                .gesture(
                    TapGesture()
                        .onEnded { _ in
                            selectedIndex = 2
                        }
                )
                
                Spacer()
                
                //VStack: Setting
                VStack {
                    Image("GearSolid")
                        .renderingMode(.template)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 28)
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(selectedIndex == 3 ? Color(red: 92 / 255, green: 138 / 255, blue: 255 / 255) : Color(.tertiaryLabel))
                        .padding(.bottom, -10)
                }
                .gesture(
                    TapGesture()
                        .onEnded { _ in
                            selectedIndex = 3
                        }
                )
                
                Spacer()
            }
        }
    }
}

#Preview {
    MainView()
}
