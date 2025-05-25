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
    @EnvironmentObject var transcriptionModel: speechToText
    @EnvironmentObject var audioModel: AudioModel
    @FetchRequest(sortDescriptors: [SortDescriptor(\.name)]) var mice: FetchedResults<Mouse>
    @State var dest: URL? = nil
    
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
                        FileManager.downloadAndSaveAudio(from: "https://jmp.sh/s/nnQLSqD6uKkTlucisH1f", fileName: "PWEASEWORK") { result in
                            switch result {
                            case .success(let fileURL):
                                addDummyMouse(fileURL)
                            case .failure(let error):
                                print("Failed to download \(error)")
                            }
                            
                        }
                        
                        
                    }
                }
                ToolbarItem {
                    Button("CREATE DUMMY MOUSE") {
                        addDummyMouse(URL(string: "youtube.com")!)
                    }
                }
                
            }
            .onAppear {
                audioModel.getEpochs()
                transcriptionModel.requestTranscribePermissions()                
            }
        }
    }
    
    
    /*func addFile() {
        var sourceFile: URL? = nil
        var work: URL? = nil
        var fileName = "Items.m4a" // Change this to your actual filename
        if let path = Bundle.main.path(forResource: "Items", ofType: "m4a") {
            let audioURL = URL(fileURLWithPath: path)
            sourceFile = audioURL
            
            // For example, play it or copy it:
            print("Found audio file at: \(audioURL)")

            // Copy to Documents if needed:
            dest = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("Items.m4a")
            work = dest
            do {
                if FileManager.default.fileExists(atPath: dest!.path) {
                    try FileManager.default.removeItem(at: dest!)
                }
                try FileManager.default.copyItem(at: audioURL, to: dest!)
                print("Copied to documents folder: \(dest!)")
            } catch {
                print("Copy failed: \(error)")
            }
        }
        do {
            if FileManager.default.fileExists(atPath: work!.path) {
                try FileManager.default.removeItem(at: dest!)
            }
            try FileManager.default.copyItem(at: sourceFile!, to: dest!)
            print("Copied file to: \(dest!)")
        } catch {
            print("Failed to copy file: \(error.localizedDescription)")
        }
    }*/
    
    func addDummyMouse(_ file: URL) {
        let testPath = "/Users/kenshu/Downloads/30th St N 5.m4a"
        let mouse = Mouse(context: moc)
        mouse.id = UUID()
        mouse.name = "Mouse #1"
        mouse.transcript = ""
        mouse.rawAudio = ""
        Task {
            await mouse.transcript = transcriptionModel.transcribeAudio(url: dest!)
        }
        print(mouse.transcript ?? "NO TRANSCRIPT")
        
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


