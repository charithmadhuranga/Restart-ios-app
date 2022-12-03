//
//  OnboardingView.swift
//  Restart
//
//  Created by charith wijesundara on 2022-11-24.
//

import SwiftUI

struct OnboardingView: View {
    
    //MARK: PROPERTY
    @AppStorage("onboarding") var isOnboardingViewActive: Bool = true
    @State private var ButtonWidth: Double = UIScreen.main.bounds.width - 80
    @State private var ButtonOffset: CGFloat = 0
    @State private var isAnimating: Bool = false
    @State private var imageOffset:CGSize = .zero
    @State private var indicaterOpacity:Double = 0.1
    @State private var textTitle:String = "Share."
    let hapticfeedback = UINotificationFeedbackGenerator()
    //MARK: BODY
    
    
    var body: some View {
        ZStack {
            Color("ColorBlue")
            .ignoresSafeArea(.all,edges:.all)
            VStack(spacing:20) {
                
            
                
                
                
                //MARK: HEADER
                Spacer()

                VStack(spacing:0){
                    Text(textTitle)
                        .font(.system(size: 60))
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                        .transition(.opacity)
                        .id(textTitle)
                    Text("""
It's not how much we give,how much love we put in to giving
""")
                    .font(.title3)
                    .fontWeight(.light)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal,10)
                }
                
                //MARK: HEADER END
                .opacity(isAnimating ? 1:0)
                .offset(y: isAnimating ? 0:-40)
                .animation(.easeOut(duration:1),value: isAnimating)
                
                
            
                //MARK: CENTER
                
                
                ZStack(){
                    CircleGroupView(ShapeColor: .white, ShapeOpacity: 0.2)
                        .offset(x: imageOffset.width * -1)
                        .blur(radius: abs(imageOffset.width/5))
                        .animation(.easeOut(duration:1), value: imageOffset)
                    
                    Image("character-1")
                        .resizable()
                        .scaledToFit()
                        .opacity(isAnimating ? 1:0)
                        .animation(.easeOut(duration:0.5),value: isAnimating)
                        .offset(x:imageOffset.width*1.2,y:0)
                        .rotationEffect(Angle(degrees: Double(imageOffset.width/20)))
                        .gesture(
                            DragGesture()
                                .onChanged{ gesture in
                                    
                                    if abs(imageOffset.width) <= 150{
                                        imageOffset = gesture.translation
                                        withAnimation(.linear(duration: 0.25)){
                                            indicaterOpacity = 0
                                            textTitle="Give."
                                        }
                                    }
                                }
                                .onEnded{ _ in
                                    imageOffset = .zero
                                    withAnimation(.linear(duration: 0.25)){
                                        indicaterOpacity = 1
                                        textTitle="Share."
                                    }
                                    
                                }
                        )//Gesture
                        .animation(.easeOut(duration: 1), value: imageOffset)
                }
                .overlay(
                Image(systemName: "arrow.left.and.right.circle")
                    .font(.system(size:44,weight: .ultraLight))
                    .foregroundColor(.white)
                    .offset(y: 20)
                    .opacity(isAnimating ? 1:0)
                    .animation(.easeOut(duration:1).delay(2),value: isAnimating)
                    .opacity(indicaterOpacity)
                ,alignment: .bottom
                )
                
                
                Spacer()
                
                
                //MARK: CENTER END
                
                
                
                
                //MARK: FOOTER
                
                
                
                
                
                ZStack(){
                    //MARK: PARTS OF THE CUSTUM BUTTON
                    //1.BACKGROUND (STATIC)
                    Capsule()
                        .fill(Color.white.opacity(0.2))
                    Capsule()
                        .fill(Color.white.opacity(0.2))
                        .padding(8)
                    //2.CALL-TO-ACTION(STATIC)
                    Text("Getting Started")
                        .font(.system(.title3,design:.rounded))
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .offset(x:20)
                    

                    //3.CAPSULE (DYNAMIC WIDTH)
                    //:HSTACK START
                    HStack {
                        Capsule()
                            .fill(Color("ColorRed"))
                            .frame(width: ButtonOffset+80)
                            
                        Spacer()
                    }
                    
                    //4.CIRCLE(DRAGABLE)
                    //:HSTACK START
                    HStack {
                        //:Z-STACK START
                        ZStack(){
                            Circle()
                                .fill(Color("ColorRed"))
                            Circle()
                                .fill(Color.black.opacity(0.15))
                                .padding(8)
                            Image(systemName: "chevron.right.2")
                                .font(.system(size:24,weight:.bold))
                                
                            
                        }.foregroundColor(Color.white)
                            .frame(width: 80 ,height:80,alignment:.center)
                            .offset(x: ButtonOffset)
                            .gesture(
                                DragGesture()
                                    .onChanged{ gesture in
                                        if gesture.translation.width > 0 && ButtonOffset <= ButtonWidth - 80{
                                            ButtonOffset = gesture.translation.width
                                        }
                                        
                                    }
                                    .onEnded { _ in
                                        withAnimation(Animation.easeInOut(duration: 3)){
                                            if ButtonOffset > ButtonWidth/2{
                                                ButtonOffset = ButtonWidth - 80
                                                isOnboardingViewActive = false
                                                hapticfeedback.notificationOccurred(.success)
                                                playSound(sound: "chimeup", type: "mp3")
                                            }else{
                                                hapticfeedback.notificationOccurred(.warning)
                                                ButtonOffset=0
                                            }
                                        }
                                            
                                        }
                            )
                        Spacer()
                    }
                    
                    

                }//: Z-STACK END
                .frame(width: ButtonWidth,height: 80, alignment: .center)
                .opacity(isAnimating ? 1:0)
                .offset(y: isAnimating ? 0:40)
                .animation(.easeOut(duration:1),value: isAnimating)
                .padding()
                

                
                
                //MARK: FOOTER END
                
                
                
                
            }//:VSTACK END
        }//ZSTACK END
        
        .onAppear(perform: {
            isAnimating = true
        })
        .preferredColorScheme(.dark)
    }
}

//MARK: PREVIEW
struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}

