//
//  SchrodEqApp.swift
//  SchrodEq
//
//  Created by IIT PHYS 440 on 2/24/23.
//

import SwiftUI

@main
struct SchrodEqApp: App {
    @StateObject var plotData = PlotClass()
    
    var body: some Scene {
        WindowGroup {
            TabView {
                ContentView()
                    .environmentObject(plotData)
                    .tabItem {
                        Text("Plot")
                    }
                TextView()
                    .environmentObject(plotData)
                    .tabItem {
                        Text("Text")
                    }
                            
                            
            }
            
        }
    }

}
