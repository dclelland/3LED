//
//  AsynchronousViewController.swift
//  3LED
//
//  Created by Daniel Clelland on 17/04/19.
//  Copyright © 2019 Protonome. All rights reserved.
//

import AppKit
import PromiseKit

class AsynchronousViewController<Input, Output>: SynchronousViewController<AsynchronousState<Output>>, Asynchronous {
    
    var input: Input? = nil {
        didSet {
            refreshState()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshState()
    }
    
    override func refreshView(_ state: AsynchronousState<Output>) {
        if case .failure(let error) = state {
            NSAlert(error: error).runModal()
            view.window?.close()
        }
    }
    
    open func requestState(_ input: Input) -> Promise<Output> {
        return Promise(error: PMKError.cancelled)
    }
    
}
