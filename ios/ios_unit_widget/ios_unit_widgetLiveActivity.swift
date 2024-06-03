//
//  ios_unit_widgetLiveActivity.swift
//  ios_unit_widget
//
//  Created by Vladimir Izmaylov on 03.06.2024.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct ios_unit_widgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct ios_unit_widgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: ios_unit_widgetAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension ios_unit_widgetAttributes {
    fileprivate static var preview: ios_unit_widgetAttributes {
        ios_unit_widgetAttributes(name: "World")
    }
}

extension ios_unit_widgetAttributes.ContentState {
    fileprivate static var smiley: ios_unit_widgetAttributes.ContentState {
        ios_unit_widgetAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: ios_unit_widgetAttributes.ContentState {
         ios_unit_widgetAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: ios_unit_widgetAttributes.preview) {
   ios_unit_widgetLiveActivity()
} contentStates: {
    ios_unit_widgetAttributes.ContentState.smiley
    ios_unit_widgetAttributes.ContentState.starEyes
}
