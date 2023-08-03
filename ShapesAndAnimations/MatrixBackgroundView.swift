//
//  MatrixBackgroundView.swift
//  ShapesAndAnimations
//
//  Created by rouzbeh on 03.08.23.
//

import SwiftUI

struct MatrixBackgroundView: View {
    var size: CGSize
    @State var matrixAnimation = false
    @State var randomNumber: Int = 0

    var body: some View {
        let randomHeight: CGFloat = .random(in: (size.height / 2)...size.height)
            VStack() {
                ForEach(0 ..< ContentView.constant.count, id: \.self) { index in
                  let character = Array(ContentView.constant)[getRandomIndex(index: index)]
                    Text(String(character)).font(.custom("matrix code nfi", size: 20)).foregroundColor(.green)
                }
            }.mask(alignment: .top) {
                Rectangle().fill(
                    LinearGradient(
                        colors: [.clear,.black.opacity(0.1),.black.opacity(0.2),.black.opacity(0.3),.black.opacity(0.5),.black.opacity(0.7), .black], startPoint: .top, endPoint: .bottom))
            }.frame(height: size.height/2).offset(y: matrixAnimation ? size.height : -randomHeight)
            .onAppear {
            withAnimation(.linear(duration: 12).repeatForever(autoreverses: false)) {
                matrixAnimation = true
            }
            }.onReceive(Timer.publish(every: 0.2, on: .main, in: .common).autoconnect()) { _ in
                randomNumber = Int.random(in: 0 ..< ContentView.constant.count)
            }
    }
    
    func getRandomIndex(index: Int) -> Int {
        let max = ContentView.constant.count - 1
        if index + randomNumber > max {
            if index - randomNumber < 0 {
                return index
            }
            return index - randomNumber
            
        } else {
            return randomNumber + index
            }
    }
}

