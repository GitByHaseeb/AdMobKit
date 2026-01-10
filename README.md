<img width="1000" height="400" alt="AdMobKit-2" src="https://github.com/user-attachments/assets/9b7291cb-af1a-4d65-b9c7-05e6c2de2f52" />

ADMobKit is a lightweight and easy to use swift package for integrating GoogleAdmob in your iOS apps.

Supports UIKit + SwiftUI and works smoothly in modern Swift projects.



**Ads included:**

BannarAd

NativeAd

InterstitialAd

RewardedAd

AppOpenAd



**Features:**

Simple, minimal API

Swift-first design

UIKit + SwiftUI friendly

Production-ready AdMob setup

Handles lifecycle & delegates cleanly


**Installation:**

Swift Package Manager (SPM)

Add AdMobKit via Xcode:

Open your project

Go to File → Add Packages


Paste the repository URL:
````swift
https://github.com/GitByHaseeb/AdMobKit.git
````

Or add it manually in Package.swift:

````swift
dependencies: [
    .package(url: "https://github.com/GitByHaseeb/AdMobKit.git", from: "1.0.2")
]
````


**To add just import AdMobKit**
````swift
Import AdMobKit
````

**Conform protocols:**

AppOpenAdManagerDelegate
BannerAdManagerDelegate
InterstitialAdManagerDelegate
NativeAdManagerDelegate
RewardedAdManagerDelegate


**RewardedAd:**


Here AdMobKit provides you a clean methods in which you can call your ads by providing few parameters like this:

Below function load ad with your ad id and display ad in your view with just two lines of code.

````swift

    func loadAndShowAd(from controller: UIViewController) {
        AdMobManager.shared.loadRewardedAd(adUnitID: "Adid") {_ in 
            AdMobManager.shared.showRewardedAd(in: controller, delegate: self)
        }
    }

````

else we can add other delegate methods if we want all are optionals

````swift

    func rewardedAdDidRewardUser() {
        print("User rewarded")
    }
    func rewardedAdDidDismiss() {
        print("Rewarded ad dismissed")
    }
    func rewardedAdDidFailToPresent(error: Error) {
        print("Rewarded ad failed: \(error.localizedDescription)")
    }

````

**BannerAd**

Conform BannerAdManagerDelegate and you can call your banner ad in singeton class where you need a view type of UIView in which you can load your ad and pass it to viewcontroller/View

````Swift

    private var bannerView: UIView?

    func loadBannerAd(in controller: UIViewController, container: UIView) {
        bannerView?.removeFromSuperview()
        AdMobManager.shared.loadBannerAd(
            in: controller,
            view: container,
            adUnitID: "ca-app-pub-3940256099942544/2934735716",
            adSize: .defaultSizeBanner,
            adContent: .midScreen,
            completion: {
                print("Banner ad loaded")
            },
            delegate: self
        )
        // Keep reference to banner view if needed
        bannerView = container
    }

    func bannerAdDidRecordClick(ad: UIView) {
        print("Banner clicked")
    }

    func bannerAdDidFailToLoad(error: Error) {
        print("Banner failed to load: \(error.localizedDescription)")
    }

````

**InterstitialAd**

Call for Interstitial by conforming InterstitialAdManagerDelegate

````swift

    func loadAndShowAd(from controller: UIViewController) {
        AdMobManager.shared.loadInterstitialAd(adUnitID: "Adid") { _ in
            AdMobManager.shared.showInterstitialAd(in: controller, delegate: self)
        }
    }

    func interstitialAdDidDismiss() {
        print("Interstitial ad dismissed")
    }

    func interstitialAdDidFailToPresent(error: Error) {
        print("Interstitial ad failed: \(error.localizedDescription)")
    }

````


**AppOpenAd**

Conforming AppOpenAdManagerDelegate and simply call it

````swift

    func loadAndShowAd(from controller: UIViewController) {
        AdMobManager.shared.loadAppOpenAd(adUnitID: "ca-app-pub-3940256099942544/3419835294") { _ in
            AdMobManager.shared.showAppOpenAd(in: controller, delegate: self)
        }
    }

    func adDidDismissFullScreenContent(ad: FullScreenPresentingAd) {
        print("App Open ad dismissed")
    }
    func didFailToPresentFullScreenContentWithError(error: Error) {
        print("App Open ad failed: \(error.localizedDescription)")
    }

````


**NativeAd**

call for NativeAdManagerDelegate

````swift





````































