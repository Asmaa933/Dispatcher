//
//  Scheduler.swift
//  Dispatcher
//
//  Created by Besher on 2020-01-19.
//  Copyright © 2020 Besher Al Maleh. All rights reserved.
//

import SwiftUI

struct Scheduler: View {
    
    private let spacing: CGFloat = 25
    private let topic: Topic
    private var tasks = [Task]()
    
    @State private var mainThreads = 1
    @State private var otherThreads = 0
    
    @Binding var didStart: Bool
    
    init(topic: Int, didStart: Binding<Bool>) {
        self.topic = Topic.allCases[topic]
        self._didStart = didStart
        self.tasks = getTasks(for: self.topic)
    }
    
    var body: some View {
        ZStack (alignment: .bottom) {
            HStack(spacing: spacing) {
                if topic == .sync || topic == .async {
                    ForEach(0..<topic.numberOfQueues, id: \.self) { num in
                        num == 0 ? Queue(topic: self.topic, type: .main, tasks: self.tasks)
                            .zIndex(1)
                            : Queue(topic: self.topic, type: .global, tasks: self.tasks)
                                .zIndex(0)
                    }
                    .id(UUID())
                } else if topic == .serial {
                    ForEach(0..<topic.numberOfQueues, id: \.self) { num in
                        num == 0 ? Queue(topic: .serial, type: .main, tasks: self.tasks)
                            .zIndex(1)
                            : Queue(topic: .serial, type: .privateSerial, tasks: self.tasks)
                                .zIndex(0)
                    }
                    .id(UUID())
                } else if topic == .concurrent {
                    ForEach(0..<topic.numberOfQueues, id: \.self) { num in
                        num == 0 ? Queue(topic: .concurrent, type: .main, tasks: self.tasks)
                            .zIndex(1)
                            : Queue(topic: .concurrent, type: .privateConcurrent, tasks: self.tasks)
                                .zIndex(0)
                    }
                    .id(UUID())
                }
            }
            VStack (spacing: 0.0) {
                Subtitles(didStart: $didStart, topic: topic)
                CodeConsole(tasks: tasks)
                    .frame(maxHeight: 100)
            }
                // forces animation restart
                .opacity(didStart ? 1.0 : 0.99)
                .padding(.bottom, -10)
        }
            .id(UUID()) // forces animation restart
    }
    
    func getTasks(for topic: Topic) -> [Task] {
        switch topic {
        case .sync: return TaskGenerator.createSyncTasks()
        case .async: return TaskGenerator.createAsyncTasks()
        default: return TaskGenerator.createSyncTasks()
        }
    }
}

struct Scheduler_Previews: PreviewProvider {
    
    static var previews: some View {
        Scheduler(topic: 0, didStart: .constant(false))
    }
}
