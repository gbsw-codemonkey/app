//
//  MainView.swift
//  CreativeLens
//
//  Created by Boseok Son on 7/10/24.
//

import SwiftUI
import Alamofire

struct VideoMain: Decodable {
    let id: Int
    let user_idx: Int
    let video_url: String
    let video_name: String
    let like_count: Int
}

struct VideoMainResponse: Decodable {
    let videos: [VideoMain]
}

struct HomeView: View {
    @State private var videos: [VideoMain] = []
    
    var body: some View {
        ZStack {
            Color(red: 250 / 255, green: 250 / 255, blue: 250 / 255)
            
            VStack {
                TopNavView()
                
                ScrollView(showsIndicators: false) {
                    Spacer()
                        .frame(height: 40)
                    
                    // Card views
                    if videos.isEmpty {
                        Text("Loading...")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.gray)
                    } else {
                        ForEach(videos, id: \.id) { video in
                            CardView(id: video.id, userIdx: video.user_idx, videoURL: video.video_url, videoName: video.video_name, likeCount: video.like_count)
                        }
                    }
                }
                
                Spacer()
            }
        }
        .ignoresSafeArea()
        .onAppear {
            fetchVideos()
        }
    }
    
    func fetchVideos() {
        AF.request("http://localhost:3000/api/video/all", method: .get)
            .responseDecodable(of: VideoMainResponse.self) { response in
                switch response.result {
                case .success(let videoResponse):
                    self.videos = videoResponse.videos
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                }
            }
    }
}

struct SettingView: View {
    @AppStorage("TOKEN") private var token: String = ""
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        VStack {
            Spacer()
            
            Button(action: logout) {
                Text("로그아웃")
                    .foregroundColor(.white)
                    .fontWeight(.semibold)
                    .frame(width: 250)
                    .padding(20)
                    .background(Color(red: 92 / 255, green: 138 / 255, blue: 255 / 255))
                    .clipShape(RoundedRectangle(cornerRadius: 20))
            }
            
            Spacer()
        }
        .navigationBarTitle("설정", displayMode: .inline)
    }
    
    func logout() {
        token = ""
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            if let window = windowScene.windows.first {
                window.rootViewController = UIHostingController(rootView: SplashView())
                window.makeKeyAndVisible()
            }
        }
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
                case 3:
                    SettingView()
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
