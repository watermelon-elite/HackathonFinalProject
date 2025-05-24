//
//  CODE.swift
//  HackathonFinalProject
//
//  Created by Thurston Reese on 5/24/25.
//


/*
 LOUDNESS CALCULATOR
 import AVFoundation

 func analyzeAudioLoudness(fileURL: URL) {
     let asset = AVAsset(url: fileURL)
     guard let audioTrack = asset.tracks(withMediaType: .audio).first else {
         print("No audio track found.")
         return
     }

     let readerSettings: [String: Any] = [
         AVFormatIDKey: kAudioFormatLinearPCM,
         AVLinearPCMIsBigEndianKey: false,
         AVLinearPCMIsFloatKey: true,
         AVLinearPCMBitDepthKey: 32
     ]

     do {
         let reader = try AVAssetReader(asset: asset)
         let output = AVAssetReaderTrackOutput(track: audioTrack, outputSettings: readerSettings)
         reader.add(output)
         reader.startReading()

         var peak: Float = 0
         var sumSquares: Float = 0
         var sampleCount: Int = 0

         while let buffer = output.copyNextSampleBuffer(),
               let blockBuffer = CMSampleBufferGetDataBuffer(buffer) {

             let length = CMBlockBufferGetDataLength(blockBuffer)
             var data = [Float](repeating: 0, count: length / MemoryLayout<Float>.size)
             CMBlockBufferCopyDataBytes(blockBuffer, atOffset: 0, dataLength: length, destination: &data)

             for sample in data {
                 let absSample = abs(sample)
                 peak = max(peak, absSample)
                 sumSquares += sample * sample
                 sampleCount += 1
             }
         }

         let rms = sqrt(sumSquares / Float(sampleCount))
         print("🔊 Peak: \(peak), RMS: \(rms)")

     } catch {
         print("Error analyzing audio: \(error)")
     }
 }
 
 
 
 
 
 
 */
