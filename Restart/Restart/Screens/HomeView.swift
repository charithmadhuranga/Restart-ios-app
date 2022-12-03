//
//  HomeView.swift
//  Restart
//
//  Created by charith wijesundara on 2022-11-24.
//

import SwiftUI

struct HomeView: View {
    //MARK: - PROPERTY
    
    @AppStorage("onboarding") var isOnboardingViewActive: Bool = false
    @State private var isAnimating: Bool = false
    
    //MARK: - BODY
    var body: some View {
        
        
        //:VSTACK START
        VStack {
            
            //MARK - HEADER
            Spacer()
            
            //IMAGE ZSTACK - START
            ZStack {
                CircleGroupView(ShapeColor: .gray, ShapeOpacity: 0.1)
                Image("character-2")
                    .resizable()
                    .scaledToFit()
                    .offset(y: isAnimating ? 35:-35)
                    .animation(Animation
                        .easeInOut(duration:4 )
                        .repeatForever(), value: isAnimating)
                .padding()

            }//IMAGE ZSTACK - END
            
            //MARK - CENTER
            Spacer()
            Text("The time that leads to mastery is depend on our forcus")
                .font(.title3)
                .fontWeight(.light)
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
                .padding()
            
            //MARK - FOOTER
            Spacer()
            Button(action: {
                playSound(sound: "success", type: "m4a")
                isOnboardingViewActive = true
            }){
                
                Image(systemName: "arrow.triangle.2.circlepath.circle.fill")
                    .imageScale(.large)
                Text("Restart")
                    .font(.system(.title3,design:.rounded))
                    .fontWeight(.bold)
                
            }//Button
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.capsule)
            .controlSize(.large)
        } //:VSTACK END
        .onAppear(perform: {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5 ,execute: {
                isAnimating = true
            })
        })
    }
}


// MARK: - PREVIEW
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
