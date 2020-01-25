//
//  ContentView.swift
//  Dispatcher
//
//  Created by Besher on 2020-01-16.
//  Copyright © 2020 Besher Al Maleh. All rights reserved.
//

import SwiftUI

public struct ContentView: View {
    
    @State private var didStart = true
    
    public var body: some View {
        TabView {
            DiagramView(didStart: $didStart)
                .tabItem {
                    Image(systemName: "book")
                    Text("Explanation")
            }
            QuizView()
                .tabItem {
                    Image(systemName: "text.badge.checkmark")
                    Text("Quiz")
            }
        }
    }
    
    public init() {}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}