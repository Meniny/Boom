
import Foundation
import UIKit

public class TableSectionView<T: HeaderFooterProtocol>: TableHeaderFooterProtocol, AbstractTableHeaderFooterItem, CustomStringConvertible {
	
	public var viewClass: AnyClass { return T.self }
	public var reuseIdentifier: String { return T.reuseIdentifier }
	public var registerAsClass: Bool { return T.registerAsClass }
	
	public var description: String {
		return "CollectionSectionView<\(String(describing: type(of: T.self)))>"
	}
	
	/// Context of the event sent to section's view.
	public struct Context<T> {
		
		public private(set) var type: SectionType
		
		/// Parent collection
		public private(set) weak var table: UITableView?
		
		/// Instance of the view dequeued for this section.
		public private(set) var view: T?
		
		/// Index of the section.
		public private(set) var section: Int
		
		/// Parent collection's size.
		public var tableSize: CGSize? {
			return self.table?.bounds.size
		}
		
		/// Initialize a new context (private).
		public init(type: SectionType, view: UIView?, at section: Int, of table: UITableView) {
			self.type = type
			self.table = table
			self.view = view as? T
			self.section = section
		}
	}
	
	/// Events
	public var on = TableSectionView.Events<T>()
	
	/// Parent section
	public weak var section: TableSection? = nil
	
	// MARK: INIT
	
	/// Initialize a new section view.
	///
	/// - Parameter configuration: configuration callback
	public init(_ configuration: ((TableSectionView) -> (Void))? = nil) {
		configuration?(self)
	}
	

	// MARK: INTERNAL METHODS
	@discardableResult
	func dispatch(_ event: TableSectionViewEventsKey, type: SectionType, view: UIView?, section: Int, table: UITableView) -> Any? {
		switch event {
		case .dequeue:
			guard let callback = self.on.dequeue else { return nil }
			callback(Context<T>(type: type, view: view, at: section, of: table))
		case .height:
			guard let callback = self.on.height else { return nil }
			return callback(Context<T>(type: type, view: view, at: section, of: table))
		case .willDisplay:
			guard let callback = self.on.willDisplay else { return nil }
			return callback(Context<T>(type: type, view: view, at: section, of: table))
		case .didDisplay:
			guard let callback = self.on.didDisplay else { return nil }
			return callback(Context<T>(type: type, view: view, at: section, of: table))
		case .endDisplay:
			guard let callback = self.on.endDisplay else { return nil }
			return callback(Context<T>(type: type, view: view, at: section, of: table))
		case .estimatedHeight:
			guard let callback = self.on.estimatedHeight else { return nil }
			return callback(Context<T>(type: type, view: view, at: section, of: table))
		}
		return nil
	}
	
}
