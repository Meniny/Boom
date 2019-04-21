
import Foundation
import UIKit

public extension UITableView {
	
	private static let ASSOCIATION_KEY = "cn.meniny.boom.manager"
	
	/// Return manager associated with collection.
	/// If not exist it will be created and assigned automatically.
	public var manager: TableManager {
		get {
			return getAssociatedValue(key: UITableView.ASSOCIATION_KEY,
									  object: self,
									  initialValue: TableManager(self))
		}
		set {
			set(associatedValue: newValue, key: UITableView.ASSOCIATION_KEY, object: self)
		}
	}
	
}

/// State of the section
///
/// - none: don't change the state
/// - deselect: deselect without animation
/// - deselectAnimated: deselect with animation
public enum TableSelectionState {
	case none
	case deselect
	case deselectAnimated
}

/// Animations used with reload
public struct TableReloadAnimations {
	
	public var rowDeletionAnimation: UITableView.RowAnimation 		= .automatic
	public var rowInsertionAnimation: UITableView.RowAnimation 		= .automatic
	public var rowReloadAnimation: UITableView.RowAnimation 			= .automatic
	
	public var sectionDeletionAnimation: UITableView.RowAnimation 	= .automatic
	public var sectionInsertionAnimation: UITableView.RowAnimation 	= .automatic
	public var sectionReloadAnimation: UITableView.RowAnimation 		= .automatic

	public init() { }
	
	public static func `default`() -> TableReloadAnimations {
		return TableReloadAnimations()
	}
}

// Protocols

extension UITableViewCell: BoomCell { }

public protocol TableAdapterProtocol: BoomAdapter, Equatable { }

internal protocol AbstractTableHeaderFooterItem  {
	@discardableResult
	func dispatch(_ event: TableSectionViewEventsKey, type: SectionType, view: UIView?, section: Int, table: UITableView) -> Any?
}

public protocol TableHeaderFooterProtocol: AbstractCollectionReusableView {
	var section: TableSection? { get set }
}

internal protocol TableAdaterProtocolFunctions {
	
	@discardableResult
	func dispatch(_ event: TableAdapterEventsKey,  context: InternalContext) -> Any?
	
	// Dequeue (UITableViewDatasource)
	func _instanceCell(in table: UITableView, at indexPath: IndexPath?) -> UITableViewCell
}

internal protocol TableDirectorEventable {
	var name: TableDirectorEventKey { get }
}

internal enum TableDirectorEventKey: String {
	case sectionForSectionIndex
}

internal enum TableSectionViewEventsKey: Int {
	case dequeue
	case height
	case estimatedHeight
	case didDisplay
	case endDisplay
	case willDisplay
}

internal enum TableAdapterEventsKey: Int {
	case dequeue = 0
	case canEdit
	case commitEdit
	case canMoveRow
	case moveRow
	case prefetch
	case cancelPrefetch
	case rowHeight
	case rowHeightEstimated
	case indentLevel
	case willDisplay
	case shouldSpringLoad
	case editActions
	case tapOnAccessory
	case willSelect
	case tap
	case willDeselect
	case didDeselect
	case willBeginEdit
	case didEndEdit
	case editStyle
	case deleteConfirmTitle
	case editShouldIndent
	case moveAdjustDestination
	case endDisplay
	case shouldShowMenu
	case canPerformMenuAction
	case performMenuAction
	case shouldHighlight
	case didHighlight
	case didUnhighlight
	case canFocus
	//case leadingSwipeActions
	//case trailingSwipeActions
}
