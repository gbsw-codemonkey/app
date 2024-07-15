import SwiftUI
import Alamofire
import SDWebImageSwiftUI

struct SignupResponse: Decodable {
    let status: Bool
    let msg: String
}

struct SignupView: View {
    @State private var username: String = ""
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isSignupComplete: Bool = false
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""

    var body: some View {
        VStack(spacing: 50) {
            VStack {
                
                // AnimatedImage: Partying Face
                AnimatedImage(url: URL(string: password != "" ? "https://raw.githubusercontent.com/Tarikul-Islam-Anik/Animated-Fluent-Emojis/master/Emojis/Smilies/Face%20with%20Peeking%20Eye.png" : "https://raw.githubusercontent.com/Tarikul-Islam-Anik/Animated-Fluent-Emojis/master/Emojis/Smilies/Partying%20Face.png"))
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 107)
                    .padding(.bottom, 50)
                
                // TextField: username(id)
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
                        "username",
                        text: $username
                    )
                    .frame(width: 250)
                    .padding(EdgeInsets(top: 20, leading: 50, bottom: 20, trailing: -10))
                    .background(Color(red: 241 / 255, green: 241 / 255, blue: 241 / 255))
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                }
                .padding(.bottom, 10)
                
                // TextField: name
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
                        "name",
                        text: $name
                    )
                    .frame(width: 250)
                    .padding(EdgeInsets(top: 20, leading: 50, bottom: 20, trailing: -10))
                    .background(Color(red: 241 / 255, green: 241 / 255, blue: 241 / 255))
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                }
                .padding(.bottom, 10)
                
                // TextField: email
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
                        "email",
                        text: $email
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
                        "password",
                        text: $password
                    )
                    .frame(width: 250)
                    .padding(EdgeInsets(top: 20, leading: 50, bottom: 20, trailing: -10))
                    .background(Color(red: 241 / 255, green: 241 / 255, blue: 241 / 255))
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                }
                
            }
            
            // Button: Signup
            Button(action: Signup) {
                Text("회원가입")
                    .foregroundStyle(Color.white)
                    .fontWeight(Font.Weight.semibold)
                    .frame(width: 250)
                    .padding(20)
                    .background(Color(red: 92 / 255, green: 138 / 255, blue: 255 / 255))
                    .clipShape(RoundedRectangle(cornerRadius: 20))
            }
            
            NavigationLink("계정이 이미 있어요!", destination: LoginView())
                .frame(width: 250)
                .font(.system(size: 16))
                .padding(.top, -20)
                .toolbar(.hidden)
        }
        .padding(.top, 100)
        .navigationDestination(isPresented: $isSignupComplete) {
            SignupCompleteView()
                .toolbar(.hidden)
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }
    
    private func Signup() {
        guard !username.isEmpty, !name.isEmpty, !email.isEmpty, !password.isEmpty else {
            alertMessage = "Please fill all fields."
            showAlert = true
            return
        }

        let parameters: [String: Any] = [
            "id": username,
            "name": name,
            "email": email,
            "password": password
        ]
        
        AF.request("http://localhost:3000/api/auth/signup", method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .responseDecodable(of: SignupResponse.self) { response in
                switch response.result {
                case .success:
                    isSignupComplete = true
                case .failure(let error):
                    alertMessage = error.localizedDescription
                    showAlert = true
                }
            }
    }
}

#Preview {
    SignupView()
}
