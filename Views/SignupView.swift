import SwiftUI
import SDWebImageSwiftUI

struct SignupView: View {
    @State private var username: String = ""
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var rePassword: String = ""
    
    @State private var isSignupComplete: Bool = false
    
    var body: some View {
        VStack(spacing: 50) {
            VStack {
                
                // AnimatedImage: Partying Face
                AnimatedImage(url: URL(string: "https://raw.githubusercontent.com/Tarikul-Islam-Anik/Animated-Fluent-Emojis/master/Emojis/Smilies/Partying%20Face.png"))
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
    }
    
    private func Signup() {
        // Business Logic
        
        isSignupComplete = true
    }
}

#Preview {
    SignupView()
}
