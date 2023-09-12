//
//  TooDoWidgetsBundle.swift
//  TooDoWidgets
//
//  Created by Augusto Simionato on 23/09/23.
//

import WidgetKit
import SwiftUI

@main
struct TooDoWidgetsBundle: WidgetBundle {
    var body: some Widget {
        TooDoWidgets()
        TooDoWidgetsLiveActivity()
    }
}
