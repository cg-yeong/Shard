//
//  TinderSwipeView.swift
//  practiveUIPageViewController
//
//  Created by root0 on 2023/05/02.
//

import UIKit

let inset: CGFloat = 10

public protocol TInderSwipeViewDelegate: NSObject {
    
    func dummyAnimationDone()
    func currentCardStatus(card: Any, distance: CGFloat)
    func fallbackCard(model: Any)
    func didSelectCard(model: Any)
    func cardGoesLeft(model: Any)
    func cardGoesRight(model: Any)
    func undoCardsDone(model: Any)
    func endOfCardsReached()
    
}

public class TinderSwipeView<Element>: UIView {
    
    var bufferSize: Int = 5 {
        didSet {
            bufferSize = bufferSize > 5 ? 5 : bufferSize
        }
    }
    public var seperatorDistance: CGFloat = 8
    var index = 0
    
    fileprivate var allCards = [Element]()
    fileprivate var loadedCards = [TinderCard]()
    fileprivate var currentCard: TinderCard!
    
    public weak var delegate: TInderSwipeViewDelegate?
    
    fileprivate let contentView: ContentView?
    public typealias ContentView = (_ index: Int, _ frame: CGRect, _ element: Element) -> (UIView)
    
    public init(frame: CGRect,
                contentView: @escaping ContentView, bufferSize : Int = 3) {
        self.contentView = contentView
        self.bufferSize = bufferSize
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
