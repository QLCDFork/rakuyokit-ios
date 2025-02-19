//
//  DecorationViewConfig.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2025/2/17.
//  Copyright © 2024-2025 RakuyoKit. All rights reserved.
//

#if os(iOS)
import UIKit

// MARK: - DecorationViewConfig

public struct DecorationViewConfig {
    public let backgroundColor: UIColor?
    
    public let cornerRadius: CGFloat?
    
    public let maskedCorners: CACornerMask
    
    public init(backgroundColor: UIColor? = nil, cornerRadius: CGFloat? = nil, maskedCorners: CACornerMask = []) {
        self.backgroundColor = backgroundColor
        self.cornerRadius = cornerRadius
        self.maskedCorners = maskedCorners
    }
}

extension DecorationViewConfig {
    public static func topCornerRadiusDecorationView(with cornerRadius: CGFloat, backgroundColor: UIColor? = nil) -> Self {
        .init(backgroundColor: backgroundColor, cornerRadius: cornerRadius, maskedCorners: [
            .layerMinXMinYCorner,
            .layerMaxXMinYCorner,
        ])
    }
    
    public static func bottomCornerRadiusDecorationView(with cornerRadius: CGFloat, backgroundColor: UIColor? = nil) -> Self {
        .init(backgroundColor: backgroundColor, cornerRadius: cornerRadius, maskedCorners: [
            .layerMinXMaxYCorner,
            .layerMaxXMaxYCorner,
        ])
    }
}
#endif
