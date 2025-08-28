//
//  InterstitialAdHandler.swift
//  AdMobKit
//
//  Created by Abdul Haseeb on 18/08/2025.
//

import UIKit
import GoogleMobileAds

public final class InterstitialAdManager: NSObject {
    
    var presentableInterstitialAd: InterstitialAd?
    weak var delegate: InterstitialAdManagerDelegate?
}
extension InterstitialAdManager: IntersitialAdProtocol {
    //Load Functions
    public func loadAd(adUnitID: String, completion: ((Result<Bool, Error>) -> Void)? = nil) {
        let request = Request()
        InterstitialAd.load(with: adUnitID, request: request) { ad, error in
            if let error = error {
                completion?(.failure(error))
                return
            }
            self.presentableInterstitialAd = ad
            self.presentableInterstitialAd?.fullScreenContentDelegate = self
            completion?(.success(true))
        }
    }
    //Display Functions
    public func showAd(on controller: UIViewController) {
        if let ad = presentableInterstitialAd {
            ad.present(from: controller)
        }
    }
}
extension InterstitialAdManager: FullScreenContentDelegate {
    //MARK: - Delegates Methods
    public func adDidDismissFullScreenContent(_ ad: any FullScreenPresentingAd) {
        self.presentableInterstitialAd = nil
        delegate?.interstitialDidDismiss(ad: ad)
    }
    public func adDidRecordImpression(_ ad: any FullScreenPresentingAd) {
        delegate?.adDidRecordImpression(ad: ad)
    }
    public func adDidRecordClick(_ ad: any FullScreenPresentingAd) {
        delegate?.adDidRecordClick(ad: ad)
    }
    public func adWillDismissFullScreenContent(_ ad: any FullScreenPresentingAd) {
        delegate?.adWillDismissFullScreenContent(ad: ad)
    }
    public func adWillPresentFullScreenContent(_ ad: any FullScreenPresentingAd) {
        delegate?.adWillPresentFullScreenContent(ad: ad)
    }
    public func ad(_ ad: any FullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: any Error) {
        delegate?.interstitialDidFailToPresent(error: error)
    }
}
