//
//  Layout+SectionModel.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/4/9.
//  Copyright © 2024-2025 RakuyoKit. All rights reserved.
//

#if !os(watchOS) && !os(tvOS) && !os(visionOS)
import UIKit

import EpoxyCollectionView

extension SectionModel {
    public func layout(_ wrapper: SectionProviderWrapper) -> Self {
        compositionalLayoutSectionProvider(wrapper.provider)
    }

    public func layout(_ section: Layout.Section?) -> Self {
        compositionalLayoutSection(section)
    }
}
#endif
