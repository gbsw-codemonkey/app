//
//  ProfileView.swift
//  CreativeLens
//
//  Created by Boseok Son on 7/11/24.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        VStack {
            
        }
        .toolbarBackgroundVisibility(.visible, for: .navigationBar)
        .navigationBarTitle(Text(""), displayMode: .inline)
        .navigationBarItems(
            leading:
                VStack {
                    Image("LogoBlue")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 39)
                        .padding(EdgeInsets(top: -20, leading: 10, bottom: 0, trailing: 0))
                    
                    Spacer()
                        .frame(height: 3)
                },
            
            trailing:
                VStack {
                    Image("Profile")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 44)
                        .clipShape(Circle())
                        .padding(EdgeInsets(top: -20, leading: 0, bottom: 0, trailing: 10))
                    
                    Spacer()
                        .frame(height: 3)
                }
        )
    }
}

#Preview {
    ProfileView()
}
