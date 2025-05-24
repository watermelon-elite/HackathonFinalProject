//
//  AudioModel.swift
//  HackathonFinalProject
//
//  Created by Thurston Reese on 5/24/25.
//

import Foundation
import AVFoundation
import SwiftUI

class AudioModel: ObservableObject {
    let startEpoch = 1716528000
    let endEpoch = 1716528010

    let baseURL = "https://example.com/audio/" // Your base URL
    var downloadedFileURLs: [URL] = []

    let group = DispatchGroup()
    func fetchAudio() {

        for timestamp in startEpoch...endEpoch {
            group.enter()
            let url = "\(baseURL)\(timestamp).wav"
            let fileName = "\(timestamp).wav"
            
            FileManager.downloadAndSaveAudio(from: url, fileName: fileName) { result in
                switch result {
                case .success(let fileURL):
                    self.downloadedFileURLs.append(fileURL)
                case .failure(let error):
                    print("Failed to download \(fileName): \(error)")
                }
                self.group.leave()
            }
        }

        group.notify(queue: .main) {
            // Step 2: Merge WAV files
            
        }
    }

    func mergeWavFiles(fileURLs: [URL], outputURL: URL, completion: @escaping (Bool) -> Void) {
        let composition = AVMutableComposition()
        let track = composition.addMutableTrack(
            withMediaType: .audio,
            preferredTrackID: kCMPersistentTrackID_Invalid
        )

        var insertTime = CMTime.zero

        for fileURL in fileURLs.sorted(by: { $0.lastPathComponent < $1.lastPathComponent }) {
            let asset = AVURLAsset(url: fileURL)
            if let assetTrack = asset.tracks(withMediaType: .audio).first {
                do {
                    try track?.insertTimeRange(
                        CMTimeRangeMake(start: .zero, duration: asset.duration),
                        of: assetTrack,
                        at: insertTime
                    )
                    insertTime = CMTimeAdd(insertTime, asset.duration)
                } catch {
                    print("Failed to insert: \(fileURL) — \(error)")
                }
            }
        }

        // Export merged audio
        let exporter = AVAssetExportSession(asset: composition, presetName: AVAssetExportPresetAppleM4A)
        exporter?.outputURL = outputURL
        exporter?.outputFileType = .m4a
        exporter?.exportAsynchronously {
            if exporter?.status == .completed {
                completion(true)
            } else {
                print("Export failed: \(exporter?.error?.localizedDescription ?? "Unknown error")")
                completion(false)
            }
        }
    }
}
