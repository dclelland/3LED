//
//  AsynchronousViewController.swift
//  3LED
//
//  Created by Daniel Clelland on 17/04/19.
//  Copyright © 2019 Protonome. All rights reserved.
//

import AppKit
import PromiseKit

class AsynchronousViewController<Input, Output>: SynchronousViewController<AsynchronousState<Input, Output>>, Asynchronous {
    
    open func request(input: Input) -> Promise<Output> {
        fatalError("Override `request(input:)` in subclasses")
    }
    
}

//class AsynchronousViewController<Value>: SynchronousViewController<AsynchronousState<Value>>, Asynchronous {
//
//    var request: ((AsynchronousState<Value>) -> Promise<Value>)?
//
//    convenience init(value: Value) {
//        self.init(state: .success(value))
//    }
//
//    convenience init(request: @escaping (AsynchronousState<Value>) -> Promise<Value>) {
//        self.init()
//        self.request = request
//        self.refresh()
//    }
//
//    override func refreshView(state: State) {
//        super.refreshView(state: state)
//
//        switch state {
//        case .ready:
//            navigationItem.titleView = nil
//        case .loading:
//            navigationItem.titleView = LoadingView.loadFromNib()
//        case .success:
//            navigationItem.titleView = nil
//        case .failure(let error):
//            navigationItem.titleView = nil
//            presentAlert(error: error)
//        }
//    }
//
//}
