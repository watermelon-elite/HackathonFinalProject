//
//  AudioExtension.swift
//  HackathonProject
//
//  Created by Thurston Reese on 5/24/25.
//
import Foundation
import SwiftUI
extension FileManager {
    static func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .downloadsDirectory,
                                             in: .userDomainMask)
        return paths[0]
    }
    
    static func downloadAndSaveAudio(from urlString: String, fileName: String, completion: @escaping (Result<URL, Error>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 1)))
            return
        }
        
        let session = URLSession.shared
        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No data received", code: 2)))
                return
            }
            
            do {
                // Get documents directory
                let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
                let fileURL = documentsURL.appendingPathComponent(fileName)
                
                // Write data to file
                try data.write(to: fileURL)
                
                print("Audio saved to: \(fileURL)")
                completion(.success(fileURL))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    
}


