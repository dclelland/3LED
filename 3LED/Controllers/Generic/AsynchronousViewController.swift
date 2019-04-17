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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshState()
    }
    
    override func refreshView(_ state: AsynchronousState<Input, Output>) {
        if case .failure(let error) = state.result {
            NSAlert(error: error).runModal()
            view.window?.close()
        }
    }
    
    func requestState(_ state: AsynchronousState<Input, Output>) -> Promise<Output> {
        return Promise(error: PMKError.cancelled)
    }
    
}
