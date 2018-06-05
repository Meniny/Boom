
import Foundation
import UIKit

// MARK: - CollectionSection Events

public extension CollectionSectionView {
	
	public struct Event<T> {
		public typealias EventContext = Context<T>
		
		public var dequeue: ((EventContext) -> Void)? = nil
		public var referenceSize: ((EventContext) -> CGSize)? = nil
		public var didDisplay: ((EventContext) -> Void)? = nil
		public var endDisplay: ((EventContext) -> Void)? = nil
		public var willDisplay: ((EventContext) -> Void)? = nil

	}
	
}

// MARK: - CollectionAdapter Events
public extension CollectionAdapter {
	
	public struct Events<M,C> {
		public typealias EventContext = Context<M,C>
		
		public var dequeue: ((EventContext) -> Void)? = nil
		public var shouldSelect: ((EventContext) -> Bool)? = nil
		public var shouldDeselect: ((EventContext) -> Bool)? = nil
		public var didSelect: ((EventContext) -> Void)? = nil
		public var didDeselect: ((EventContext) -> Void)? = nil
		public var didHighlight: ((EventContext) -> Void)? = nil
		public var didUnhighlight: ((EventContext) -> Void)? = nil
		public var shouldHighlight: ((EventContext) -> Bool)? = nil
		public var willDisplay: ((_ cell: C, _ path: IndexPath) -> Void)? = nil
		public var endDisplay: ((_ cell: C, _ path: IndexPath) -> Void)? = nil
		public var shouldShowEditMenu: ((EventContext) -> Bool)? = nil
		public var canPerformEditAction: ((EventContext) -> Bool)? = nil
		public var performEditAction: ((_ ctx: EventContext, _ selector: Selector, _ sender: Any?) -> Void)? = nil
		public var canFocus: ((EventContext) -> Bool)? = nil
		public var itemSize: ((EventContext) -> CGSize)? = nil
		//var generateDragPreview: ((EventContext) -> UIDragPreviewParameters?)? = nil
		//var generateDropPreview: ((EventContext) -> UIDragPreviewParameters?)? = nil
		public var prefetch: ((_ items: [M], _ paths: [IndexPath], _ collection: UICollectionView) -> Void)? = nil
		public var cancelPrefetch: ((_ items: [M], _ paths: [IndexPath], _ collection: UICollectionView) -> Void)? = nil
		public var shouldSpringLoad: ((EventContext) -> Bool)? = nil
	}
	
}

// MARK: - CollectionManager Events
public extension CollectionManager {
	
	public struct Events {
		typealias HeaderFooterEvent = (view: UICollectionReusableView, path: IndexPath, table: UICollectionView)

		var layoutDidChange: ((_ old: UICollectionViewLayout, _ new: UICollectionViewLayout) -> UICollectionViewTransitionLayout?)? = nil
		var targetOffset: ((_ proposedContentOffset: CGPoint) -> CGPoint)? = nil
		var moveItemPath: ((_ originalIndexPath: IndexPath, _ proposedIndexPath: IndexPath) -> IndexPath)? = nil
		var shouldUpdateFocus: ((_ context: UICollectionViewFocusUpdateContext) -> Bool)? = nil
		var didUpdateFocus: ((_ context: UICollectionViewFocusUpdateContext, _ coordinator: UIFocusAnimationCoordinator) -> Void)? = nil
		
		var willDisplayHeader : ((HeaderFooterEvent) -> Void)? = nil
		var willDisplayFooter : ((HeaderFooterEvent) -> Void)? = nil
		
		var endDisplayHeader : ((HeaderFooterEvent) -> Void)? = nil
		var endDisplayFooter : ((HeaderFooterEvent) -> Void)? = nil
	}
	
}
