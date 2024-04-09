//
//  NotificationObserver.swift
//  Noti
//
//  Created by Wang Wei on 2018/5/11.
//

import Foundation

public final class NotificationObserver {
    let token: NSObjectProtocol
    let center: NotificationCenter
    
    init(token: NSObjectProtocol, in center: NotificationCenter) {
        self.token = token
        self.center = center
    }
    
    deinit {
        center.removeObserver(token)
    }
}
