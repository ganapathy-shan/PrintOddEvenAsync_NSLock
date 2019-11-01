//
//  PrintOddEvenAsync.swift
//  PrintOddEven_NSLock
//
//  Created by Shanmuganathan on 01/11/19.
//  Copyright © 2019 Shanmuganathan. All rights reserved.
//

import UIKit

class PrintOddEvenAsync: NSObject
{
    
    let oddLock = NSLock()
    let evenLock = NSLock()
    
    let globalQueue = DispatchQueue(label: "Global", qos: .background, attributes: .concurrent, autoreleaseFrequency: .inherit, target: .none)
    
    func createOddEvenAsyncTasks()
    {
        evenLock.lock()
        globalQueue.async {
            self.printEven()
        }
        globalQueue.async {
            self.printOdd()
        }
    }
    
    func printEven()
    {
        for i in 1...100
        {
            if(i % 2 == 0)
            {
                evenLock.lock()
                print(i)
                oddLock.unlock()
            }
        }
    }
    
    func printOdd()
    {
        for i in 1...100
        {
            if(i % 2 == 1)
            {
                oddLock.lock()
                print(i)
                evenLock.unlock()
            }
        }
    }
}
