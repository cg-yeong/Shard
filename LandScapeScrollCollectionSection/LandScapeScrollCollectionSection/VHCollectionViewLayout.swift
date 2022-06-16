//
//  VHCollectionViewLayout.swift
//  LandScapeScrollCollectionSection
//
//  Created by root0 on 2022/06/10.
//

import UIKit

public class SectionHorizontalFlowLayout: UICollectionViewFlowLayout {
    
    override init() {
        super.init()
//        itemPerRow = UIDevice.current.orientation.isLandscape ? itemPerRow : itemPerRow / 2
    }
    
    convenience init(itemPerPage: Int) {
        self.init()
        itemPerRow = itemPerPage
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var itemPerRow = 8
    
    private var boundsSize = CGSize(width: 0, height: 0)
    
    var cache : [UICollectionViewLayoutAttributes] = []
    
    var totalPage : Int           = 0
    var startSectionIndex : [Int] = [] // 전체 페이지인덱스중 각 섹션의 시작 인덱스
    
    public override func prepare() {
        
        guard cache.isEmpty , let collection = collectionView else {
            return
        }
        
        // 실제 인덱스
        var pageIndexCount : [Int] = []
        
        totalPage = (0 ..< collection.numberOfSections).reduce(0){start, new in
            let sectionCount = collection.numberOfItems(inSection: new)
            // 8이 넘는 경우 한페이지를 추가 해줘야한다
            let pageCnt      = Int(ceil(Float(sectionCount) / Float(itemPerRow)))
                // 0부터 시작하므로 하나씩 줄여준다
                pageIndexCount.append(pageCnt - 1)
            return start + pageCnt
        }
        
        let _ = pageIndexCount.reduce(0){ start, new in
            startSectionIndex.append(start)
            return start + new + 1
        }
        
        boundsSize = collection.bounds.size
        
        var _ = (0 ..< collection.numberOfSections).enumerated().map{ key, val in
            let sectionCount = collection.numberOfItems(inSection: key) // key번 섹션의 item 수
            
            var _ = (0 ..< sectionCount).map{ idx  in // key섹션의 idx번 아이템을
                let indexPath = IndexPath(row: idx, section: key) // indexPath화해서
                
                // layoutAttribute들을 구한다
                guard let attr = self.computeLayoutAttributesForCellAt(indexPath: indexPath) else {
                    return
                }
                
                // 그리고 cache에 순서대로 저장
                cache.append(attr)
            }
        }
    }
    
    public override var collectionViewContentSize: CGSize {
        return CGSize(width: CGFloat(totalPage) * boundsSize.width, height: boundsSize.height)
    }
    
    public override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return self.cache
    }
    
    public override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        
        return computeLayoutAttributesForCellAt(indexPath: indexPath)
    }
    
    public override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        guard let collectionView = collectionView else {
            return false
        }
        
        let oldSize = collectionView.bounds.size
        guard oldSize != newBounds.size else { return false }
        cache.removeAll()
        // cache 지우면 prepare
        return true
    }
    
    
    func getPage(indexPath: IndexPath) -> Int? {
        
        guard let collection = self.collectionView else {
            return nil
        }
        
        let startPage = self.startSectionIndex[indexPath.section]
        let row       = indexPath.row // 0 ~
        
        if indexPath.row < itemPerRow {
            // 인자로 들어온 indexPath.section 내에서 1페이지당 표시해야 할 item 갯수보다 적으면 startPage 그대로
            return startPage
        }
        
        // 추가페이지 구하기
        let current = row % itemPerRow == 0 ? Int(ceil(Float(row - 1) / Float(itemPerRow))) : (row - 1) / itemPerRow
        
        return current + startPage
    }
    
    //TODO: 범용으로 만들어보기
    private func computeLayoutAttributesForCellAt( indexPath : IndexPath)
        -> UICollectionViewLayoutAttributes? {
            guard let page = self.getPage(indexPath: indexPath) else {
                return nil
            }
            
            let row    = CGFloat(indexPath.row)
            let bounds = self.collectionView!.bounds
            let attr   = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            
            // 사이즈
            let itemWidth = bounds.width / CGFloat(itemPerRow)
            let itemHeight = bounds.size.height / 1
            let startWidth = CGFloat(page) * bounds.width
            
            
            // 0~ 3까지는 첫번재로우 4~ 7까지는 두번째로우
            let pos         = Int(row) % itemPerRow
            var isSecondRow = false//pos > 3 ? true : false
            if UIDevice.current.orientation.isLandscape {
                isSecondRow = false
            }
            let xPosition      = !isSecondRow ? CGFloat(pos) * itemWidth : (CGFloat(pos) - 4) * itemWidth
            var frame          = CGRect(x: 0, y: 0, width: itemWidth, height: itemHeight)
                frame.origin.x = startWidth + xPosition
                frame.origin.y = isSecondRow ? itemHeight : 0
                attr.frame     = frame
            
            return attr
    }
    
    
}

