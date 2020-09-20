//
//  Network Service.swift
//  Weather App
//
//  Created by Aleksandr Svetilov on 13.09.2020.
//  Copyright © 2020 Aleksandr Svetilov. All rights reserved.
//
import Foundation

protocol NetworkService {
    func getDataFromUrl(_ url: URL, completion: @escaping (Data?, Error?) -> Void)
}

class DefaultNetworkService: NetworkService {
    
    func getDataFromUrl(_ url: URL, completion: @escaping (Data?, Error?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data {
                completion(data, nil)
            }
            if let error = error {
                completion(nil, error)
            }
        }
        task.resume()
    }
}
