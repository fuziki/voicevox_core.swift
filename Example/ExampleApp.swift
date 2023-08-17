//
//  ExampleApp.swift
//  Example
//  
//  Created by fuziki on 2023/08/15
//  
//

import SwiftUI

@main
struct ExampleApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(vm: .init(voicevoxCoreService: VoicevoxCoreService()))
        }
    }
}
