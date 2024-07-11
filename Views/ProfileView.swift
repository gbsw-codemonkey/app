import SwiftUI

struct ProfileView: View {
    
    @State private var name: String = "손보석"
    @State private var username: String = "dya_only"
    @State private var email: String = "dyacode@proton.me"
    
    @State private var tab: Int = 0
    
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
                            Image("Profile")
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
                            Button(action: { tab = 0 }) {
                                Text("내가 만든 영상")
                                    .font(.system(size: 20, weight: .bold))
                                    .foregroundStyle(tab == 0 ? Color.black : Color(red: 170 / 255, green: 170 / 255, blue: 170 / 255))
                            }
                            .padding(.trailing, 10)
                            
                            Button(action: { tab = 1 }) {
                                Text("좋아요 누른 영상")
                                    .font(.system(size: 20, weight: .bold))
                                    .foregroundStyle(tab == 1 ? Color.black : Color(red: 170 / 255, green: 170 / 255, blue: 170 / 255))
                            }
                            
                            Spacer()
                                .frame(width: 60)
                        }
                        .padding(.bottom, 20)
                        
                        if tab == 0 {
                            CardView()
                            CardView()
                            CardView()
                        } else {
                            Text("a")
                        }
                        
                        Spacer()
                    }
                }
                .padding(.top, -10)
                .scrollIndicators(.hidden)
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    ProfileView()
}
