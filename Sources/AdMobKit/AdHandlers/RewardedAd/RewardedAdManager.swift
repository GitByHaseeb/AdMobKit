//
//  RewardedAdHandler.swift
//  AdMobKit
//
//  Created by Abdul Haseeb on 18/08/2025.
//

import UIKit
import GoogleMobileAds

final class RewardedAdManager: NSObject {
    
    var presentableRewardedAd: RewardedAd?
    weak var delegate: RewardedAdManagerDelegate?
    var onUserEarnedReward: ((AdReward) -> Void)?
}
extension RewardedAdManager: RewardedAdProtocol {
    //Load Function
    public func loadAd(adUnitID: String, completion: ((Result<Bool, Error>) -> Void)? = nil) {
         let reqest = Request()
         let id = adUnitID
         RewardedAd.load(with: id, request: reqest) { ad , error in
             if let error = error {
                 completion?(.failure(error))
                 return
             }
             self.presentableRewardedAd?.fullScreenContentDelegate = self
             self.presentableRewardedAd = ad
             completion?(.success(true))
         }
     }
    //Display Function
     public func showAd(in controller: UIViewController, onEarnedReward: ((AdReward) -> Void)? = nil) {
         if let ad = presentableRewardedAd {
             ad.present(from: controller, userDidEarnRewardHandler: { [weak self] in
                 guard let self = self else { return }
                 let reward = ad.adReward
                 self.onUserEarnedReward?(reward)
             })
         }
     }
}
extension RewardedAdManager: FullScreenContentDelegate {
    //MARK: - Delegate Methods
    func adDidRecordClick(_ ad: any FullScreenPresentingAd) {
        delegate?.adDidRecordClick(ad: ad)
    }
    func adDidRecordImpression(_ ad: any FullScreenPresentingAd) {
        delegate?.adDidRecordImpression(ad: ad)
    }
    func adWillPresentFullScreenContent(_ ad: any FullScreenPresentingAd) {
        delegate?.adWillPresentFullScreenContent(ad: ad)
    }
    func adWillDismissFullScreenContent(_ ad: any FullScreenPresentingAd) {
        delegate?.adWillDismissFullScreenContent(ad: ad)
    }
    func adDidDismissFullScreenContent(_ ad: any FullScreenPresentingAd) {
        delegate?.adDidDismissFullScreenContent(ad: ad)
    }
    func ad(_ ad: any FullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: any Error) {
        delegate?.didFailToPresentFullScreenContentWithError(error: error)
    }
}

