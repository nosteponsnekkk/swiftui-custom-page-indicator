//
//  PagingView.swift
//  CustomPageIndicatorExample
//
//  Created by nosteponsnekkk on 11.08.2024.
//

import SwiftUI

struct PagingView: View {
    
    @State private var offset: CGFloat = 0
    
    private let pages: [OnboardingPageType] = OnboardingPageType.allCases
        
    var body: some View {
        ZStack {
            TabView {
                
                ForEach(pages) { page in
                    if page == pages.first {
                        OnboardingPage(page: page)
                            .overlay {
                                GeometryReader {
                                    updateCurrentPage($0)
                                }
                            }
                    } else {
                        OnboardingPage(page: page)
                    }
                }
                
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .ignoresSafeArea()

            PageIndicator(offset: offset,
                          numberOfPages: pages.count)

        }
    }
    private func updateCurrentPage(_ geometry: GeometryProxy) -> some View {
        let currentOffset = geometry.frame(in: .global).minX
        offset = currentOffset
        return EmptyView()
    }
}

#Preview {
    PagingView()
}
