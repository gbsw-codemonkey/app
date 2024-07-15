import SwiftUI
import AVKit
import SDWebImageSwiftUI
import Alamofire

struct CardView: View {
    var id: Int
    var userIdx: Int
    var videoURL: String
    var videoName: String
    var likeCount: Int
    
    @State private var userId: String = ""
    @State private var currentLikeCount: Int = 0
    @State private var isLiked: Bool = false
    @AppStorage("TOKEN") private var token: String = ""
    
    var body: some View {
        VStack(alignment: .center) {
            VStack(alignment: .leading) {
                VideoPlayer(player: AVPlayer(url: URL(string: videoURL)!))
                    .frame(width: 340, height: 230)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Text("\(videoName)")
                    .font(.system(size: 24, weight: .bold))
            }
            
            HStack {
                Spacer()
                    .frame(width: 30)
                
                HStack {
                    AnimatedImage(url: URL(string: "https://raw.githubusercontent.com/Tarikul-Islam-Anik/Animated-Fluent-Emojis/master/Emojis/Smilies/Smiling%20Face%20with%20Smiling%20Eyes.png"))
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 28, height: 28)
                        .clipShape(Circle())
                    
                    Text(userId.isEmpty ? "Loading..." : userId)
                        .font(.system(size: 16, weight: .medium))
                        .foregroundStyle(Color(red: 56 / 255, green: 126 / 255, blue: 231 / 255))
                }
                
                Spacer()
                
                Text("\(currentLikeCount)")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(Color(red: 255 / 255, green: 88 / 255, blue: 88 / 255))
                
                Image(isLiked ? "HeartFull" : "HeartRegular")
                    .renderingMode(.template)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 23)
                    .foregroundStyle(Color(red: 255 / 255, green: 88 / 255, blue: 88 / 255))
                    .onTapGesture {
                        toggleLike()
                    }
                
                Spacer()
                    .frame(width: 30)
            }
        }
        .padding(.bottom, 60)
        .onAppear {
            fetchUserInfo()
            self.currentLikeCount = likeCount
            checkIfLiked()
        }
    }
    
    func fetchUserInfo() {
        AF.request("http://localhost:3000/api/user/\(userIdx)")
            .responseDecodable(of: UserResponse.self) { response in
                switch response.result {
                case .success(let userResponse):
                    if userResponse.status {
                        self.userId = userResponse.user.id
                    } else {
                        print("Failed to fetch user info")
                    }
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                }
            }
    }
    
    func checkIfLiked() {
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)"
        ]
        
        AF.request("http://localhost:3000/api/like", method: .get, headers: headers)
            .responseDecodable(of: LikedVideosCardResponse.self) { response in
                switch response.result {
                case .success(let likedVideosResponse):
                    if likedVideosResponse.status {
                        self.isLiked = likedVideosResponse.videos.contains { $0.video_id == self.id }
                    } else {
                        print("Failed to fetch liked videos")
                    }
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                }
            }
    }
    
    func toggleLike() {
        if isLiked {
            unlikeVideo()
        } else {
            likeVideo()
        }
    }
    
    func likeVideo() {
        self.currentLikeCount += 1
        self.isLiked = true
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)"
        ]
        
        AF.request("http://localhost:3000/api/video/like/\(id)", method: .get, headers: headers)
            .responseDecodable(of: VideoCardResponse.self) { response in
                switch response.result {
                case .success(let videoResponse):
                    if videoResponse.status {
                        
                    } else {
                        print("Failed to like video")
                    }
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                }
            }
    }
    
    func unlikeVideo() {
        self.currentLikeCount -= 1
        self.isLiked = false
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)"
        ]
        
        AF.request("http://localhost:3000/api/video/like/\(id)", method: .delete, headers: headers)
            .responseDecodable(of: VideoCardResponse.self) { response in
                switch response.result {
                case .success(let videoResponse):
                    if videoResponse.status {
                        self.currentLikeCount -= 1
                        self.isLiked = false
                    } else {
                        print("Failed to unlike video")
                    }
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                }
            }
    }
}

struct User: Decodable {
    let idx: Int
    let id: String
    let name: String
    let email: String
}

struct UserResponse: Decodable {
    let status: Bool
    let user: User
}

struct VideoCardResponse: Decodable {
    let status: Bool
    let video: VideoCard
}

struct VideoCard: Decodable {
    let id: Int
    let user_idx: Int
    let video_url: String
    let video_name: String
    let like_count: Int
}

struct LikedVideosCardResponse: Decodable {
    let status: Bool
    let videos: [LikedVideoCard]
}

struct LikedVideoCard: Decodable {
    let user_idx: Int
    let video_id: Int
}

#Preview {
    CardView(id: 1, userIdx: 2, videoURL: "https://creativelens-bucket.s3.ap-northeast-2.amazonaws.com/converted_video.mp4", videoName: "고양이 코딩하는 영상", likeCount: 27)
}
