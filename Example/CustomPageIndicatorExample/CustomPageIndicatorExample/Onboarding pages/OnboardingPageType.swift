//
//  OnboardingPageType.swift
//  onboarding_test
//
//  Created by Oleg on 11.08.2024.
//

import SwiftUI

public enum OnboardingPageType: CaseIterable, Identifiable {
    case firtsPage
    case secondPage
    case thirdPage
    
    
    public var id: Int {
        switch self {
        case .firtsPage:
            return 0
        case .secondPage:
            return 1
        case .thirdPage:
            return 2
        }
    }
    
    public var color: Color {
        switch self {
        case .firtsPage:
            return .red
        case .secondPage:
            return .green
        case .thirdPage:
            return .yellow
        }
    }
    
    public var title: String {
        switch self {
        case .firtsPage:
            return "first"
        case .secondPage:
            return "second"
        case .thirdPage:
            return "third"
        }
    }
}
