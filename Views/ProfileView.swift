import SwiftUI
import SDWebImageSwiftUI
import Alamofire

struct ProfileView: View {
    
    @State private var name: String = ""
    @State private var username: String = ""
    @State private var email: String = ""
    
    @State private var tab: Int = 0
    @State private var videos: [Video] = []
    @State private var hasVideos: Bool = true
    @State private var likedVideos: [Video] = []
    
    @AppStorage("TOKEN") private var token: String = ""
    
    var body: some View {
        ZStack {
            Color(red: 250 / 255, green: 250 / 255, blue: 250 / 255)
            
            VStack {
                TopNavView()
                
                ScrollView {
                    VStack {
                        
                        Spacer()
                            .frame(height: 70)
                        
                        // HStack: User Profile
                        HStack(alignment: .center) {
                            AnimatedImage(url: URL(string: "https://raw.githubusercontent.com/Tarikul-Islam-Anik/Animated-Fluent-Emojis/master/Emojis/Smilies/Smiling%20Face%20with%20Smiling%20Eyes.png"))
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 136)
                                .clipShape(Circle())
                            
                            Spacer()
                                .frame(width: 20)
                            
                            VStack(alignment: .leading) {
                                HStack {
                                    Text(name)
                                        .font(.system(size: 26, weight: .bold))
                                        .foregroundStyle(Color(red: 92 / 255, green: 138 / 255, blue: 255 / 255))
                                        .padding(.trailing, -8)
                                    Text("님")
                                        .font(.system(size: 26, weight: .bold))
                                }
                                
                                Text(username)
                                    .font(.system(size: 16, weight: .regular))
                                    .foregroundStyle(Color(red: 112 / 255, green: 112 / 255, blue: 112 / 255))
                                
                                Text(email)
                                    .font(.system(size: 16, weight: .regular))
                                    .foregroundStyle(Color(red: 112 / 255, green: 112 / 255, blue: 112 / 255))
                            }
                        }
                        
                        Spacer()
                            .frame(height: 100)
                        
                        HStack {
                            Button(action: {
                                tab = 0
                                fetchVideos()
                            }) {
                                Text("내가 만든 영상")
                                    .font(.system(size: 20, weight: .bold))
                                    .foregroundStyle(tab == 0 ? Color.black : Color(red: 170 / 255, green: 170 / 255, blue: 170 / 255))
                            }
                            .padding(.trailing, 10)
                            
                            Button(action: {
                                tab = 1
                                fetchLikedVideos()
                            }) {
                                Text("좋아요 누른 영상")
                                    .font(.system(size: 20, weight: .bold))
                                    .foregroundStyle(tab == 1 ? Color.black : Color(red: 170 / 255, green: 170 / 255, blue: 170 / 255))
                            }
                            
                            Spacer()
                                .frame(width: 60)
                        }
                        .padding(.bottom, 20)
                        
                        if tab == 0 {
                            if hasVideos {
                                ForEach(videos, id: \.id) { video in
                                    CardView(id: video.id, userIdx: video.user_idx, videoURL: video.video_url, videoName: video.video_name, likeCount: video.like_count)
                                }
                            } else {
                                Text("아직 만든 영상이 없네요 ;-;")
                                    .font(.system(size: 20, weight: .bold))
                                    .foregroundStyle(Color.gray)
                            }
                        } else if tab == 1 {
                            if likedVideos.isEmpty {
                                Text("좋아요 누른 영상이 없습니다 ;-;")
                                    .font(.system(size: 20, weight: .bold))
                                    .foregroundStyle(Color.gray)
                            } else {
                                ForEach(likedVideos, id: \.id) { video in
                                    CardView(id: video.id, userIdx: video.user_idx, videoURL: video.video_url, videoName: video.video_name, likeCount: video.like_count)
                                }
                            }
                        }
                        
                        Spacer()
                    }
                }
                .padding(.top, -10)
                .scrollIndicators(.hidden)
                .onAppear() {
                    fetchUserInfo()
                    fetchVideos()
                }
            }
        }
        .ignoresSafeArea()
    }
    
    func fetchUserInfo() {
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)"
        ]
        
        AF.request("http://localhost:3000/api/user/@me", method: .get, headers: headers)
            .responseDecodable(of: UserProfileResponse.self) { response in
                switch response.result {
                case .success(let userResponse):
                    if userResponse.status {
                        self.name = userResponse.user.name
                        self.username = userResponse.user.id
                        self.email = userResponse.user.email
                    } else {
                        print("Failed to fetch user info")
                    }
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                }
            }
    }
    
    func fetchVideos() {
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)"
        ]
        
        AF.request("http://localhost:3000/api/video", method: .get, headers: headers)
            .responseDecodable(of: VideoGetResponse.self) { response in
                switch response.result {
                case .success(let videoResponse):
                    if videoResponse.status {
                        self.videos = videoResponse.videos
                        self.hasVideos = !videoResponse.videos.isEmpty
                    } else {
                        self.hasVideos = false
                    }
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                    self.hasVideos = false
                }
            }
    }
    
    func fetchLikedVideos() {
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)"
        ]
        
        AF.request("http://localhost:3000/api/like", method: .get, headers: headers)
            .responseDecodable(of: LikedVideosResponse.self) { response in
                switch response.result {
                case .success(let likedVideosResponse):
                    if likedVideosResponse.status {
                        self.likedVideos = []
                        for video in likedVideosResponse.videos {
                            fetchVideoDetails(videoId: video.video_id)
                        }
                    } else {
                        print("Failed to fetch liked videos")
                    }
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                }
            }
    }
    
    func fetchVideoDetails(videoId: Int) {
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)"
        ]
        
        AF.request("http://localhost:3000/api/video/id/\(videoId)", method: .get, headers: headers)
            .responseDecodable(of: VideoDetailResponse.self) { response in
                switch response.result {
                case .success(let videoDetailResponse):
                    if videoDetailResponse.status {
                        self.likedVideos.append(videoDetailResponse.video)
                    } else {
                        print("Failed to fetch video details")
                    }
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                }
            }
    }
}

struct UserProfile: Decodable {
    let idx: Int
    let id: String
    let name: String
    let email: String
}

struct UserProfileResponse: Decodable {
    let status: Bool
    let user: UserProfile
}

struct Video: Decodable {
    let id: Int
    let user_idx: Int
    let video_url: String
    let video_name: String
    let like_count: Int
}

struct VideoGetResponse: Decodable {
    let status: Bool
    let videos: [Video]
}

struct LikedVideo: Decodable {
    let video_id: Int
}

struct LikedVideosResponse: Decodable {
    let status: Bool
    let videos: [LikedVideo]
}

struct VideoDetailResponse: Decodable {
    let status: Bool
    let video: Video
}

#Preview {
    ProfileView()
}
