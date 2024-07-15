import SwiftUI
import Alamofire
import SDWebImageSwiftUI

struct LoginResponse: Decodable {
    let status: Bool
    let token: String?
}

struct LoginView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var isLoginComplete: Bool = false
    @State private var showAlert = false
    @State private var alertMessage = ""
    @AppStorage("TOKEN") private var token: String = ""
    
    var body: some View {
        VStack(spacing: 50) {
            VStack {
                
                // AnimatedImage: SmilingFace
                AnimatedImage(url: URL(string: password != "" ? "https://raw.githubusercontent.com/Tarikul-Islam-Anik/Animated-Fluent-Emojis/master/Emojis/Smilies/Face%20with%20Peeking%20Eye.png" : "https://raw.githubusercontent.com/Tarikul-Islam-Anik/Animated-Fluent-Emojis/master/Emojis/Smilies/Smiling%20Face%20with%20Sunglasses.png"))
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 107)
                    .padding(.bottom, 50)
                
                // TextField: username
                ZStack {
                    Image("UserSolid")
                        .renderingMode(.template)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 23)
                        .foregroundStyle(Color(red: 131 / 255, green: 131 / 255, blue: 131 / 255))
                        .padding(.trailing, 240)
                        .zIndex(1)
                    
                    TextField(
                        "example",
                        text: $username
                    )
                    .frame(width: 250)
                    .padding(EdgeInsets(top: 20, leading: 50, bottom: 20, trailing: -10))
                    .background(Color(red: 241 / 255, green: 241 / 255, blue: 241 / 255))
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    
                }
                .padding(.bottom, 10)
                
                // SecureField: password
                ZStack {
                    Image("LockSolid")
                        .renderingMode(.template)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 23)
                        .foregroundStyle(Color(red: 131 / 255, green: 131 / 255, blue: 131 / 255))
                        .padding(.trailing, 240)
                        .zIndex(1)
                    
                    SecureField(
                        "*******",
                        text: $password
                    )
                    .frame(width: 250)
                    .padding(EdgeInsets(top: 20, leading: 50, bottom: 20, trailing: -10))
                    .background(Color(red: 241 / 255, green: 241 / 255, blue: 241 / 255))
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                }
                
            }
            .padding(.bottom, 140)
            
            // Button: Login
            Button(action: {
                login()
            }) {
                Text("로그인")
                    .foregroundStyle(Color.white)
                    .fontWeight(Font.Weight.semibold)
                    .frame(width: 250)
                    .padding(20)
                    .background(Color(red: 92 / 255, green: 138 / 255, blue: 255 / 255))
                    .clipShape(RoundedRectangle(cornerRadius: 20))
            }
            
            NavigationLink("계정이 없어요..", destination: SignupView())
                .frame(width: 250)
                .font(.system(size: 16))
                .padding(.top, -20)
                .toolbar(.hidden)
        }
        .padding(.top, 100)
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Login Failed"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
        .navigationDestination(isPresented: $isLoginComplete) {
            MainView()
                .navigationBarBackButtonHidden()
        }
    }
    
    private func login() {
        guard let url = URL(string: "http://localhost:3000/api/auth/login") else { return }
        
        let parameters: [String: Any] = [
            "id": username,
            "password": password
        ]
        
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseDecodable(of: LoginResponse.self) { response in
            switch response.result {
            case .success(let loginResponse):
                if loginResponse.status, let token = loginResponse.token {
                    
                    self.token = token
                    isLoginComplete = true
                    
                } else {
                    self.alertMessage = "Invalid username or password"
                    self.showAlert = true
                }
            case .failure:
                self.alertMessage = "Failed to connect to server"
                self.showAlert = true
            }
        }
    }
}

#Preview {
    LoginView()
}
