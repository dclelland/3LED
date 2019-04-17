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
            refresh()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refresh()
    }
    
    final func refresh() {
        guard let input = input, isViewLoaded else {
            return
        }
        
        self.state = .loading
        
        request(input).done { [weak self] output in
            self?.state = .success(output)
        }.catch { [weak self] error in
            self?.state = .failure(error)
        }
    }
    
    override func refreshView(_ state: AsynchronousState<Output>) {
        if case .failure(let error) = state {
            NSAlert(error: error).runModal()
        }
    }
    
    open func request(_ input: Input) -> Promise<Output> {
        fatalError("Override `request(_:)` in subclasses")
    }
    
}
