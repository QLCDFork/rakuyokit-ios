//
//  EmptyRow.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/6/18.
//  Copyright © 2024-2025 RakuyoKit. All rights reserved.
//

#if !os(watchOS) && !os(tvOS) && !os(visionOS)
import UIKit

import EpoxyCore
import RAKBase
import RAKCore

// MARK: - EmptyRow

/// Blank View
///
/// It is not recommended that you inherit from this class
public final class EmptyRow: BaseStyledEpoxyView<EmptyRow.Style> { }

// MARK: Life cycle

extension EmptyRow {
    override public var intrinsicContentSize: CGSize {
        lazy var superSize = super.intrinsicContentSize
        guard let size = style.size else { return superSize }

        return .init(
            width: size.width ?? superSize.width,
            height: size.height ?? superSize.height
        )
    }
}

// MARK: Config

extension EmptyRow {
    override public func config() {
        super.config()

        style.apply(to: self)
    }
}

// MARK: StyledView

extension EmptyRow {
    public struct Style: Hashable, RowConfigureApplicable {
        public let size: OptionalCGSize?
        public let backgroundColor: UIColor?

        public let cornerRadius: CGFloat
        public let masksToBounds: Bool

        public let borderWidth: CGFloat
        public let borderColor: UIColor?

        public init(
            size: OptionalCGSize? = nil,
            backgroundColor: ConvertibleToColor? = nil,
            cornerRadius: CGFloat = 0,
            masksToBounds: Bool = false,
            borderWidth: CGFloat = 0,
            borderColor: ConvertibleToColor? = nil
        ) {
            self.size = size
            self.backgroundColor = backgroundColor?.color
            self.cornerRadius = cornerRadius
            self.masksToBounds = masksToBounds
            self.borderWidth = borderWidth
            self.borderColor = borderColor?.color
        }

        public func apply(to row: UIView) {
            row.backgroundColor = backgroundColor

            row.layer.cornerRadius = cornerRadius
            row.layer.masksToBounds = masksToBounds
            row.layer.borderWidth = borderWidth
            row.layer.borderColor = borderColor?.cgColor
        }
    }
}

// MARK: ContentConfigurableView

extension EmptyRow: ContentConfigurableView { }

// MARK: BehaviorsConfigurableView

extension EmptyRow: BehaviorsConfigurableView { }
#endif
