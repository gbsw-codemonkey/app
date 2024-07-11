//
//  MainView.swift
//  CreativeLens
//
//  Created by Boseok Son on 7/10/24.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        ZStack {
            Color(red: 250 / 255, green: 250 / 255, blue: 250 / 255)
            
            VStack {
                TopNavView()
                
                ScrollView(showsIndicators: false) {
                    Spacer()
                        .frame(height: 40)
                    
                    CardView()
                    CardView()
                    CardView()
                    CardView()
                    CardView()
                    CardView()
                }
                
                Spacer()
            }
        }
        .ignoresSafeArea()
    }
}

struct MainView: View {
    @State private var selectedIndex = 0
    
    var body: some View {
        VStack {
            ZStack {
                switch selectedIndex {
                case 0:
                    HomeView()
                case 1:
                    CreateView()
                default:
                    Text("A")
                }
            }
            Spacer()
            HStack {
                Spacer()
                
                //VStack: Home
                VStack {
                    Image("HouseSolid")
                        .renderingMode(.template)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 27)
                        .foregroundColor(selectedIndex == 0 ? Color(red: 92 / 255, green: 138 / 255, blue: 255 / 255) : Color(.tertiaryLabel))
                        .padding(.bottom, -10)
                }
                .gesture(
                    TapGesture()
                        .onEnded { _ in
                            selectedIndex = 0
                        }
                )
                
                Spacer()
                
                //VStack: Create
                VStack {
                    Image("SquarePlusRegular")
                        .renderingMode(.template)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 30)
                        .foregroundColor(selectedIndex == 1 ? Color(red: 92 / 255, green: 138 / 255, blue: 255 / 255) : Color(.tertiaryLabel))
                        .padding(.bottom, -10)
                }
                .gesture(
                    TapGesture()
                        .onEnded { _ in
                            selectedIndex = 1
                        }
                )
                
                Spacer()
                
                //VStack: Search
                VStack {
                    Image("SearchSolid")
                        .renderingMode(.template)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 25)
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(selectedIndex == 2 ? Color(red: 92 / 255, green: 138 / 255, blue: 255 / 255) : Color(.tertiaryLabel))
                        .padding(.bottom, -10)
                }
                .gesture(
                    TapGesture()
                        .onEnded { _ in
                            selectedIndex = 2
                        }
                )
                
                Spacer()
                
                //VStack: Setting
                VStack {
                    Image("GearSolid")
                        .renderingMode(.template)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 28)
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(selectedIndex == 3 ? Color(red: 92 / 255, green: 138 / 255, blue: 255 / 255) : Color(.tertiaryLabel))
                        .padding(.bottom, -10)
                }
                .gesture(
                    TapGesture()
                        .onEnded { _ in
                            selectedIndex = 3
                        }
                )
                
                Spacer()
            }
        }
    }
}

#Preview {
    MainView()
}
