//
//  TodoListWidgets.swift
//  TodoListWidgets
//
//  Created by Augusto Simionato on 02/09/23.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date())
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
}

struct TodoListWidgetsEntryView : View {
    @Environment(\.widgetFamily) var widgetFamily

    var body: some View {
        switch widgetFamily {
        case .accessoryCircular:
            ZStack {
                Color.gray.opacity(0.3)
                VStack {
                    Image(systemName: "list.bullet.circle.fill")
                        .font(.system(size: 35))
                }
            }
        case .systemSmall:
            ZStack {
                Color.accentColor.opacity(0.3)
                
                VStack(spacing: 5) {
                    Image(systemName: "list.bullet.circle.fill")
                        .font(.system(size: 40))
                        .foregroundColor(.accentColor)
                    Text("Ver tarefas")
                        .foregroundColor(.accentColor)
                        .bold()
                        .font(.system(size: 23))
                        .multilineTextAlignment(.center)
                }
            }
        case .systemMedium:
            ZStack {
                Color.accentColor.opacity(0.3)
                
                HStack {
                    Text("Ver tarefas")
                        .foregroundColor(.accentColor)
                        .bold()
                        .font(.system(size: 23))
                    Image(systemName: "list.bullet.circle.fill")
                        .font(.system(size: 40))
                        .foregroundColor(.accentColor)
                }
            }
        case .systemLarge:
            ZStack {
                Color.accentColor.opacity(0.3)
                
                HStack {
                    Text("Ver tarefas")
                        .foregroundColor(.accentColor)
                        .bold()
                        .font(.system(size: 23))
                    Image(systemName: "list.bullet.circle.fill")
                        .font(.system(size: 40))
                        .foregroundColor(.accentColor)
                }
            }
        default:
            Text("Ainda não implementamos esse widget...")
        }
    }
}

struct TodoListWidgets: Widget {
    let kind: String = "TodoListWidgets"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            TodoListWidgetsEntryView()
        }
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge, .accessoryCircular])
        .configurationDisplayName("TooDo")
        .description("Adicione widgets que te ajudam a manter você atualizado sobre as tarefas que estão para ser concluídas!")
    }
}

struct TodoListWidgets_Previews: PreviewProvider {
    static var previews: some View {
        TodoListWidgetsEntryView()
            .previewContext(WidgetPreviewContext(family: .systemSmall))
            .previewDisplayName("small")
        TodoListWidgetsEntryView()
            .previewContext(WidgetPreviewContext(family: .systemMedium))
            .previewDisplayName("medium")
        TodoListWidgetsEntryView()
            .previewContext(WidgetPreviewContext(family: .accessoryCircular))
            .previewLayout(.sizeThatFits)
            .previewDisplayName("circular")
    }
}
