<img width="1000" height="400" alt="AdMobKit-2" src="https://github.com/user-attachments/assets/9b7291cb-af1a-4d65-b9c7-05e6c2de2f52" />

ADMobKit is a lightweight and easy to use swift package for integrating GoogleAdmob in your iOS apps.

Supports UIKit + SwiftUI and works smoothly in modern Swift projects.



**Ads included:**

```swift

BannarAd

NativeAd

InterstitialAd

RewardedAd

AppOpenAd


```

**Features:**

Simple, minimal API

Swift-first design

UIKit + SwiftUI friendly

Production-ready AdMob setup

Handles lifecycle & delegates cleanly


**Installation:**

# Swift Package Manager (SPM)

## Add AdMobKit via Xcode:

Open your project

Go to File → Add Packages

### Paste the repository URL:
````swift
https://github.com/GitByHaseeb/AdMobKit.git
````

Or add it manually in Package.swift:
````swift
dependencies: [
    .package(url: "https://github.com/GitByHaseeb/AdMobKit.git", from: "1.0.2")
]
````

### Import
````swift
Import AdMobKit
````

**Conform Protocols (As Needed)**

AppOpenAdManagerDelegate
BannerAdManagerDelegate
InterstitialAdManagerDelegate
NativeAdManagerDelegate
RewardedAdManagerDelegate


**Rewarded Ad**

Load and show a rewarded ad with just two calls.

````swift
func loadAndShowAd(from controller: UIViewController) {
    AdMobManager.shared.loadRewardedAd(adUnitID: "AdId") { _ in
        AdMobManager.shared.showRewardedAd(
            in: controller,
            delegate: self
        )
    }
}
````

Optional Delegate Methods
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

**Banner Ad**

Conform to BannerAdManagerDelegate. Provide a UIView container where the banner will be loaded.

````Swift
private var bannerView: UIView?

func loadBannerAd(in controller: UIViewController, container: UIView) {
    bannerView?.removeFromSuperview()

    AdMobManager.shared.loadBannerAd(
        in: controller,
        view: container,
        adUnitID: "AdId",
        adSize: .defaultSizeBanner,
        adContent: .midScreen,
        completion: {
            print("Banner ad loaded")
        },
        delegate: self
    )

    bannerView = container
}

func bannerAdDidRecordClick(ad: UIView) {
    print("Banner clicked")
}

func bannerAdDidFailToLoad(error: Error) {
    print("Banner failed to load: \(error.localizedDescription)")
}
````

**Interstitial Ad**

Conform to InterstitialAdManagerDelegate.

````swift
func loadAndShowAd(from controller: UIViewController) {
    AdMobManager.shared.loadInterstitialAd(adUnitID: "AdId") { _ in
        AdMobManager.shared.showInterstitialAd(
            in: controller,
            delegate: self
        )
    }
}
func interstitialAdDidDismiss() {
    print("Interstitial ad dismissed")
}
func interstitialAdDidFailToPresent(error: Error) {
    print("Interstitial ad failed: \(error.localizedDescription)")
}
````

**App Open Ad**

Conform to AppOpenAdManagerDelegate.

````swift
func loadAndShowAd(from controller: UIViewController) {
    AdMobManager.shared.loadAppOpenAd(
        adUnitID: "AdId"
    ) { _ in
        AdMobManager.shared.showAppOpenAd(
            in: controller,
            delegate: self
        )
    }
}
func adDidDismissFullScreenContent(ad: FullScreenPresentingAd) {
    print("App Open ad dismissed")
}
func didFailToPresentFullScreenContentWithError(error: Error) {
    print("App Open ad failed: \(error.localizedDescription)")
}
````

**Native Ad**

Conform to NativeAdManagerDelegate and preload the ad.

````swift
private var adReadyCompletion: ((UIViewController) -> Void)?

func preLoadAd(completion: @escaping (UIViewController) -> Void) {
    adReadyCompletion = completion
    AdMobManager.shared.preLoadAd(
        withUnitID: "AdId",
        delegate: self
    )
}

Delegate Methods
func adLoaderDidReceive(ad: NativeAd) {
    DispatchQueue.main.async {
        let vc = DisplayNativeAd()
        self.adReadyCompletion?(vc)
    }
}

func didFailToReceiveAdWithError(error: Error) {
    print("Native ad failed: \(error.localizedDescription)")
}
````

**for swiftUI**

AdMobKit works in SwiftUI using UIViewControllerRepresentable.

Load ads using the same APIs

Present from the hosting controller

No separate SwiftUI-only API required


# Interstitial / Rewarded / App Open Ads (SwiftUI)

```swift
Button {
    if let rootVC = UIApplication.shared
        .connectedScenes
        .compactMap({ ($0 as? UIWindowScene)?.keyWindow })
        .first?
        .rootViewController
    {
        AppOpenAdHelper.shared.loadAndShowAd(from: rootVC)
    }
} label: {
    Text("Show App Open Ad")
}

Same approach applies for:
InterstitialAd
RewardedAd
AppOpenAd
Only the load/show method changes.
```

# Banner & Native Ads (SwiftUI)

````swift
@State private var isNativeVisible = false
@State private var isBannerVisible = false

Button("Native Ad") {
    isNativeVisible.toggle()
}

Button("Banner Ad") {
    isBannerVisible.toggle()
}

if isBannerVisible {
    BannerAdView(adUnitID: "AdId")
}

if isNativeVisible {
    NativeAdViewWrapper(adUnitID: "AdId")
}
````

## Banner Ad – SwiftUI Wrapper

````swift
struct BannerAdView: UIViewRepresentable {

    let adUnitID: String

    func makeUIView(context: Context) -> UIView {
        let container = UIView()

        let rootVC = UIApplication.shared
            .connectedScenes
            .compactMap { ($0 as? UIWindowScene)?.keyWindow }
            .first?
            .rootViewController ?? UIViewController()

        AdMobManager.shared.loadBannerAd(
            in: rootVC,
            view: container,
            adUnitID: adUnitID,
            adSize: .largeSizeBanner,
            adContent: .fullScreenCover
        )

        return container
    }

    func updateUIView(_ uiView: UIView, context: Context) {}
}
````

## Native Ad – SwiftUI Wrapper

````swift
struct NativeAdViewWrapper: UIViewRepresentable {

    let adUnitID: String

    func makeUIView(context: Context) -> NativeAdView {
        let adView = NativeAdView()
        adView.frame = CGRect(x: 0, y: 0, width: 300, height: 250)

        let headlineLabel = UILabel()
        headlineLabel.frame = CGRect(x: 10, y: 10, width: 280, height: 20)
        adView.headlineView = headlineLabel
        adView.addSubview(headlineLabel)

        let iconImageView = UIImageView()
        iconImageView.frame = CGRect(x: 10, y: 40, width: 60, height: 60)
        adView.iconView = iconImageView
        adView.addSubview(iconImageView)

        let ctaButton = UIButton(type: .system)
        ctaButton.frame = CGRect(x: 10, y: 110, width: 120, height: 30)
        adView.callToActionView = ctaButton
        adView.addSubview(ctaButton)

        if let rootVC = UIApplication.shared
            .connectedScenes
            .compactMap({ ($0 as? UIWindowScene)?.keyWindow })
            .first?
            .rootViewController
        {
            context.coordinator.adView = adView
            AdMobManager.shared.nativeAdView = adView
            AdMobManager.shared.loadNativeAd(
                in: rootVC,
                adUnitID: adUnitID,
                delegate: context.coordinator
            )
        }

        return adView
    }

    func updateUIView(_ uiView: NativeAdView, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator()
    }

    final class Coordinator: NativeAdManagerDelegate {
        weak var adView: NativeAdView?

        func adLoaderDidReceive(ad: NativeAd) {
            guard let adView else { return }
            (adView.headlineView as? UILabel)?.text = ad.headline
            (adView.iconView as? UIImageView)?.image = ad.icon?.image
            (adView.callToActionView as? UIButton)?.setTitle(ad.callToAction, for: .normal)
            adView.nativeAd = ad
        }

        func didFailToReceiveAdWithError(error: Error) {
            print("Native Ad Error: \(error.localizedDescription)")
        }
    }
}
````



