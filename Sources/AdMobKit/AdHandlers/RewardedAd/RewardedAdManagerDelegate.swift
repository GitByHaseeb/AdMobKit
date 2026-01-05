//
//  RewardedAdManagerDelegate.swift
//  AdMobKit
//
//  Created by Abdul Haseeb on 20/08/2025.
//

import UIKit
import GoogleMobileAds

protocol RewardedAdProtocol {
    func loadAd(adUnitID: String, completion: ((Result<Bool, Error>) -> Void)?)
    func showAd(in controller: UIViewController, onEarnedReward: ((AdReward) -> Void)?)
}
public protocol RewardedAdManagerDelegate: AnyObject {
    func adDidRecordClick(ad: FullScreenPresentingAd)
    func adDidRecordImpression(ad: FullScreenPresentingAd)
    func adWillPresentFullScreenContent(ad: FullScreenPresentingAd)
    func adWillDismissFullScreenContent(ad: FullScreenPresentingAd)
    func adDidDismissFullScreenContent(ad: FullScreenPresentingAd)
    func didFailToPresentFullScreenContentWithError(error: Error)
}
public extension RewardedAdManagerDelegate {
    func adDidRecordClick(ad: FullScreenPresentingAd) {}
    func adDidRecordImpression(ad: FullScreenPresentingAd) {}
    func adWillPresentFullScreenContent(ad: FullScreenPresentingAd) {}
    func adWillDismissFullScreenContent(ad: FullScreenPresentingAd) {}
    func adDidDismissFullScreenContent(ad: FullScreenPresentingAd) {}
    func didFailToPresentFullScreenContentWithError(error: Error) {}
}


