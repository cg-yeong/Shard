//
//  VHCollectionViewLayout.swift
//  LandScapeScrollCollectionSection
//
//  Created by root0 on 2022/06/10.
//

import UIKit

public class SectionHorizontalFlowLayout: UICollectionViewLayout {
    
    private var itemPerRow = 8
    
    convenience init(itemPerPage: Int) {
        self.init()
        itemPerRow = itemPerPage
    }
    
    
    private var boundsSize = CGSize(width: 0, height: 0)
    
    var cache : [UICollectionViewLayoutAttributes] = []
    
    var totalPage : Int           = 0
    var startSectionIndex : [Int] = []
    
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
            let sectionCount = collection.numberOfItems(inSection: key)
            
            var _ = (0 ..< sectionCount).map{ idx  in
                let indexPath = IndexPath(row: idx, section: key)
                
                guard let attr = self.computeLayoutAttributesForCellAt(indexPath: indexPath) else {
                    return
                }
                
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
        return true
    }

    func getPage(indexPath: IndexPath) -> Int? {
        
        guard let collection = self.collectionView else {
            return nil
        }
        
        let startPage = self.startSectionIndex[indexPath.section]
        let row       = indexPath.row
        
        if indexPath.row < itemPerRow {
            return startPage
        }
        
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
            let itemWidth  = bounds.size.width / CGFloat(itemPerRow)
            let itemHeight = bounds.size.height / 1
            let startWidth = CGFloat(page) * bounds.width
            
            
            // 0~ 3까지는 첫번재로우 4~ 7까지는 두번째로우
            let pos         = Int(row) % itemPerRow
            let isSecondRow = false//pos > 3 ? true : false
            let xPosition      = !isSecondRow ? CGFloat(pos) * itemWidth : (CGFloat(pos) - 4) * itemWidth
            var frame          = CGRect(x: 0, y: 0, width: itemWidth, height: itemHeight)
                frame.origin.x = startWidth + xPosition
                frame.origin.y = isSecondRow ? itemHeight : 0
                attr.frame     = frame
            
            return attr
    }
    
    
}

