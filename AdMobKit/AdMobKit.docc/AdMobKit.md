# ``AdMobKit``

AdMobKit is a lightweight Swift framework that simplifies integrating Google AdMob into iOS apps.  
It provides a modern, Swift-friendly API for banners, interstitials, rewarded ads, native ads, and app open ads.

## Overview

AdMobKit wraps the **Google Mobile Ads SDK** into a more convenient structure, 
reducing boilerplate and offering SwiftUI-friendly components.  
Use `AdMobManager` to initialize AdMob, then display ads through simple APIs 
with delegate callbacks or completion closures.

### Key Features
- Easy initialization of AdMob
- Banner ads (adaptive & inline)
- Interstitial ads with delegate/completion handler
- Rewarded ads with reward callbacks
- Native ads with customizable UI
- App open ads for splash screens

## Topics

### Getting Started
- ``AdMobManager/initializeAdMob()``

### Banner Ads
- ``BannerAdView``
- ``BannerAdManager``

### Interstitial Ads
- ``InterstitialAdManager``
- ``InterstitialAdManagerDelegate``

### Rewarded Ads
- ``RewardedAdManager``
- ``RewardedAdManagerDelegate``

### Native Ads
- ``NativeAdManager``
- ``NativeAdManagerDelegate``

### App Open Ads
- ``AppOpenAdManager``
- ``AppOpenAdManagerDelegate``
