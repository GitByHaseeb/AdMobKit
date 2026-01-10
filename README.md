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

  private var adReadyCompletion: ((UIViewController) -> Void)?

    func preLoadAd(completion: @escaping (UIViewController) -> Void) {
        adReadyCompletion = completion
        AdMobManager.shared.preLoadAd(withUnitID: "ca-app-pub-3940256099942544/3986624511", delegate: self)
    }

    func adLoaderDidReceive(ad: NativeAd) {
        print("Native ad received")
        DispatchQueue.main.async {
            let vc = DisplayNativeAd()
            self.adReadyCompletion?(vc)
        }
    }
    func didFailToReceiveAdWithError(error: Error) {
        print("Native ad failed: \(error.localizedDescription)")
    }


IN ViewController in your class


 private func displayNativeAd(_ ad: NativeAd) {
        adContainer.subviews.forEach { $0.removeFromSuperview() }
        var lastView: UIView? = nil
        
        if let headline = ad.headline {
            let headlineLabel = UILabel()
            headlineLabel.text = headline
            headlineLabel.font = .boldSystemFont(ofSize: 16)
            headlineLabel.translatesAutoresizingMaskIntoConstraints = false
            adContainer.addSubview(headlineLabel)
            NSLayoutConstraint.activate([
                headlineLabel.topAnchor.constraint(equalTo: adContainer.topAnchor, constant: 10),
                headlineLabel.leadingAnchor.constraint(equalTo: adContainer.leadingAnchor, constant: 10),
                headlineLabel.trailingAnchor.constraint(equalTo: adContainer.trailingAnchor, constant: -10)
            ])
            lastView = headlineLabel
        }
        
        if let icon = ad.icon?.image {
            let iconView = UIImageView(image: icon)
            iconView.translatesAutoresizingMaskIntoConstraints = false
            adContainer.addSubview(iconView)
            NSLayoutConstraint.activate([
                iconView.topAnchor.constraint(equalTo: lastView?.bottomAnchor ?? adContainer.topAnchor, constant: 8),
                iconView.leadingAnchor.constraint(equalTo: adContainer.leadingAnchor, constant: 10),
                iconView.widthAnchor.constraint(equalToConstant: 50),
                iconView.heightAnchor.constraint(equalToConstant: 50)
            ])
            lastView = iconView
        }
        
        if let body = ad.body {
            let bodyLabel = UILabel()
            bodyLabel.text = body
            bodyLabel.numberOfLines = 0
            bodyLabel.font = .systemFont(ofSize: 14)
            bodyLabel.translatesAutoresizingMaskIntoConstraints = false
            adContainer.addSubview(bodyLabel)
            NSLayoutConstraint.activate([
                bodyLabel.topAnchor.constraint(equalTo: lastView?.bottomAnchor ?? adContainer.topAnchor, constant: 8),
                bodyLabel.leadingAnchor.constraint(equalTo: adContainer.leadingAnchor, constant: 10),
                bodyLabel.trailingAnchor.constraint(equalTo: adContainer.trailingAnchor, constant: -10)
            ])
            lastView = bodyLabel
        }
        
        if let callToAction = ad.callToAction {
            let button = UIButton(type: .system)
            button.setTitle(callToAction, for: .normal)
            button.backgroundColor = .systemBlue
            button.setTitleColor(.white, for: .normal)
            button.layer.cornerRadius = 5
            button.translatesAutoresizingMaskIntoConstraints = false
            adContainer.addSubview(button)
            NSLayoutConstraint.activate([
                button.topAnchor.constraint(equalTo: lastView?.bottomAnchor ?? adContainer.topAnchor, constant: 10),
                button.centerXAnchor.constraint(equalTo: adContainer.centerXAnchor),
                button.widthAnchor.constraint(equalToConstant: 120),
                button.heightAnchor.constraint(equalToConstant: 40)
            ])
        }
        
        // Optional: MediaView
        let mediaView = MediaView()
        mediaView.mediaContent = ad.mediaContent
        mediaView.translatesAutoresizingMaskIntoConstraints = false
        adContainer.addSubview(mediaView)
        NSLayoutConstraint.activate([
            mediaView.topAnchor.constraint(equalTo: lastView?.bottomAnchor ?? adContainer.topAnchor, constant: 10),
            mediaView.leadingAnchor.constraint(equalTo: adContainer.leadingAnchor),
            mediaView.trailingAnchor.constraint(equalTo: adContainer.trailingAnchor),
            mediaView.heightAnchor.constraint(equalToConstant: 120)
        ])
    }

extension DisplayNativeAd: NativeAdManagerDelegate {
    func adLoaderDidReceive(ad: NativeAd) {
        DispatchQueue.main.async { [weak self] in
            self?.displayNativeAd(ad)
        }
    }
}

````


**for swiftUI**































