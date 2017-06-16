//
//  SafeDispatch.swift
//  SafeDispatch
//
//  Created by PF on 17/2/13.
//  Copyright © 2017年 PF. All rights reserved.
//

import UIKit

final public class SafeDispatch {
    
    private let mainQueueKey = DispatchSpecificKey<Int>()
    private let mainQueueValue = Int(1)
    
    private static let sharedSafeDispatch = SafeDispatch()
    
    private init() {
        
        DispatchQueue.main.setSpecific(key: mainQueueKey, value: mainQueueValue)
    }
    
    public class func async(onQueue queue: DispatchQueue = DispatchQueue.main, forWork block: @escaping () -> ()) {
        if queue == DispatchQueue.main {
            if DispatchQueue.getSpecific(key: sharedSafeDispatch.mainQueueKey) == sharedSafeDispatch.mainQueueValue {
                block()
            } else {
                DispatchQueue.main.async {
                    block()
                }
            }
        } else {
            queue.async {
                block()
            }
        }
    }
}

extension DispatchQueue {
    func safeAsync(_ block: @escaping ()->()) {
        if self == DispatchQueue.main && Thread.isMainThread {
            block()
        } else {
            async { block() }
        }
    }
}
