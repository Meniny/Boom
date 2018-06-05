
import Foundation
import ObjectiveC.runtime

internal func getAssociatedValue<T>(key: String, object: AnyObject) -> T? {
	return (objc_getAssociatedObject(object, key.address) as? AssociatedValue)?.value as? T
}

internal func getAssociatedValue<T>(key: String, object: AnyObject, initialValue: @autoclosure () -> T) -> T {
	return getAssociatedValue(key: key, object: object) ?? setAndReturn(initialValue: initialValue(), key: key, object: object)
}

internal func getAssociatedValue<T>(key: String, object: AnyObject, initialValue: () -> T) -> T {
	return getAssociatedValue(key: key, object: object) ?? setAndReturn(initialValue: initialValue(), key: key, object: object)
}

fileprivate func setAndReturn<T>(initialValue: T, key: String, object: AnyObject) -> T {
	set(associatedValue: initialValue, key: key, object: object)
	return initialValue
}

internal func set<T>(associatedValue: T?, key: String, object: AnyObject) {
	set(associatedValue: AssociatedValue(associatedValue), key: key, object: object)
}

internal func set<T: AnyObject>(weakAssociatedValue: T?, key: String, object: AnyObject) {
	set(associatedValue: AssociatedValue(weak: weakAssociatedValue), key: key, object: object)
}

extension String {
	
	fileprivate var address: UnsafeRawPointer {
		return UnsafeRawPointer(bitPattern: abs(hashValue))!
	}
	
}

private func set(associatedValue: AssociatedValue, key: String, object: AnyObject) {
	objc_setAssociatedObject(object, key.address, associatedValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
}

private class AssociatedValue {
	
	weak var _weakValue: AnyObject?
	var _value: Any?
	
	var value: Any? {
		return _weakValue ?? _value
	}
	
	init(_ value: Any?) {
		_value = value
	}
	
	init(weak: AnyObject?) {
		_weakValue = weak
	}
	
}
