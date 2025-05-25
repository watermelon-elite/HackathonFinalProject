//
//  MiceDetails.swift
//  HackathonProject
//
//  Created by Thurston Reese on 5/24/25.
//
import Foundation
import SwiftUI
struct MiceDetails: View {
    var mouse: FetchedResults<Mouse>.Element
    var body: some View {
        VStack {
            Form {
                Section(header: Text("Listen to Audio")) {
                    NavigationLink(destination: AudioPlayerView(mouse: mouse)) {
                        Text("AUDIO")
                    }
                }
                Section(header: Text("Team Current Progress")) {
                    Text("Analyze loudness and explain progress")
                }
                Section(header: Text("Team Transcript Summary")) {
                    Text("No Summary Available")
                }
                
            }
            ScrollView {
                Text((mouse.transcript!.trimmingCharacters(in: .whitespacesAndNewlines) == "" ? "No Transcript" : mouse.transcript) ?? "No Transcript")
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    .multilineTextAlignment(.leading)
                    .padding()
                    .lineLimit(nil)
            }
            .padding()
            .frame(maxHeight: 400)
            .background {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundStyle(Color.white)
                        .opacity(0.1)
                    RoundedRectangle(cornerRadius: 10)
                        .stroke()
                        .foregroundStyle(Color.white)
                }
                .padding()
                .navigationTitle(mouse.name ?? "ERROR")
            }
        }
    }
    
    @ViewBuilder func currentProgress() -> any View {
        
    }
}

