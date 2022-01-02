//
// Created by Lucas Desouza on 12/22/21.
//

import Foundation
import StoreKit

func requestReview(in scene: UIWindowScene) {
    let (version, build) = getVersion()
    var (count, lastVersionPromptedForReview) = getSessionCount()
    count += 1
    setSessionCount(count)
    let currentVersion = "\(version) (\(build))"
    if count >= 4 && currentVersion != lastVersionPromptedForReview {
        SKStoreReviewController.requestReview(in: scene)
        setLastVersionPrompted(currentVersion)
        setSessionCount(0)
    }
}

func getVersion() -> (version: String, build: String) {
    let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
    let build = Bundle.main.object(forInfoDictionaryKey: kCFBundleVersionKey as String) as! String
    return (version, build)
}

func getSessionCount() -> (count: Int, version: String) {
    let version = UserDefaults.standard.string(forKey: "lastVersionPromptedForReviewKey")
    let count = UserDefaults.standard.integer(forKey: "processCompletedCountKey")
    return (count, version ?? "")
}

func setSessionCount(_ count: Int) {
    UserDefaults.standard.set(count, forKey: "processCompletedCountKey")
}

func setLastVersionPrompted(_ version: String) {
    UserDefaults.standard.set(version, forKey: "lastVersionPromptedForReviewKey")
}