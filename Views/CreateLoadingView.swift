import SwiftUI
import SDWebImageSwiftUI
import Alamofire

struct CreateLoadingView: View {
    
    @Binding var prompt: String
    @State private var videoURL: String?
    @State private var navigateToNaming: Bool = false
    
    @AppStorage("TOKEN") private var token: String = ""
    
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
        .navigationDestination(isPresented: $navigateToNaming) {
            if let videoURL = videoURL {
                CreateNamingView(videoURL: videoURL)
                    .toolbar(.hidden)
            }
        }
        .onAppear() {
            createVideo()
        }
    }
    
    func createVideo() {
        let parameters: [String: String] = [
            "prompt": prompt
        ]
        
        AF.request("https://3650-34-34-69-107.ngrok-free.app/generate-video", method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .responseDecodable(of: VideoResponse.self) { response in
                switch response.result {
                case .success(let videoResponse):
                    print("Video URL: \(videoResponse.video_url)")
                    self.videoURL = videoResponse.video_url
                    self.navigateToNaming = true
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                }
            }
    }
}

struct VideoResponse: Decodable {
    let video_url: String
}

#Preview {
    CreateLoadingView(prompt: .constant(""))
}
