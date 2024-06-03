//
//  ios_unit_widget.swift
//  ios_unit_widget
//
//  Created by Vladimir Izmaylov on 03.06.2024.
//

import WidgetKit
import SwiftUI

struct Provider: AppIntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationAppIntent())
    }

    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: configuration)
    }
    
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<SimpleEntry> {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration)
            entries.append(entry)
        }

        return Timeline(entries: entries, policy: .atEnd)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationAppIntent
}

struct ios_unit_widgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        ContentView()
//        VStack {
//            ContainerRelativeShape(
//                
//            )
//            Text("Time:")
//            Text(entry.date, style: .time)
//
//            Text("Favorite Emoji:")
//            Text(entry.configuration.favoriteEmoji)
//        }
    }
}

struct ios_unit_widget: Widget {
    let kind: String = "ios_unit_widget"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: Provider()) { entry in
            ios_unit_widgetEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
    }
}

struct ContentView: View {
    var body: some View {
        
        VStack(spacing: 10) {
            // Speed Container
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color(red: 242/255, green: 241/255, blue: 241/255, opacity: 1))
                    .frame(width: 130, height: 84)

                HStack {
                    Text("Time")
                        .font(.system(size: 15))
                        .padding(.leading, 8)
                        .offset(y: 20)
                    
                    Spacer()
                    
                    Image("Speed icon")
                        .padding(.trailing, 16)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 40, height: 20)
                        .offset(y: -20)
                }
            }
            
            // Conversion Container
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color(red: 214/255, green: 255/255, blue: 121/255, opacity: 1))
                    .frame(width: 130, height: 40)
                
                HStack {
                    Text("sec")
                        .font(.system(size: 15))
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .padding(.leading, 14)
                    
                    Spacer()
                    
                    Text("→")
                        .font(.headline)
                    
                    Spacer()
                    
                    Text("min")
                        .font(.system(size: 15))
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .padding(.trailing, 14)
                }
            }
        }
        .padding()
        .background(Color(.white))
    }
}

extension ConfigurationAppIntent {
    fileprivate static var smiley: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "😀"
        return intent
    }
    
    fileprivate static var starEyes: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "🤩"
        return intent
    }
}

#Preview(as: .systemSmall) {
    ios_unit_widget()
} timeline: {
    SimpleEntry(date: .now, configuration: .smiley)
    SimpleEntry(date: .now, configuration: .starEyes)
}
