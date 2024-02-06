//
//  TooDoWidgetsLiveActivity.swift
//  TooDoWidgets
//
//  Created by Augusto Simionato on 23/09/23.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct TooDoWidgetsAttributes: ActivityAttributes {
    public typealias TimeTrackingStatus = ContentState
    
    public struct ContentState: Codable, Hashable {
        var startTime: Date
    }
}

struct TooDoWidgetsLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: TooDoWidgetsAttributes.self) { context in
            HStack(spacing: 40) {
                Text("Tempo-gasto-na-tarefa")
                    .font(.system(size: 20, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                
                Text(context.state.startTime, style: .timer)
                    .font(.system(size: 35, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
            }
            .activityBackgroundTint(Color.white.opacity(0.1))
            .padding(30)

        } dynamicIsland: { context in
            DynamicIsland {
                DynamicIslandExpandedRegion(.leading) {
                    HStack {
                        Text("Tempo-gasto-na-tarefa")
                            .font(.system(size: 16, weight: .bold, design: .rounded))
                            .foregroundColor(.accent)
                    }
                    .frame(width: 120)
                }
                DynamicIslandExpandedRegion(.trailing) {
                    ZStack(alignment: .center) {
                        Capsule()
                            .foregroundColor(.accent)
                            .opacity(0.2)
                            .frame(width: 100, alignment: .center)
                        
                        VStack {
                            Text(context.state.startTime, style: .timer)
                                .font(.system(size: 25, weight: .semibold, design: .rounded))
                                .foregroundColor(.accent)
                                .frame(width: 60)
                        }
                    }
                    .frame(width: 120)
                }
            } compactLeading: {
                Image(systemName: "stopwatch.fill")
                    .font(.system(size: 17))
                    .foregroundStyle(.accent)
                    .frame(width: 35)
            } compactTrailing: {
                Text(context.state.startTime, style: .timer)
                    .bold()
                    .frame(width: 35)
                    .foregroundStyle(.accent)
            } minimal: {
                Image(systemName: "stopwatch.fill")
                    .font(.system(size: 15))
                    .frame(width: 25)
                    .foregroundStyle(.accent)
            }
        }
    }
}

extension TooDoWidgetsAttributes {
    fileprivate static var preview: TooDoWidgetsAttributes {
        TooDoWidgetsAttributes()
    }
}
