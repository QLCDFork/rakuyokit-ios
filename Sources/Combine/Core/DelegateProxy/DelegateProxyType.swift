#if !(os(iOS) && (arch(i386) || arch(arm)))
import Foundation

private var associatedKey: Void?

public protocol DelegateProxyType {
    associatedtype Object
    
    func setDelegate(to object: Object)
}

@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
public extension DelegateProxyType where Self: DelegateProxy {
    static func createDelegateProxy(for object: Object) -> Self {
        objc_sync_enter(self)
        defer { objc_sync_exit(self) }
        
        let delegateProxy: Self
        
        if let associatedObject = objc_getAssociatedObject(object, &associatedKey) as? Self {
            delegateProxy = associatedObject
        } else {
            delegateProxy = .init()
            objc_setAssociatedObject(object, &associatedKey, delegateProxy, .OBJC_ASSOCIATION_RETAIN)
        }
        
        delegateProxy.setDelegate(to: object)
        
        return delegateProxy
    }
}
#endif
