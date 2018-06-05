
import Foundation
import UIKit

/// Represent a single section of the table
public class TableSection: Hashable {
	
	/// Items inside the section.
	public private(set) var models: [BoomModel] = []
	
	/// Title of the header; if `headerView` is set this value is ignored.
	public var headerTitle: String?
	
	/// Title of the footer; if `footerView` is set this value is ignored.
	public var footerTitle: String?
	
	/// View of the header
	public var headerView: TableHeaderFooterProtocol? {
		willSet {
			self.headerView?.section = nil
		}
		didSet {
			self.headerView?.section = self
		}
	}
	
	/// View of the footer
	public var footerView: TableHeaderFooterProtocol? {
		willSet {
			self.footerView?.section = nil
		}
		didSet {
			self.footerView?.section = self
		}
	}
	
	/// Optional index title for this section (used for `sectionIndexTitles(for: UITableView)`)
	public var indexTitle: String?
	
	/// Unique identifier of the section
	public let UUID: String = NSUUID().uuidString
	
	/// Initialize a new section with given initial models.
	///
	/// - Parameter models: items to add (`nil` means empty array)
	public init(_ models: [BoomModel]?) {
		self.models = (models ?? [])
	}
	
	/// Initialize a new section with given header/footer's titles and initial items.
	///
	/// - Parameters:
	///   - headerTitle: header title as string
	///   - footerTitle: footer title as string
	///   - models: models to add (`nil` means empty array)
	public convenience init(headerTitle: String?, footerTitle: String?,
							models: [BoomModel]? = nil) {
		self.init(models)
		self.headerTitle = headerTitle
		self.footerTitle = footerTitle
	}
	
	/// Initialize a new section with given view for header/footer and initial items.
	///
	/// - Parameters:
	///   - headerView: header view
	///   - footerView: footer view
	///   - models: models to add (`nil` means empty array)
	public convenience init(headerView: TableHeaderFooterProtocol?,
							footerView: TableHeaderFooterProtocol?,
							models: [BoomModel]? = nil) {
		self.init(models)
		self.headerView = headerView
		self.footerView = footerView
	}
	
	/// Hash identifier of the section.
	public var hashValue: Int {
		return self.UUID.hashValue
	}
	
	/// Equatable support.
	public static func == (lhs: TableSection, rhs: TableSection) -> Bool {
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
