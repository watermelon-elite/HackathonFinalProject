//
//  Transcription.swift
//  HackathonFinalProject
//
//  Created by Kenshu Dieguez on 5/24/25.
//

import Speech
import SwiftUI
import Foundation

class speechToText: ObservableObject {
    func requestTranscribePermissions() {
        SFSpeechRecognizer.requestAuthorization { status in
            DispatchQueue.main.async {
                if status == .authorized {
                    print("Authorized")
                }
                else {
                    print("Request for transcription permission denied")
                }
            }
        }
    }
    
    /*func convertWavToM4A(inputURL: URL, outputURL: URL) async throws {
        return try await withCheckedThrowingContinuation { continuation in
            let asset = AVURLAsset(url: inputURL)

            asset.loadValuesAsynchronously(forKeys: ["tracks"]) {
                var error: NSError?
                let status = asset.statusOfValue(forKey: "tracks", error: &error)

                guard status == .loaded else {
                    continuation.resume(throwing: error ?? NSError(domain: "AVAsset", code: -1, userInfo: nil))
                    return
                }

                if FileManager.default.fileExists(atPath: outputURL.path) {
                    try? FileManager.default.removeItem(at: outputURL)
                }

                guard let exporter = AVAssetExportSession(asset: asset, presetName: AVAssetExportPresetAppleM4A) else {
                    continuation.resume(throwing: NSError(domain: "ExportSession", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to create export session"]))
                    return
                }

                exporter.outputURL = outputURL
                exporter.outputFileType = .m4a

                exporter.exportAsynchronously {
                    switch exporter.status {
                    case .completed:
                        continuation.resume()
                    case .failed, .cancelled:
                        continuation.resume(throwing: exporter.error ?? NSError(domain: "ExportSession", code: -2, userInfo: nil))
                    default:
                        break
                    }
                }
            }
        }
    }*/
    
    func transcribeAudio(url: URL) async -> String {
        let recognizer = SFSpeechRecognizer(locale: Locale(identifier: "en-US"))!
        let request = SFSpeechURLRecognitionRequest(url: url)
        let output = ""
        //Start recognition
        recognizer.recognitionTask(with: request) { (result, error) in
            //abort if we didn't transcription back
            guard let result = result else {
                print("SO SAD")
                print(error)
                return
            }
            
            if result.isFinal {
                print(result.bestTranscription.formattedString)
            }
            
        }
        return output
    }/*
    func transcribeAudio(url: URL) async -> String {
        let outputM4AURL = FileManager.getDocumentsDirectory().appendingPathComponent("output.m4a")

        do {
            try await convertWavToM4A(inputURL: url, outputURL: outputM4AURL)
            print("Conversion successful: \(outputM4AURL)")
        } catch {
            print("Conversion failed: \(error.localizedDescription)")
            return "Conversion failed"
        }

        return await withCheckedContinuation { continuation in
            let recognizer = SFSpeechRecognizer(locale: Locale(identifier: "en-US"))!
            let request = SFSpeechURLRecognitionRequest(url: outputM4AURL)

            recognizer.recognitionTask(with: request) { result, error in
                guard let result = result else {
                    continuation.resume(returning: error?.localizedDescription ?? "Transcription failed")
                    return
                }

                if result.isFinal {
                    print(result.bestTranscription.formattedString)
                    continuation.resume(returning: result.bestTranscription.formattedString)
                }
            }
        }
    }*/
}
