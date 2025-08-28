//
//  NativeAdManagerDelegate.swift
//  AdMobKit
//
//  Created by Abdul Haseeb on 20/08/2025.
//

import UIKit
import GoogleMobileAds

protocol NativeAdProtocol {
    func loadAd(in controller: UIViewController, adUnitID: String)
    func preloadAd(withUnitID: String)
    func clearPreloadedAd()
}
public protocol NativeAdManagerDelegate: AnyObject {
    func adLoaderDidReceive(ad: NativeAd)
    func adLoaderDidFinishLoading(ad: AdLoader)
    func nativeAdDidRecordClick(ad: NativeAd)
    func nativeAdDidRecordImpression(ad: NativeAd)
    func nativeAdDidDismissScreen(ad: NativeAd)
    func nativeAdDidRecordSwipeGestureClick(ad: NativeAd)
    func nativeAdWillDismissScreen(ad: NativeAd)
    func nativeAdWillPresentScreen(ad: NativeAd)
    func nativeAdIsMuted(ad: NativeAd)
    func didFailToReceiveAdWithError(error: Error)
}
public extension NativeAdManagerDelegate {
    func adLoaderDidReceive(ad: NativeAd) {}
    func adLoaderDidFinishLoading(ad: AdLoader) {}
    func nativeAdDidRecordClick(ad: NativeAd) {}
    func nativeAdDidRecordImpression(ad: NativeAd) {}
    func nativeAdDidDismissScreen(ad: NativeAd) {}
    func nativeAdDidRecordSwipeGestureClick(ad: NativeAd) {}
    func nativeAdWillDismissScreen(ad: NativeAd) {}
    func nativeAdWillPresentScreen(ad: NativeAd) {}
    func nativeAdIsMuted(ad: NativeAd) {}
    func didFailToReceiveAdWithError(error: Error) {}
}
