//
//  BannerAdManagerDelegate.swift
//  AdMobKit
//
//  Created by Abdul Haseeb on 20/08/2025.
//

import GoogleMobileAds

protocol BannerAdProtocol {
    func loadAd(in controller: UIViewController, view: UIView, adUnitID: String, adSize: BannerAdManager.BannerAdSizes, adContent: BannerAdManager.BannerContent)
}
public protocol BannerAdManagerDelegate: AnyObject {
    func bannerViewDidReceiveAd(ad: BannerView)
    func bannerViewDidRecordClick(ad: BannerView)
    func bannerViewDidDismissScreen(ad: BannerView)
    func bannerViewWillDismissScreen(ad: BannerView)
    func bannerViewWillPresentScreen(ad: BannerView)
    func bannerViewDidRecordImpression(ad: BannerView)
    func bannerViewDidFailToReceiveAdWithError(error: Error)
}
public extension BannerAdManagerDelegate {
    func bannerViewDidReceiveAd(ad: BannerView) {}
    func bannerViewDidRecordClick(ad: BannerView) {}
    func bannerViewDidDismissScreen(ad: BannerView) {}
    func bannerViewWillDismissScreen(ad: BannerView) {}
    func bannerViewWillPresentScreen(ad: BannerView) {}
    func bannerViewDidRecordImpression(ad: BannerView) {}
    func bannerViewDidFailToReceiveAdWithError(error: Error) {}
}
