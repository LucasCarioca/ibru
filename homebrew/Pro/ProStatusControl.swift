//
//  ProStatusControl.swift
//  iBru
//
//  Created by Lucas Desouza on 9/17/21.
//

import Foundation

class ProStatusControl: ObservableObject {
    @Published var isPro = false
    @Published var expirationDate: Date?
    private var listener: NSObjectProtocol?

    init() {
        isPro = UserDefaults.standard.bool(forKey: "UserIsPro")

        listener = NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "PurchaseNotification"), object: nil, queue: .main) { (notification) in
            if let userInfo = notification.userInfo, let purchasedPro = userInfo["purchasedPro"] as? Bool {
                self.isPro = purchasedPro
                UserDefaults.standard.setValue(purchasedPro, forKey: "UserIsPro")
            }
        }
    }
    
    static func purchased() {
        let nc = NotificationCenter.default
        nc.post(name: NSNotification.Name(rawValue: "PurchaseNotification"), object: nil, userInfo: ["purchasedPro": true])
    }
    
    static func notPurchased() {
        let nc = NotificationCenter.default
        nc.post(name: NSNotification.Name(rawValue: "PurchaseNotification"), object: nil, userInfo: ["purchasedPro": false])
    }
}
