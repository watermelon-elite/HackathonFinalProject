//
//  HackathonProjectApp.swift
//  HackathonProject
//
//  Created by Thurston Reese on 5/24/25.
//
import SwiftUI
@main
struct HackathonProjectApp: App {
    @StateObject var transcriptionmodel = speechToText()
    @StateObject var audiomodel = AudioModel()
    @StateObject private var datacontroller = DataController() //Load core data using the data controller
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, datacontroller.container.viewContext) //Input Core Data into the environment
                .environmentObject(transcriptionmodel)
                .environmentObject(audiomodel)
        }
    }
}

 
