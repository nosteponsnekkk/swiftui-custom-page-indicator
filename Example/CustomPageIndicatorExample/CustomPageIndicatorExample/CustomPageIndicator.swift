//
//  CustomPageIndicator.swift
//

import SwiftUI

public struct PageIndicator: View {
    
    let offset: CGFloat
    let numberOfPages: Int
    let size: CGFloat
    let maxWidthMultiplier: CGFloat
    let selectedTintColor: Color
    let unselectedTintColor: Color
    
    public init(offset: CGFloat,
         numberOfPages: Int,
         size: CGFloat = 10,
         maxWidthMultiplier: CGFloat = 3,
         selectedTintColor: Color = .blue,
         unselectedTintColor: Color = .gray) {
        
        self.offset = offset
        self.numberOfPages = numberOfPages
        self.size = size
        self.maxWidthMultiplier = maxWidthMultiplier
        self.selectedTintColor = selectedTintColor
        self.unselectedTintColor = unselectedTintColor
    }
    
    public var body: some View {
        VStack {
            Spacer()
            HStack {
                ForEach(0..<numberOfPages, id: \.self) { index in
                    dotView(for: index)
                        .frame(width: calculateDotWidth(for: index),
                               height: size)
                        .clipShape(Capsule())
                }
            }
        }
    }
    
    private func dotView(for index: Int) -> Color {
        calculateDotColor(for: index)
    }
}

// MARK: - Private Helper Methods
private extension PageIndicator {
    func calculateTransformValues() -> (currentPageIndex: Int, progress: CGFloat) {
        let offset = -self.offset
        let screenWidth = UIScreen.main.bounds.width
        let fractionalPageIndex = offset / screenWidth
        let currentPageIndex = Int(fractionalPageIndex)
        let progress = fractionalPageIndex - CGFloat(currentPageIndex)
        
        return (currentPageIndex, progress)
    }
    
    func calculateDotWidth(for index: Int) -> CGFloat {
        let transformValues = calculateTransformValues()
        
        switch index {
        case transformValues.currentPageIndex:
            let transformedSize = size + (size * maxWidthMultiplier * (1 - transformValues.progress))
            return max(size, transformedSize)

        case transformValues.currentPageIndex + 1:
            let transformedSize = size + (size * maxWidthMultiplier * transformValues.progress)
            return max(size, transformedSize)
        default:
            return size
        }
    }
    
    func calculateDotColor(for index: Int) -> Color {
        let transformValues = calculateTransformValues()
        
        if transformValues.currentPageIndex == 0 && transformValues.progress < 0 {
            return index == 0 ? selectedTintColor : unselectedTintColor
        } else if transformValues.currentPageIndex == numberOfPages - 1 && transformValues.progress > 0 {
            return index == numberOfPages - 1 ? selectedTintColor : unselectedTintColor
        } else {
            if index == transformValues.currentPageIndex {
                return interpolateColor(from: selectedTintColor,
                                        to: unselectedTintColor,
                                        progress: transformValues.progress)
            } else if index == transformValues.currentPageIndex + 1 {
                return interpolateColor(from: unselectedTintColor,
                                        to: selectedTintColor,
                                        progress: transformValues.progress)
            } else {
                return unselectedTintColor
            }
        }
    }
    
    func interpolateColor(from startColor: Color,
                          to endColor: Color,
                          progress: CGFloat) -> Color {
        let startUIColor = UIColor(startColor)
        let endUIColor = UIColor(endColor)
        
        var startRed: CGFloat = 0, startGreen: CGFloat = 0, startBlue: CGFloat = 0, startAlpha: CGFloat = 0
        var endRed: CGFloat = 0, endGreen: CGFloat = 0, endBlue: CGFloat = 0, endAlpha: CGFloat = 0
        
        startUIColor.getRed(&startRed, green: &startGreen, blue: &startBlue, alpha: &startAlpha)
        endUIColor.getRed(&endRed, green: &endGreen, blue: &endBlue, alpha: &endAlpha)
        
        let red = startRed + (endRed - startRed) * progress
        let green = startGreen + (endGreen - startGreen) * progress
        let blue = startBlue + (endBlue - startBlue) * progress
        let alpha = startAlpha + (endAlpha - startAlpha) * progress
        
        return Color(uiColor: UIColor(red: red, green: green, blue: blue, alpha: alpha))
    }
}

#Preview {
    PageIndicator(offset: 0, numberOfPages: 1)
}
