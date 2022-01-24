//
//  main.swift
//  Synchronization
//
//  Created by Alexander Rubtsov on 22.01.2022.
//

import Foundation

final class EventQueue {
    func synchronize(action: () -> Void) {
        action()
    }
}

// Serial DispatchQueues

let queue = DispatchQueue(label: "my-queue", qos: .userInteractive)

let nslock = NSLock()
let recursiveLock = NSRecursiveLock()

func synchronize(action: () -> Void) {
    recursiveLock.lock()
    action()
    recursiveLock.unlock()
}

/*
func synchronize(action: () -> Void) {
    if nslock.lock(before: Date().addingTimeInterval(5)) {
        action()
        nslock.unlock()
    } else {
        print("Took too long to lock, avoiding deadlock by ignoring the lock")
        action()
    }
}
 */

/*
func synchronize(action: @escaping () -> Void) {
    queue.async {
        action()
    }
}
*/

// Deadlock

func logEntered() {
    synchronize {
        print("Entered!")
    }
}

func logExited() {
    synchronize {
        print("Exited!")
    }
}

func logLifecycle() {
    synchronize {
        logEntered()
        print("Running")
        logExited()
    }
}

logLifecycle()
