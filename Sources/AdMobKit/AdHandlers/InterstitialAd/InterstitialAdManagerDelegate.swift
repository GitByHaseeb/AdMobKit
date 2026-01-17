//
//  InterstitialAdManagerDelegate.swift
//  AdMobKit
//
//  Created by Abdul Haseeb on 20/08/2025.
//

import UIKit
import GoogleMobileAds

protocol IntersitialAdProtocol {
    func loadAd(adUnitID: String, completion: ((Result<Bool, Error>) -> Void)?)
    func showAd(on controller: UIViewController)
}
public protocol InterstitialAdManagerDelegate: AnyObject {
    func interstitialDidDismiss(ad: FullScreenPresentingAd)
    func adDidRecordImpression(ad: FullScreenPresentingAd)
    func adDidRecordClick(ad: FullScreenPresentingAd)
    func adWillDismissFullScreenContent(ad: FullScreenPresentingAd)
    func adWillPresentFullScreenContent(ad: FullScreenPresentingAd)
    func interstitialDidFailToPresent(error: Error)
}
public extension InterstitialAdManagerDelegate {
    func interstitialDidDismiss(ad: FullScreenPresentingAd) {}
    func adDidRecordImpression(ad: FullScreenPresentingAd) {}
    func adDidRecordClick(ad: FullScreenPresentingAd) {}
    func adWillDismissFullScreenContent(ad: FullScreenPresentingAd) {}
    func adWillPresentFullScreenContent(ad: FullScreenPresentingAd) {}
    func interstitialDidFailToPresent(error: Error) {}
}

