//
// Created by Lucas Desouza on 12/22/21.
//

import Foundation
import StoreKit

func requestReview(in scene: UIWindowScene) {
    var count = UserDefaults.standard.integer(forKey: "processCompletedCountKey")
    count += 1
    UserDefaults.standard.set(count, forKey: "processCompletedCountKey")
    let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
    let build = Bundle.main.object(forInfoDictionaryKey: kCFBundleVersionKey as String) as! String
    let currentVersion = "\(version) (\(build))"
    let lastVersionPromptedForReview = UserDefaults.standard.string(forKey: "lastVersionPromptedForReviewKey")
    if count >= 4 && currentVersion != lastVersionPromptedForReview {
        SKStoreReviewController.requestReview(in: scene)
        UserDefaults.standard.set(currentVersion, forKey: "lastVersionPromptedForReviewKey")
    }
}
