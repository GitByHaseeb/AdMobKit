import UIKit
import GoogleMobileAds

///A singleton manager for handling Google Mobile Ads SDK operations, including interstitial, app open, rewarded, banner, and native ads.
@MainActor
public final class AdMobManager {
    /// The shared singleton instance of `AdMobManager`.
    public static let shared = AdMobManager()
    private init(){}
    
    private let intersititalHandler = InterstitialAdManager()
    private let appOpenHandler = AppOpenAdManager()
    private let bannerHandler = BannerAdManager()
    private let rewardedHandler = RewardedAdManager()
    private let nativeHandler = NativeAdManager()
    /// The view used to display native ads.
    public var nativeAdView: NativeAdView?
    /// Provides access to the most recently preloaded native ad, if available.
    ///
    /// This property returns a `NativeAd` object that has been preloaded using
    /// the `NativeAdManager`. It allows the app to display the ad at a later
    /// time without waiting for a network request, improving user experience
    /// by showing ads instantly when needed.
    ///
    /// Example usage:
    /// ```swift
    /// if let ad = AdMobManager.shared.preloadedNativeAd {
    ///     displayAd(ad)
    /// }
    /// ```
    public var preloadedNativeAd: NativeAd? {
        return nativeHandler.preLoadedAd
    }
    // MARK: - AdMob Initialization
    /// Initializes the Google Mobile Ads SDK.
    ///
    /// Call this method once, typically at app launch, to configure and start the Google Mobile Ads framework.
    /// This method should be called before attempting to load or display any ads.
    public func initializeAdMob() {
        MobileAds.shared.start(completionHandler: nil)
    }
}
//MARK: - Interstitial Ads
extension AdMobManager {
    /// Loads an interstitial ad with the specified ad unit ID.
    ///
    /// - Parameters:
    ///   - adUnitID: The ad unit ID provided by Google AdMob for the interstitial ad.
    ///   - completion: An optional closure called when the ad is successfully loaded or fails to load.
    public func loadInterstitialAd(adUnitID: String, completion: ((Result<Bool, Error>) -> Void)? = nil) {
        intersititalHandler.loadAd(adUnitID: adUnitID, completion: completion)
    }
    /// Displays a loaded interstitial ad in the specified view controller.
    ///
    /// - Parameters:
    ///   - controller: The `UIViewController` instance used to present the interstitial ad.
    ///   - delegate: An optional delegate conforming to `InterstitialAdManagerDelegate` to handle ad events such as dismissal or errors.
    public func showInterstitialAd(in controller: UIViewController, delegate: InterstitialAdManagerDelegate? = nil) {
        intersititalHandler.delegate = delegate
        intersititalHandler.showAd(on: controller)
    }
}
//MARK: - App Open Ads
extension AdMobManager {
    /// Loads an app open ad with the specified ad unit ID.
    ///
    /// - Parameters:
    ///   - adUnitID: The ad unit ID provided by Google AdMob for the app open ad.
    ///   - completion: An optional closure called when the ad is successfully loaded or fails to load.
    public func loadAppOpenAd(adUnitID: String, completion: ((Result<Bool, Error>) -> Void)? = nil) {
        appOpenHandler.loadAd(adUnitID: adUnitID, completion: completion)
    }
    /// Displays a loaded app open ad in the specified view controller.
    ///
    /// - Parameters:
    ///   - controller: The `UIViewController` instance used to present the app open ad.
    ///   - delegate: An optional delegate conforming to `AppOpenAdManagerDelegate` to handle ad events such as dismissal or errors.
    public func showAppOpenAd(in controller: UIViewController, delegate: AppOpenAdManagerDelegate? = nil) {
        appOpenHandler.delegate = delegate
        appOpenHandler.showAd(on: controller)
    }
}
//MARK: - Rewarded Ads
extension AdMobManager {
    /// Loads a rewarded ad with the specified ad unit ID.
     ///
     /// - Parameters:
     ///   - adUnitID: The ad unit ID provided by Google AdMob for the rewarded ad.
     ///   - completion: An optional closure called when the ad is successfully loaded or fails to load.
    public func loadRewardedAd(adUnitID: String, completion: (((Result<Bool, Error>) -> Void)?)) {
        rewardedHandler.loadAd(adUnitID: adUnitID, completion: completion)
    }
    /// Displays a loaded rewarded ad in the specified view controller.
    ///
    /// - Parameters:
    ///   - controller: The `UIViewController` instance used to present the rewarded ad.
    ///   - delegate: An optional delegate conforming to `RewardedAdManagerDelegate` to handle ad events such as reward delivery, dismissal, or errors.
    public func showRewardedAd(in controller: UIViewController, delegate: RewardedAdManagerDelegate? = nil, onEarnedReward: ((AdReward) -> Void)? = nil) {
        rewardedHandler.delegate = delegate
        rewardedHandler.showAd(in: controller, onEarnedReward: onEarnedReward)
    }
}
//MARK: - Banner Ads
extension AdMobManager {
    /// Loads and displays a banner ad in the specified view controller and view.
    ///
    /// - Parameters:
    ///   - controller: The `UIViewController` instance used to present the banner ad.
    ///   - view: The `UIView` where the banner ad will be displayed.
    ///   - adUnitID: The ad unit ID provided by Google AdMob for the banner ad.
    ///   - adSize: The size of the banner ad, as defined in `BannerAdManager.BannerAdSizes`.
    ///   - adContent: The content configuration for the banner ad, as defined in `BannerAdManager.BannerContent`.
    ///   - completion: An optional closure called when the ad is successfully loaded or fails to load.
    ///   - delegate: An optional delegate conforming to `BannerAdManagerDelegate` to handle ad events such as clicks or errors.
    public func loadBannerAd(in controller: UIViewController, view: UIView, adUnitID:String, adSize: BannerAdManager.BannerAdSizes, adContent: BannerAdManager.BannerContent , completion: (() -> Void)? = nil, delegate: BannerAdManagerDelegate? = nil) {
        bannerHandler.delegate = delegate
        bannerHandler.loadAd(in: controller, view: view, adUnitID: adUnitID, adSize: adSize, adContent: adContent)
    }
}
//MARK: - Native Ads
extension AdMobManager {
    /// Loads a native ad in the specified view controller and view.
    ///
    /// - Parameters:
    ///   - controller: The `UIViewController` instance used to present the native ad.
    ///   - view: The `UIView` where the native ad will be displayed.
    ///   - adUnitID: The ad unit ID provided by Google AdMob for the native ad.
    ///   - delegate: An optional delegate conforming to `NativeAdManagerDelegate` to handle ad events such as clicks or errors.
    public func loadNativeAd(in controller: UIViewController, adUnitID: String, delegate: NativeAdManagerDelegate? = nil) {
        nativeHandler.delegate = delegate
        nativeHandler.loadAd(in: controller, adUnitID: adUnitID)
    }
    public func preLoadAd(withUnitID: String, delegate: NativeAdManagerDelegate? = nil) {
        nativeHandler.delegate = delegate
        nativeHandler.preloadAd(withUnitID: withUnitID)
    }
}

