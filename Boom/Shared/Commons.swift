
import Foundation
import UIKit

/// No data shortcut when adapter does not need of a representable model
public struct NoData: BoomModel {
	public func isEqual(to other: BoomModel) -> Bool { return false }
	public var identifier: Int = 0
}

internal struct InternalContext {
	var model: BoomModel?
	var models: [BoomModel]?
	var path: IndexPath?
	var paths: [IndexPath]?
	var cell: BoomCell?
	var container: Any
	var param1: Any?
	var param2: Any?
	var param3: Any?

	public init(_ model: BoomModel?, _ path: IndexPath, _ cell: BoomCell?, _ scrollview: UIScrollView,
				param1: Any? = nil, param2: Any? = nil, param3: Any? = nil) {
		self.model = model
		self.path = path
		self.cell = cell
		self.container = scrollview
		self.param1 = param1
		self.param2 = param2
	}
	
	public init(_ models: [BoomModel], _ paths: [IndexPath], _ scrollview: UIScrollView) {
		self.models = models
		self.paths = paths
		self.container = scrollview
	}
}

public enum SectionType {
	case header
	case footer
}

/// MARK: UIScrollViewDelegate Events

public struct ScrollViewEvents {
	public var didScroll: ((UIScrollView) -> Void)? = nil
	public var willBeginDragging: ((UIScrollView) -> Void)? = nil
	public var willEndDragging: ((_ scrollView: UIScrollView, _ velocity: CGPoint, _ targetOffset: UnsafeMutablePointer<CGPoint>) -> Void)? = nil
	public var endDragging: ((_ scrollView: UIScrollView, _ willDecelerate: Bool) -> Void)? = nil
	public var shouldScrollToTop: ((UIScrollView) -> Bool)? = nil
	public var didScrollToTop: ((UIScrollView) -> Void)? = nil
	public var willBeginDecelerating: ((UIScrollView) -> Void)? = nil
	public var endDecelerating: ((UIScrollView) -> Void)? = nil
	public var viewForZooming: ((UIScrollView) -> UIView?)? = nil
	public var willBeginZooming: ((_ scrollView: UIScrollView, _ view: UIView?) -> Void)? = nil
	public var endZooming: ((_ scrollView: UIScrollView, _ view: UIView?, _ scale: CGFloat) -> Void)? = nil
	public var didZoom: ((UIScrollView) -> Void)? = nil
	public var endScrollingAnimation: ((UIScrollView) -> Void)? = nil
	public var didChangeAdjustedContentInset: ((UIScrollView) -> Void)? = nil
}
