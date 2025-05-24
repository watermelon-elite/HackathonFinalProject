//
//  ContentView.swift
//  HackathonProject
//
//  Created by Thurston Reese on 5/24/25.
//
import SwiftUI
import CoreData
struct ContentView: View {
    @Environment(\.managedObjectContext) private var moc
    @FetchRequest(sortDescriptors: [SortDescriptor(\.name)]) var mice: FetchedResults<Mouse>
    
    @State var path = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $path) {
            List(mice) { mouse in
                NavigationLink(destination: MiceDetails(mouse: mouse)) {
                    Text(mouse.name ?? "ERROR")
                }
            }
            .navigationTitle("Mice")
            .toolbar {
                ToolbarItem {
                    Button("Get webserver data") {
                        FileManager.downloadAndSaveAudio(from: "https://jmp.sh/s/SqUw7BaDtcStKceOxnEh", fileName: "PWEASE WORK") { success in
                            
                            
                        }
                        
                        
                    }
                }
            }
        }
    }
    
    
    
    func addDummyMouse() {
        let mouse = Mouse(context: moc)
        mouse.id = UUID()
        mouse.name = "Mouse #2"
        mouse.transcript = ""
        if moc.hasChanges {
            try? moc.save()
        }
        
    }
    func deleteAllMice() {
        for mouse in mice {
            moc.delete(mouse)
        }
        if moc.hasChanges {
            try? moc.save()
        }
    }
    
}


