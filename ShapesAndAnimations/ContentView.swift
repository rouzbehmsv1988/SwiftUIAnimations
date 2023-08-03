//
//  ContentView.swift
//  ShapesAndAnimations
//
//  Created by rouzbeh on 03.08.23.
//

import SwiftUI

struct ContentView: View {
    @State var firstLevelClicked = false
    @State var SecondLevelClicked = false
    @State var thirdLevelClicked = false
    @State var forthLevelClicked = false
    @State var bounce = false
    static let constant = "aklsjdhfweroiu,mn,vasdfsdf';l[popoupoiu"

    func playButton(third: Bool) -> some View {
        ZStack {
            Circle().stroke(Color.red).frame(width: 200, height: 200) .background(Circle().foregroundColor(third ? Color.red: .clear))
            PolygonShape(sides:3).fill(Color.red).frame(width: 100, height: 100)
        }
    }
    var body: some View {
        GeometryReader { proxy in
            let size = proxy.size

            ZStack() {
                HStack(spacing: 15) {
              
                    ForEach(1 ..< Int(size.width)/20, id: \.self) {_ in
                        MatrixBackgroundView(size: size)
                    }
                   
                }.padding(.horizontal)
                
                    if thirdLevelClicked {
                        Image("Matrix2").offset(x: -50).scaleEffect(forthLevelClicked ? 0.8: 0).animation(.easeOut(duration: 4.0), value: forthLevelClicked).onAppear{
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                                forthLevelClicked.toggle()
                                firstLevelClicked.toggle()
                            })
                        }.background(.black)
                        
                    }
                    

                ZStack {
                    VStack {
                        if !firstLevelClicked {
                            Text("Play Me").font(.largeTitle).foregroundColor(.red).offset(y: bounce ? 0 : -5).animation(.interpolatingSpring(stiffness: 100, damping: 5, initialVelocity: 100).repeatForever())
                        }
                        playButton(third: thirdLevelClicked).scaleEffect(firstLevelClicked ? 20.0 :0.7 ).rotationEffect( firstLevelClicked ? Angle(degrees: 360): Angle(degrees: 0)).opacity(firstLevelClicked ? 0.5: 1.0).animation(.easeOut(duration: 3.0), value: firstLevelClicked).onTapGesture {
                            if !firstLevelClicked {
                                firstLevelClicked.toggle()
                            }
                            
                        }.background(.black.opacity(0.02))
                        
                    }.onAppear{
                        bounce.toggle()
                    }
                    VStack {
                        Text("SwiftUI")
                            .font(.system(size: 60)).foregroundColor(.white)
                            .background(Color.clear).animation(Animation.easeInOut(duration: 2.0), value: firstLevelClicked)
                            .offset(x: self.firstLevelClicked ? 0 : 400)
                        Text("is amazing").foregroundColor(.white)
                            .font(.system(size: 60))
                            .background(Color.clear)
                            .animation(Animation.easeInOut(duration: 2.0), value: firstLevelClicked)
                            .offset(x: self.firstLevelClicked ? 0 : -400)
                        playButton(third: false).frame(width: 200, height: 200)
                            .opacity(firstLevelClicked ? 1.0: 0)
                            .animation(Animation.easeInOut(duration: 2.0), value: firstLevelClicked)
                            .onTapGesture {
                                SecondLevelClicked.toggle()
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                                    thirdLevelClicked.toggle()
                                })
                            }.rotation3DEffect(.degrees(SecondLevelClicked ? 360: 1), axis: (x: 0, y: SecondLevelClicked ? 1: 0, z: 0)).animation(.easeOut(duration: 2).speed(1.5).repeatForever(autoreverses: false), value: SecondLevelClicked)
                    }
                    
                }.background(.black.opacity(0.1)).frame(maxWidth: .infinity, maxHeight: .infinity).scaleEffect(thirdLevelClicked ? 0.004: 1.0).offset(x: thirdLevelClicked ? -140: 0, y: thirdLevelClicked ? 25: 0).animation(.easeOut(duration: 5.0), value: thirdLevelClicked)
                    
            }.background(.black)
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
