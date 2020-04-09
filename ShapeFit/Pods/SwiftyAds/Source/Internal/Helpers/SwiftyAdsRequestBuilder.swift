//    The MIT License (MIT)
//
//    Copyright (c) 2015-2020 Dominik Ringler
//
//    Permission is hereby granted, free of charge, to any person obtaining a copy
//    of this software and associated documentation files (the "Software"), to deal
//    in the Software without restriction, including without limitation the rights
//    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//    copies of the Software, and to permit persons to whom the Software is
//    furnished to do so, subject to the following conditions:
//
//    The above copyright notice and this permission notice shall be included in all
//    copies or substantial portions of the Software.
//
//    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//    SOFTWARE.

import Foundation
import GoogleMobileAds
  
enum SwiftyAdsRequestBuilderMode {
    case production
    case test(devices: [String])
}

protocol SwiftyAdsRequestBuilderType: AnyObject {
    func build(_ mode: SwiftyAdsRequestBuilderMode) -> GADRequest
}

final class SwiftyAdsRequestBuilder {
    
    // MARK: - Properties
    
    private let mobileAds: GADMobileAds
    private let isGDPRRequired: Bool
    private let isNonPersonalizedOnly: Bool
    private let isTaggedForUnderAgeOfConsent: Bool
    
    // MARK: - Init
    
    init(mobileAds: GADMobileAds,
         isGDPRRequired: Bool,
         isNonPersonalizedOnly: Bool,
         isTaggedForUnderAgeOfConsent: Bool) {
        self.mobileAds = mobileAds
        self.isGDPRRequired = isGDPRRequired
        self.isNonPersonalizedOnly = isNonPersonalizedOnly
        self.isTaggedForUnderAgeOfConsent = isTaggedForUnderAgeOfConsent
    }
}

// MARK: - SwiftyAdsRequestBuilderType

extension SwiftyAdsRequestBuilder: SwiftyAdsRequestBuilderType {
  
    func build(_ mode: SwiftyAdsRequestBuilderMode) -> GADRequest {
        let request = GADRequest()
        switch mode {
        case .production:
            break
        case .test(let devices):
            mobileAds.requestConfiguration.testDeviceIdentifiers = devices
        }
        addGDPRExtrasIfNeeded(for: request)
        return request
    }
}

// MARK: - Private Methods

private extension SwiftyAdsRequestBuilder {
    
    func addGDPRExtrasIfNeeded(for request: GADRequest) {
        guard isGDPRRequired else {
            return
        }
            
        // Create additional parameters with under age of consent
        var additionalParameters: [String: Any] = ["tag_for_under_age_of_consent": isTaggedForUnderAgeOfConsent]
      
        // Update for non personalized if needed
        if isNonPersonalizedOnly {
            additionalParameters["npa"] = "1"
        }
        
        // Create extras
        let extras = GADExtras()
        extras.additionalParameters = additionalParameters
        
        // Register extras in request
        request.register(extras)
    }
}
