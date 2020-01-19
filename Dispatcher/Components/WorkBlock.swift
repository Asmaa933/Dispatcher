//
//  WorkBlock.swift
//  Dispatcher
//
//  Created by Besher on 2020-01-19.
//  Copyright © 2020 Besher Al Maleh. All rights reserved.
//

import SwiftUI

struct WorkBlock: View {
    
    
    @State private var progress: CGFloat = 1.0
    @State private var borderOpacity: Double = 1.0
    @State private var scale: CGFloat = 0.5
    private let taskDuration: Double = 3.0
    private let color: Color
    private let possibleBlockColors: [Color] = [.purple]
    private let isCollapsing: Bool
    
    
    var body: some View {
        return color
            .frame(width: 60, height: 150 * progress)
            .border(Color.yellow.opacity(borderOpacity), width: 4)
            .padding(.top)
            .scaleEffect(scale)
            .animation(.default)
            .onAppear {
                self.startTask()
                self.scale = 1.0
        }
    }
    
    init (isCollapsing: Bool) {
        self.color = possibleBlockColors.randomElement() ?? .red
        self.isCollapsing = isCollapsing
    }
    
    func startTask() {
        guard isCollapsing else { return }
        
        withAnimation(Animation
            .linear(duration: self.taskDuration)) {
            self.progress = 0.0
        }
        withAnimation(Animation
            .linear(duration: self.taskDuration / 4)
            .delay(3 * self.taskDuration / 4)) {
            self.borderOpacity = 0.0
        }
    }
}

struct WorkBlock_Previews: PreviewProvider {
    static var previews: some View {
        WorkBlock(isCollapsing: false)
    }
}
