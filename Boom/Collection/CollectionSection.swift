
import Foundation
import UIKit

/// Represent a single section of the collection.
public class CollectionSection: Equatable, Hashable {
	
	/// Identifier of the section
	public var UUID: String = NSUUID().uuidString
	
	/// Items inside the collection
	public private(set) var models: [BoomModel]
	
	/// Implement this method when you want to provide margins for sections in the flow layout.
	/// If you do not implement this method, the margins are obtained from the properties of the flow layout object.
	/// NOTE: It's valid only for flow layout.
	open var sectionInsets: (() -> (UIEdgeInsets))? = nil
	
	/// The minimum spacing (in points) to use between items in the same row or column.
	/// If you do not implement this method, value is obtained from the properties of the flow layout object.
	/// NOTE: It's valid only for flow layout.
	open var minimumInterItemSpacing: (() -> (CGFloat))? = nil
	
	/// The minimum spacing (in points) to use between rows or columns.
	/// If you do not implement this method, value is obtained from the properties of the flow layout object.
	/// NOTE: It's valid only for flow layout.
	open var minimumLineSpacing: (() -> (CGFloat))? = nil
	
	/// Header of the sections; instantiate a new object of `CollectionSectionView<UIReusableView>`.
	/// NOTE: It's valid only for flow layout.
	open var header: CollectionSectionProtocol? = nil {
		willSet {
			self.header?.section = nil
		}
		didSet {
			self.header?.section = self
		}
	}
	
	/// Footer of the sections; instantiate a new object of `CollectionSectionView<UIReusableView>`.
	/// NOTE: It's valid only for flow layout.
	open var footer: CollectionSectionProtocol? = nil {
		willSet {
			self.footer?.section = nil
		}
		didSet {
			self.footer?.section = self
		}
	}
	
	/// Temporary removed models, it's used to pass the correct model
	/// to didEndDisplay event; after sent it will be removed automatically.
	private var temporaryRemovedModels: [IndexPath : BoomModel] = [:]
	
	/// Managed manager
	private weak var manager: CollectionManager?
	
	/// Index of the section in manager.
	/// If section is not part of a manager it returns `nil`.
	private var index: Int? {
		guard let man = manager, let idx = man.sections.index(of: self) else { return nil }
		return idx
	}
	
	/// Initialize a new section with given objects as models.
	///
	/// - Parameters:
	///   - models: models, `nil` create an empty set
	///   - headerView: optional custom header
	///   - footerView: optional custom footer
	public init(_ models: [BoomModel]?, headerView: CollectionSectionProtocol? = nil, footerView: CollectionSectionProtocol? = nil) {
		self.models = (models ?? [])
		self.header = headerView
		self.footer = footerView
	}
	
	
	/// Hash identifier of the section
	public var hashValue: Int {
		return self.UUID.hashValue
	}
	
	/// Equatable support.
	public static func == (lhs: CollectionSection, rhs: CollectionSection) -> Bool {
		return (lhs.UUID == rhs.UUID)
	}
	
	/// Change the content of the section.
	///
	/// - Parameter models: array of models to set.
	public func set(models: [BoomModel]) {
		self.models = models
	}
	
	/// Add item at given index.
	///
	/// - Parameters:
	///   - model: model to append
	///   - index: destination index; if invalid or `nil` model is append at the end of the list.
	public func add(model: BoomModel?, at index: Int?) {
		guard let model = model else { return }
		guard let index = index, index < self.models.count else {
			self.models.append(model)
			return
		}
		self.models.insert(model, at: index)
	}
	
	/// Add models starting at given index of the array.
	///
	/// - Parameters:
	///   - models: models to insert.
	///   - index: destination starting index; if invalid or `nil` models are append at the end of the list.
	public func add(models: [BoomModel]?, at index: Int?) {
		guard let models = models else { return }
		guard let index = index, index < self.models.count else {
			self.models.append(contentsOf: models)
			return
		}
		self.models.insert(contentsOf: models, at: index)
	}
	
	/// Remove model at given index.
	///
	/// - Parameter index: index to remove.
	/// - Returns: removed model, `nil` if index is invalid.
	@discardableResult
	public func remove(at index: Int) -> BoomModel? {
		guard index < self.models.count else { return nil }
		return self.models.remove(at: index)
	}
	
	/// Remove model at given indexes set.
	///
	/// - Parameter indexes: indexes to remove.
	/// - Returns: an array of removed indexes starting from the lower index to the last one. Invalid indexes are ignored.
	@discardableResult
	public func remove(atIndexes indexes: IndexSet) -> [BoomModel] {
		var removed: [BoomModel] = []
		indexes.reversed().forEach {
			if $0 < self.models.count {
				removed.append(self.models.remove(at: $0))
			}
		}
		return removed
	}
	
	/// Remove all models into the section.
	///
	/// - Parameter kp: `true` to keep the capacity and optimize operations.
	/// - Returns: count removed items.
	@discardableResult
	public func removeAll(keepingCapacity kp: Bool = false) -> Int {
		let count = self.models.count
		self.models.removeAll(keepingCapacity: kp)
		return count
	}
	
	/// Swap model at given index to another destination index.
	///
	/// - Parameters:
	///   - sourceIndex: source index
	///   - destIndex: destination index
	public func move(swappingAt sourceIndex: Int, with destIndex: Int) {
		guard sourceIndex < self.models.count, destIndex < self.models.count else { return }
		swap(&self.models[sourceIndex], &self.models[destIndex])
	}
	
	/// Remove model at given index and insert at destination index.
	///
	/// - Parameters:
	///   - sourceIndex: source index
	///   - destIndex: destination index
	public func move(from sourceIndex: Int, to destIndex: Int) {
		guard sourceIndex < self.models.count, destIndex < self.models.count else { return }
		let removed = self.models.remove(at: sourceIndex)
		self.models.insert(removed, at: destIndex)
	}

}
