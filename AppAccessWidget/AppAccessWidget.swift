//
//  AppAccessWidget.swift
//  AppAccessWidget
//
//  Created by Augusto Simionato on 24/05/23.
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

struct AppAccessWidgetEntryView : View {
    @Environment(\.widgetFamily) var widgetFamily
    var entry: Provider.Entry

    var body: some View {
        switch widgetFamily {
        case .accessoryCircular:
            VStack {
                Image(systemName: "square.and.pencil.circle.fill")
                    .font(.system(size: 50))
            }
        case .systemSmall:
            ZStack {
                Color("backgroundColor")
                
                VStack {
                    Image(systemName: "square.and.pencil.circle.fill")
                        .font(.system(size: 70))
                        .foregroundColor(.white)
                        .padding(.bottom, 2)
                    Text("Adicionar tarefa")
                        .foregroundColor(.white)
                }
            }
        default:
            Text("Not implemented")
        }
    }
}

struct AppAccessWidget: Widget {
    let kind: String = "AppAccessWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            AppAccessWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("TooDo")
        .description("Acesse sua lista de tarefas em um clique!")
        .supportedFamilies([.accessoryCircular, .systemSmall])
    }
}

struct AppAccessWidget_Previews: PreviewProvider {
    static var previews: some View {
        AppAccessWidgetEntryView(entry: SimpleEntry(date: Date()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
            .previewDisplayName("small")
        AppAccessWidgetEntryView(entry: SimpleEntry(date: Date()))
            .previewContext(WidgetPreviewContext(family: .accessoryCircular))
            .previewDisplayName("circular")
    }
}
