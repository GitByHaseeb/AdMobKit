//
//  NativeAdHandler.swift
//  AdMobKit
//
//  Created by Abdul Haseeb on 18/08/2025.
//

import UIKit
import GoogleMobileAds

public final class NativeAdManager: NSObject {
    
    private var nativeAdLoader: AdLoader?
    public var preLoadedAd: NativeAd?
    weak var delegate: NativeAdManagerDelegate?
}
extension NativeAdManager: NativeAdProtocol {
    //Load native ad
    public func loadAd(in controller: UIViewController, adUnitID: String) {
        let id = adUnitID
        let options = NativeAdViewAdOptions()
        nativeAdLoader = AdLoader(adUnitID: id, rootViewController: controller, adTypes: [.native], options: [options])
        nativeAdLoader?.delegate = self
        nativeAdLoader?.load(Request())
    }
    func preloadAd(withUnitID: String) {
        let options = NativeAdViewAdOptions()
        nativeAdLoader = AdLoader(adUnitID: withUnitID, rootViewController: nil, adTypes: [.native], options: [options])
        nativeAdLoader?.delegate = self
        nativeAdLoader?.load(Request())
    }
    public func clearPreloadedAd() {
         preLoadedAd = nil
     }
}
extension NativeAdManager: NativeAdDelegate, AdLoaderDelegate, NativeAdLoaderDelegate {
    //MARK: - Delegates Methods
    public func adLoader(_ adLoader: AdLoader, didReceive nativeAd: NativeAd) {
        nativeAd.delegate = self
        self.preLoadedAd = nativeAd 
        delegate?.adLoaderDidReceive(ad: nativeAd)
    }
    public func adLoaderDidFinishLoading(_ adLoader: AdLoader) {
        delegate?.adLoaderDidFinishLoading(ad: adLoader)
    }
    public func nativeAdDidRecordClick(_ nativeAd: NativeAd) {
        delegate?.nativeAdDidRecordClick(ad: nativeAd)
    }
    public func nativeAdDidRecordImpression(_ nativeAd: NativeAd) {
        delegate?.nativeAdDidRecordImpression(ad: nativeAd)
    }
    public func nativeAdDidDismissScreen(_ nativeAd: NativeAd) {
        delegate?.nativeAdDidDismissScreen(ad: nativeAd)
    }
    public func nativeAdDidRecordSwipeGestureClick(_ nativeAd: NativeAd) {
        delegate?.nativeAdDidRecordSwipeGestureClick(ad:  nativeAd)
    }
    public func nativeAdWillDismissScreen(_ nativeAd: NativeAd) {
        delegate?.nativeAdWillDismissScreen(ad: nativeAd)
    }
    public func nativeAdWillPresentScreen(_ nativeAd: NativeAd) {
        delegate?.nativeAdWillPresentScreen(ad: nativeAd)
    }
    public func nativeAdIsMuted(_ nativeAd: NativeAd) {
        delegate?.nativeAdIsMuted(ad: nativeAd)
    }
    public func adLoader(_ adLoader: AdLoader, didFailToReceiveAdWithError error: any Error) {
        delegate?.didFailToReceiveAdWithError(error: error)
    }
}
