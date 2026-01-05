//
//  AppOpenAdManagerDelegate.swift
//  AdMobKit
//
//  Created by Abdul Haseeb on 20/08/2025.
//

import UIKit
import GoogleMobileAds

protocol AppOpenAdProtocol {
    func loadAd(adUnitID: String, completion: ((Result<Bool, Error>) -> Void)?)
    func showAd(on controller: UIViewController)
}
public protocol AppOpenAdManagerDelegate: AnyObject {
    func adDidDismissFullScreenContent(ad: FullScreenPresentingAd)
    func adDidRecordImpression(ad: FullScreenPresentingAd)
    func adDidRecordClick(ad: FullScreenPresentingAd)
    func adWillPresentFullScreenContent(ad: FullScreenPresentingAd)
    func adWillDismissFullScreenContent(ad: FullScreenPresentingAd)
    func didFailToPresentFullScreenContentWithError(error: Error)
}
public extension AppOpenAdManagerDelegate {
    func adDidDismissFullScreenContent(ad: FullScreenPresentingAd) {}
    func adDidRecordImpression(ad: FullScreenPresentingAd) {}
    func adDidRecordClick(ad: FullScreenPresentingAd) {}
    func adWillPresentFullScreenContent(ad: FullScreenPresentingAd) {}
    func adWillDismissFullScreenContent(ad: FullScreenPresentingAd) {}
    func didFailToPresentFullScreenContentWithError(error: Error) {}
}
