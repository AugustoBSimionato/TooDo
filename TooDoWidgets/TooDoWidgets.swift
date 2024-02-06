//
//  TooDoWidgets.swift
//  TooDoWidgets
//
//  Created by Augusto Simionato on 23/09/23.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), emoji: "😀")
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), emoji: "😀")
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, emoji: "😀")
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let emoji: String
}

struct TooDoWidgetsEntryView : View {
    @Environment(\.widgetFamily) var type
    var entry: Provider.Entry

    var body: some View {
        switch type {
            case .systemSmall:
                VStack {
                    Image(systemName: "arrowshape.turn.up.forward.circle.fill")
                        .foregroundStyle(.text)
                        .font(.system(size: 40))
                        .bold()
                        .padding(.bottom, 3)
                    
                    Text("Acessar-tarefas")
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.text)
                        .font(.system(size: 17, weight: .black, design: .rounded))
                    
                    Image(.rabisco)
                        .resizable()
                        .frame(width: 110, height: 20)
                }
                .overlay {
                    Image(.ideia)
                        .resizable()
                        .frame(width: 23, height: 35)
                        .offset(x: 40.0, y: -56.0)
                        .rotationEffect(.degrees(15))
                }
            case .systemMedium:
                VStack {
                    Image(systemName: "arrowshape.turn.up.forward.circle.fill")
                        .foregroundStyle(.text)
                        .font(.system(size: 40))
                        .bold()
                        .padding(.bottom, 3)
                    
                    Text("Acessar-tarefas")
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.text)
                        .font(.system(size: 17, weight: .black, design: .rounded))
                    
                    Image(.rabisco)
                        .resizable()
                        .frame(width: 150, height: 20)
                }
                .overlay {
                    Image(.curlyline)
                        .resizable()
                        .frame(width: 100, height: 100)
                        .offset(x: -150.0, y: -80.0)
                        .rotationEffect(.degrees(-10))
                    
                    Image(.curlyline)
                        .resizable()
                        .frame(width: 100, height: 100)
                        .offset(x: 145.0, y: 20.0)
                        .rotationEffect(.degrees(20))
                }
            case .systemLarge:
                Text("Not implemented yet")
            case .accessoryCircular:
                VStack {
                    ZStack {
                        RoundedRectangle(cornerRadius: 15.0)
                            .foregroundStyle(.white)
                            .opacity(0.3)
                        
                        Image(systemName: "list.bullet.circle.fill")
                            .font(.system(size: 40))
                    }
                }
            case .systemExtraLarge:
                Text("Not implemented yet")
            case .accessoryRectangular:
                Text("Not implemented yet")
            case .accessoryInline:
                Text("Tarefas do TooDo")
            @unknown default:
                Text("Not implemented yet")
        }
    }
}

struct TooDoWidgets: Widget {
    let kind: String = "TooDoWidgets"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            TooDoWidgetsEntryView(entry: entry)
                .containerBackground(.widgetBackground, for: .widget)
        }
        .supportedFamilies([.systemSmall, .systemMedium, .accessoryCircular])
        .configurationDisplayName("widget-title")
        .description("widget-description")
    }
}

#Preview(as: .systemSmall) {
    TooDoWidgets()
} timeline: {
    SimpleEntry(date: .now, emoji: "😀")
}

#Preview(as: .systemMedium) {
    TooDoWidgets()
} timeline: {
    SimpleEntry(date: .now, emoji: "😀")
}
