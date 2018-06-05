
import Foundation
import UIKit

public class CollectionSectionView<T: HeaderFooterProtocol>: CollectionSectionProtocol,AbstractCollectionHeaderFooterItem, CustomStringConvertible {	
	
	// Protocol default implementation
	public var viewClass: AnyClass { return T.self }
	public var reuseIdentifier: String { return T.reuseIdentifier }
	public var registerAsClass: Bool { return T.registerAsClass }
	
	public weak var section: CollectionSection? = nil

	public var description: String {
		return "CollectionSectionView<\(String(describing: type(of: T.self)))>"
	}
	
	/// Context of the event sent to section's view.
	public struct Context<T> {
		
		/// Type of item (footer or header)
		public private(set) var type: SectionType
		
		/// Parent collection
		public private(set) weak var collection: UICollectionView?
		
		/// Instance of the view dequeued for this section.
		public private(set) var view: T?
		
		/// Index of the section.
		public private(set) var section: Int
		
		/// Parent collection's size.
		public var collectionSize: CGSize? {
			return self.collection?.bounds.size
		}
		
		/// Initialize a new context (private).
		public init(type: SectionType, view: UIView?, at section: Int, of collection: UICollectionView) {
			self.type = type
			self.collection = collection
			self.view = view as? T
			self.section = section
		}
	}
	
	/// Events for section
	public var on = Event<T>()
	
	// MARK: INIT
	
	/// Initialize a new section view.
	///
	/// - Parameter configuration: configuration callback
	public init(_ configuration: ((CollectionSectionView) -> (Void))? = nil) {
		configuration?(self)
	}
	
	// MARK: INTERNAL METHODS
	@discardableResult
	func dispatch(_ event: CollectionSectionViewEventsKey, type: SectionType, view: UICollectionReusableView?, section: Int, collection: UICollectionView) -> Any? {
		switch event {
		case .dequeue:
			guard let callback = self.on.dequeue else { return nil }
			callback(Context(type: type, view: view, at: section, of: collection))
		case .didDisplay:
			guard let callback = self.on.didDisplay else { return nil }
			callback(Context(type: type, view: view, at: section, of: collection))
		case .endDisplay:
			guard let callback = self.on.endDisplay else { return nil }
			callback(Context(type: type, view: view, at: section, of: collection))
		case .willDisplay:
			guard let callback = self.on.willDisplay else { return nil }
			callback(Context(type: type, view: view, at: section, of: collection))
		case .referenceSize:
			guard let callback = self.on.referenceSize else { return nil }
			return callback(Context(type: type, view: view, at: section, of: collection))
		}
		return nil
	}
	
}
