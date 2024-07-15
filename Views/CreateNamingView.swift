import SwiftUI
import SDWebImageSwiftUI
import Alamofire

struct CreateNamingView: View {
    
    var videoURL: String
    @State private var videoName: String = ""
    @State private var isComplete: Bool = false
    
    @AppStorage("TOKEN") private var token: String = ""
    
    var body: some View {
        VStack {
            Spacer()
            
            // AnimatedImage: WritingHand
            AnimatedImage(url: URL(string: "https://raw.githubusercontent.com/Tarikul-Islam-Anik/Animated-Fluent-Emojis/master/Emojis/Hand%20gestures/Writing%20Hand.png"))
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 156)
                .padding(.bottom, 10)
            
            Text("영상의 이름은 어떻게 지을까요?")
                .font(.system(size: 20, weight: .bold))
                .foregroundStyle(Color(red: 92 / 255, green: 138 / 255, blue: 255 / 255))
                .padding(.bottom, 20)
            
            TextField("영상 이름", text: $videoName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(width: 300)
                .padding(.bottom, 20)
            
            Button(action: {
                postVideoURL()
            }) {
                Text("다했어요")
                    .foregroundStyle(Color.white)
                    .fontWeight(Font.Weight.semibold)
                    .frame(width: 250)
                    .padding(20)
                    .background(Color(red: 92 / 255, green: 138 / 255, blue: 255 / 255))
                    .clipShape(RoundedRectangle(cornerRadius: 20))
            }
            
            Spacer()
        }
        .padding(.top, 100)
        .navigationDestination(isPresented: $isComplete) {
            CreateCompleteView()
                .toolbar(.hidden)
        }
    }
    
    func postVideoURL() {
        let parameters: [String: String] = [
            "video_url": videoURL,
            "video_name": videoName
        ]
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)"
        ]
        
        AF.request("http://localhost:3000/api/video", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .responseDecodable(of: NewVideoResponse.self) { response in
                switch response.result {
                case .success(let videoPostResponse):
                    print("Status: \(videoPostResponse.status)")
                    print("Message: \(videoPostResponse.msg)")
                    print("Video ID: \(videoPostResponse.video_id)")
                    isComplete = true
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                }
            }
    }
}

struct NewVideoResponse: Decodable {
    let status: Bool
    let msg: String
    let video_id: Int
}

#Preview {
    CreateNamingView(videoURL: "https://example.com/video.mp4")
}
