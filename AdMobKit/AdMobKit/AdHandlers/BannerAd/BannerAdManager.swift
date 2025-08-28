//
//  BannerAdHandler.swift
//  AdMobKit
//
//  Created by Abdul Haseeb on 18/08/2025.
//

import UIKit
import GoogleMobileAds

public final class BannerAdManager: NSObject {
    
    var BannerView: BannerView?
    weak var delegate: BannerAdManagerDelegate?
    //Enum To Assign Custom Banner Sizes and Content
    public enum BannerAdSizes {
        case defaultSizeBanner
        case mediumSizeBanner
        case largeSizeBanner
        case LeaderboardSizeBanner
        case fullSizeBanner
        case customSize(CGSize)
        var adSize: AdSize {
            switch self {
            case .defaultSizeBanner:
                return AdSizeBanner
            case .mediumSizeBanner:
                return AdSizeMediumRectangle
            case .largeSizeBanner:
                return AdSizeLargeBanner
            case .LeaderboardSizeBanner:
                return AdSizeLeaderboard
            case .fullSizeBanner:
                return AdSizeFullBanner
            case .customSize(let size):
                return AdSize(size: size, flags: 0) // flag for special banner size like smartBanner
            }
        }
    }
    public enum BannerContent {
        case fullScreenCover
        case midScreen
    }
}
extension BannerAdManager: BannerAdProtocol {
    //Load Function
    public func loadAd(in controller: UIViewController, view: UIView, adUnitID: String, adSize: BannerAdSizes, adContent: BannerContent) {
        BannerView?.removeFromSuperview()
        BannerView?.delegate = self
        let banner = GoogleMobileAds.BannerView(adSize: adSize.adSize)
        banner.adUnitID = adUnitID
        banner.rootViewController = controller
        banner.load(Request())
        banner.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(banner)
        
        switch adContent {
        case .fullScreenCover:
            NSLayoutConstraint.activate([
                   banner.topAnchor.constraint(equalTo: view.topAnchor),
                   banner.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                   banner.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                   banner.bottomAnchor.constraint(equalTo: view.bottomAnchor),
               ])
        case .midScreen:
            NSLayoutConstraint.activate([
                   banner.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                   banner.centerYAnchor.constraint(equalTo: view.centerYAnchor)
               ])
        }
        self.BannerView = banner
    }
}
extension BannerAdManager: BannerViewDelegate {
    //MARK: - Delegates Methods
    public func bannerViewDidReceiveAd(_ bannerView: BannerView) {
        delegate?.bannerViewDidReceiveAd(ad: bannerView)
    }
    public func bannerViewDidRecordClick(_ bannerView: BannerView) {
        delegate?.bannerViewDidRecordClick(ad: bannerView)
    }
    public func bannerViewDidDismissScreen(_ bannerView: BannerView) {
        delegate?.bannerViewDidDismissScreen(ad: bannerView)
    }
    public func bannerViewWillDismissScreen(_ bannerView: BannerView) {
        delegate?.bannerViewWillDismissScreen(ad: bannerView)
    }
    public func bannerViewWillPresentScreen(_ bannerView: BannerView) {
        delegate?.bannerViewWillPresentScreen(ad: bannerView)
    }
    public func bannerViewDidRecordImpression(_ bannerView: BannerView) {
        delegate?.bannerViewDidRecordImpression(ad: bannerView)
    }
    public func bannerView(_ bannerView: BannerView, didFailToReceiveAdWithError error: any Error) {
        delegate?.bannerViewDidFailToReceiveAdWithError(error: error)
    }
}
