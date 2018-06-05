//
//  BoomCell.swift
//  Boom
//
//  Created by 李二狗 on 2018/6/5.
//

import Foundation

// MARK: CELL PROTOCOL (implemented by UICollectionViewCell)

public protocol BoomCell: class {
    static var reuseIdentifier: String { get }
    static var registerAsClass: Bool { get }
}

public extension BoomCell {
    /// By default the identifier of the cell is the same name of the cell.
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    /// Return true if you want to allocate the cell via class name using classic
    /// `initWithFrame`/`initWithCoder`. If your cell UI is defined inside a nib file
    /// or inside a storyboard you must return `false`.
    static var registerAsClass : Bool {
        return false
    }
}

// MARK: HEADER/FOOTER PROTOCOL (implemented by UICollectionReusableView)

public protocol HeaderFooterProtocol: class {
    static var reuseIdentifier: String { get }
    static var registerAsClass: Bool { get }
}

public extension HeaderFooterProtocol {
    /// By default the identifier of the cell is the same name of the cell.
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    /// Return true if you want to allocate the cell via class name using classic
    /// `initWithFrame`/`initWithCoder`. If your cell UI is defined inside a nib file
    /// or inside a storyboard you must return `false`.
    static var registerAsClass : Bool {
        return false
    }
}

// MARK: ABSTRACT PROTOCOLS

public protocol AbstractAdapterProtocol {
    var modelType: Any.Type { get }
    var cellType: Any.Type { get }
    var cellReuseIdentifier: String { get }
    var cellClass: AnyClass { get }
    var registerAsClass: Bool { get }
}

// MARK: BoomModel

public protocol BoomModel {
    func isEqual(to other: BoomModel) -> Bool
    var identifier: Int { get }
}

extension BoomModel where Self: Equatable {
    public func isEqual(to other: BoomModel) -> Bool {
        guard let other = other as? Self else {
            return false
        }
        return self == other
    }
}

extension BoomModel where Self: Hashable {
    public var hashValue: Int {
        return self.identifier.hashValue
    }
}
