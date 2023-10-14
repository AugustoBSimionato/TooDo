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
                        .foregroundStyle(.white)
                        .font(.system(size: 35))
                        .padding(.bottom)
                    
                    Text("Acessar-tarefas")
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.white)
                        .font(.system(size: 17, weight: .semibold, design: .rounded))
                }
                .overlay {
                    Image("toodo-logo")
                        .resizable()
                        .frame(width: 24, height: 20)
                        .offset(x: 50.0, y: -50.0)
                }
            case .systemMedium:
                Text("Not implemented yet")
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
            if #available(iOS 17.0, *) {
                TooDoWidgetsEntryView(entry: entry)
                    .containerBackground(.accent, for: .widget)
            } else {
                TooDoWidgetsEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .supportedFamilies([.systemSmall, .accessoryCircular, .accessoryInline])
        .configurationDisplayName("Lista-de-tarefas-do-TooDo")
        .description("Acesse-sua-lista-de-tarefas-de-forma-rápida-na-home-ou-lock-screen!")
    }
}

#Preview(as: .systemSmall) {
    TooDoWidgets()
} timeline: {
    SimpleEntry(date: .now, emoji: "😀")
    SimpleEntry(date: .now, emoji: "🤩")
}
