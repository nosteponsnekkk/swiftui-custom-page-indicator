//
//  OnboardingPage.swift
//  onboarding_test
//
//  Created by Oleg on 11.08.2024.
//

import SwiftUI

struct OnboardingPage: View {
    
    private let pageType: OnboardingPageType
    
    init(page: OnboardingPageType) {
        self.pageType = page
    }
    
    var body: some View {
        ZStack {
            pageType.color
            Text(pageType.title)
                .foregroundStyle(.white)
                .font(.title)
                .bold()
        }
        .ignoresSafeArea()
    }
}

#Preview {
    OnboardingPage(page: .firtsPage)
}
