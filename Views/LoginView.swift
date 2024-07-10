import SwiftUI
import SDWebImageSwiftUI

struct LoginView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var isFocusPW: Bool = false
    @State private var isLoginComplete: Bool = false
    
    var body: some View {
        VStack(spacing: 50) {
            VStack {
                
                // AnimatedImage: SmilingFace
                AnimatedImage(url: URL(string: isFocusPW ? "https://raw.githubusercontent.com/Tarikul-Islam-Anik/Animated-Fluent-Emojis/master/Emojis/Smilies/Face%20with%20Peeking%20Eye.png" : "https://raw.githubusercontent.com/Tarikul-Islam-Anik/Animated-Fluent-Emojis/master/Emojis/Smilies/Smiling%20Face%20with%20Sunglasses.png"))
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
                        text: $password,
                        onCommit: {
                            isFocusPW = false
                        }
                    )
                    .frame(width: 250)
                    .padding(EdgeInsets(top: 20, leading: 50, bottom: 20, trailing: -10))
                    .background(Color(red: 241 / 255, green: 241 / 255, blue: 241 / 255))
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .onChange(of: password) { _, _ in
                        isFocusPW = true
                    }
                }
                
            }
            .padding(.bottom, 140)
            
            // Button: Login
            Button(action: {
                Login()
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
        .navigationDestination(isPresented: $isLoginComplete) {
            MainView()
                .navigationBarBackButtonHidden()
        }
    }
    
    private func Login() {
        
        // Business Logic
        
        isLoginComplete = true
    }
}

#Preview {
    LoginView()
}
