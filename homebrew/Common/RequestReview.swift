//
// Created by Lucas Desouza on 12/22/21.
//

import Foundation
import StoreKit

func requestReview(in scene: UIWindowScene) {
    var count = UserDefaults.standard.integer(forKey: "processCompletedCountKey")
    count += 1
    UserDefaults.standard.set(count, forKey: "processCompletedCountKey")

    print("Process completed \(count) time(s)")

    let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
    let build = Bundle.main.object(forInfoDictionaryKey: kCFBundleVersionKey as String) as! String
    let currentVersion = "\(version) (\(build))"

    let lastVersionPromptedForReview = UserDefaults.standard.string(forKey: "lastVersionPromptedForReviewKey")
    print("last version reviewed \(lastVersionPromptedForReview)")
    print("current version is \(currentVersion)")
    if count >= 4 && currentVersion != lastVersionPromptedForReview {
        print("Requesting review")
        SKStoreReviewController.requestReview(in: scene)
        UserDefaults.standard.set(currentVersion, forKey: "lastVersionPromptedForReviewKey")
    }
}
