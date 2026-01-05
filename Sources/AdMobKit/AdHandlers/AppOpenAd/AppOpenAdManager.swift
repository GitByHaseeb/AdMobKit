//
//  AppOpenAdHandler.swift
//  AdMobKit
//
//  Created by Abdul Haseeb on 18/08/2025.
//
import UIKit
import GoogleMobileAds

public final class AppOpenAdManager: NSObject {
    
    private var presentableAppOpenAd: AppOpenAd?
    weak var delegate: AppOpenAdManagerDelegate?
}
extension AppOpenAdManager: AppOpenAdProtocol {
    public func loadAd(adUnitID: String, completion: ((Result<Bool, Error>) -> Void)? = nil) {
        let request = Request()
        let id = adUnitID
        AppOpenAd.load(with: id, request: request, completionHandler: { ad , error in
            if let error = error {
                completion?(.failure(error)) 
                return
            }
            self.presentableAppOpenAd = ad
            self.presentableAppOpenAd?.fullScreenContentDelegate = self
            completion?(.success(true))
        })
    }
    //Display Function
    public func showAd(on controller: UIViewController) {
        if let ad = presentableAppOpenAd {
            ad.present(from: controller)
        }
    }
}
extension AppOpenAdManager: FullScreenContentDelegate {
    //MARK: - Delegates Methods
    public func adDidDismissFullScreenContent(_ ad: any FullScreenPresentingAd) {
        self.presentableAppOpenAd = nil
        delegate?.adDidDismissFullScreenContent(ad: ad)
    }
    public func ad(_ ad: any FullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: any Error) {
        delegate?.didFailToPresentFullScreenContentWithError(error: error)
    }
    public func adDidRecordImpression(_ ad: any FullScreenPresentingAd) {
        delegate?.adDidRecordImpression(ad: ad)
    }
    public func adDidRecordClick(_ ad: any FullScreenPresentingAd) {
        delegate?.adDidRecordClick(ad: ad)
    }
    public func adWillPresentFullScreenContent(_ ad: any FullScreenPresentingAd) {
        delegate?.adWillPresentFullScreenContent(ad: ad)
    }
    public func adWillDismissFullScreenContent(_ ad: any FullScreenPresentingAd) {
        delegate?.adWillDismissFullScreenContent(ad: ad)
    }
}
