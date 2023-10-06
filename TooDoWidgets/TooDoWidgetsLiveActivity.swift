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
            // Lock screen/banner UI goes here
            HStack(spacing: 40) {
                Text("Tempo gasto na tarefa")
                    .font(.system(size: 18, weight: .bold, design: .rounded))
                    
                Text(context.state.startTime, style: .timer)
                    .font(.system(size: 30, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
            }
            .activityBackgroundTint(.accentColor)
            .padding(30)

        } dynamicIsland: { context in
            DynamicIsland {
                DynamicIslandExpandedRegion(.leading) {
                    HStack {
                        Text("Tempo decorrido")
                            .font(.system(size: 18, weight: .bold, design: .rounded))
                            .foregroundColor(.accentColor)
                    }
                    .frame(width: 120)
                }
                DynamicIslandExpandedRegion(.trailing) {
                    ZStack(alignment: .center) {
                        Capsule()
                            .foregroundColor(.accentColor)
                            .opacity(0.2)
                            .frame(width: 100, alignment: .center)
                        
                        VStack {
                            Text(context.state.startTime, style: .timer)
                                .font(.system(size: 25, weight: .semibold, design: .rounded))
                                .foregroundColor(.accentColor)
                                .frame(width: 60)
                        }
                    }
                    .frame(width: 120)
                }
            } compactLeading: {
                Image(systemName: "stopwatch.fill")
                    .font(.system(size: 15))
                    .foregroundStyle(Color.accentColor)
            } compactTrailing: {
                Text(context.state.startTime, style: .timer)
                    .bold()
                    .frame(width: 40)
                    .foregroundColor(.accentColor)
            } minimal: {
                Image(systemName: "stopwatch.fill")
                    .font(.system(size: 15))
                    .frame(width: 25)
                    .foregroundColor(.accentColor)
            }
        }
    }
}

extension TooDoWidgetsAttributes {
    fileprivate static var preview: TooDoWidgetsAttributes {
        TooDoWidgetsAttributes()
    }
}
