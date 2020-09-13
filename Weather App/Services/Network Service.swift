//
//  Network Service.swift
//  Weather App
//
//  Created by Aleksandr Svetilov on 13.09.2020.
//  Copyright © 2020 Aleksandr Svetilov. All rights reserved.
//
import Foundation

protocol NetworkService {
    func getDataFromUrl(_ url: URL, completion: @escaping (Data) -> Void)
}

class DefaultNetworkService: NetworkService {
    
    func getDataFromUrl(_ url: URL, completion: @escaping (Data) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data {
                completion(data)
            }
        }
        task.resume()
    }
}
