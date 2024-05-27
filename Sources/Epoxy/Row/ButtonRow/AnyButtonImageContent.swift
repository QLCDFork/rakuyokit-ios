//
//  AnyButtonImageContent.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/5/27.
//  Copyright © 2024 RakuyoKit. All rights reserved.
//

#if !os(watchOS)
import UIKit

import RAKCore

// MARK: - AnyButtonImageContent

public struct AnyButtonImageContent<View>: AnyImageProviding {
    public typealias Value = ButtonImageContentProviding

    public typealias Input = Equatable & Value

    public let value: (any Value)?

    public let equals: ((any Value)?) -> Bool

    public let setForViewAction: (View?, UIControl.State) -> Void

    public init<T: Input>(_ value: T?) {
        self.value = value
        equals = { ($0 as? T == value) }
        setForViewAction = { value?.setForView($0, state: $1) }
    }
}

// MARK: ButtonImageContentProviding

extension AnyButtonImageContent: ButtonImageContentProviding {
    public func setForView<V>(_ view: V?, state: UIControl.State) {
        setForViewAction(view as? View, state)
    }
}

// MARK: FastImageContentProviding

extension AnyButtonImageContent: FastImageContentProviding {
    public static func asset(name: String, bundle: Bundle = .main, with configuration: UIImage.Configuration? = nil) -> Self {
        .init(UIImage(named: name, in: bundle, with: configuration))
    }

    public static func data(_ data: Data) -> Self {
        .init(UIImage(data: data))
    }

    public static func file(path: String) -> Self {
        .init(UIImage(contentsOfFile: path))
    }

    public static func sfSymbols(name: String, configuration: UIImage.SymbolConfiguration? = nil) -> Self {
        .init(UIImage(systemName: name, withConfiguration: configuration))
    }
}
#endif
