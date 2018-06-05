
import Foundation
import UIKit

public extension UICollectionView {
	
	private static let ASSOCIATION_KEY = "cn.meniny.boom.manager"
	
	/// Return manager associated with collection.
	/// If not exist it will be created and assigned automatically.
	public var manager: FlowCollectionManager {
		get {
			return getAssociatedValue(key: UICollectionView.ASSOCIATION_KEY,
									  object: self,
									  initialValue: FlowCollectionManager(self))
		}
		set {
			set(associatedValue: newValue, key: UICollectionView.ASSOCIATION_KEY, object: self)
		}
	}

}

extension UICollectionViewCell: BoomCell { }


extension UITableViewHeaderFooterView: HeaderFooterProtocol {
	
	/// By default it uses the same name of the class.
	public static var reuseIdentifier: String {
		return String(describing: self)
	}
	
	/// Return true if you want to allocate the cell via class name using classic
	/// `initWithFrame`/`initWithCoder`. If your header/footer UI is defined inside a nib file
	/// or inside a storyboard you must return `false`.
	public static var registerAsClass: Bool {
		return false
	}

}

extension UICollectionReusableView : HeaderFooterProtocol {
	
	/// By default it uses the same name of the class.
	public static var reuseIdentifier: String {
		return String(describing: self)
	}
	
	/// Return true if you want to allocate the cell via class name using classic
	/// `initWithFrame`/`initWithCoder`. If your header/footer UI is defined inside a nib file
	/// or inside a storyboard you must return `false`.
	public static var registerAsClass: Bool {
		return false
	}

}

public protocol AbstractCollectionReusableView {
	var viewClass: AnyClass { get }
	var reuseIdentifier: String { get }
	var registerAsClass: Bool { get }
}

// MARK: INTERNAL PROTOCOLS

internal protocol AbstractCollectionHeaderFooterItem {
	
	@discardableResult
	func dispatch(_ event: CollectionSectionViewEventsKey, type: SectionType,  view: UICollectionReusableView?, section: Int, collection: UICollectionView) -> Any?
	
}

public protocol CollectionSectionProtocol : AbstractCollectionReusableView {
	var section: CollectionSection? { get set }
}


internal protocol AbstractAdapterProtocolFunctions {

	@discardableResult
	func dispatch(_ event: CollectionAdapterEventKey, context: InternalContext) -> Any?
	
	func _instanceCell(in collection: UICollectionView, at indexPath: IndexPath?) -> UICollectionViewCell
}

public protocol CollectionAdapterProtocol : AbstractAdapterProtocol, Equatable {
	
}

internal enum CollectionAdapterEventKey: Int {
	case dequeue
	case shouldSelect
	case shouldDeselect
	case didSelect
	case didDeselect
	case didHighlight
	case didUnhighlight
	case shouldHighlight
	case willDisplay
	case endDisplay
	case shouldShowEditMenu
	case canPerformEditAction
	case performEditAction
	case canFocus
	case itemSize
	//case generateDragPreview
	//case generateDropPreview
	case prefetch
	case cancelPrefetch
	case shouldSpringLoad
}

internal enum CollectionSectionViewEventsKey: Int {
	case dequeue
	case referenceSize
	case didDisplay
	case endDisplay
	case willDisplay
}
