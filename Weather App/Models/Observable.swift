//
//  Observable.swift
//  Weather App
//
//  Created by Aleksandr Svetilov on 13.09.2020.
//  Copyright © 2020 Aleksandr Svetilov. All rights reserved.
//

final class Observable<T> {
    typealias Listener = (T) -> Void
    var listener: Listener?
    var value: T? {
        didSet {
            if let value = value { listener?(value) }
        }
    }
    
    init(_ value: T? = nil) {
        self.value = value
    }
    
    func bind(listener: Listener?) {
        self.listener = listener
        if let value = value { listener?(value) }
    }
}
