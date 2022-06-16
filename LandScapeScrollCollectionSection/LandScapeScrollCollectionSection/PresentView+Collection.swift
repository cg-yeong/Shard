//
//  PresentView+Collection.swift
//  LandScapeScrollCollectionSection
//
//  Created by root0 on 2022/06/15.
//

import Foundation
import UIKit


extension PresentView: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.itemModel?.itemCategories?.count ?? 0//viewModel.mockitemCategory.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard viewModel.itemModel != nil else { return 0 }
        print("numberofItemsinSeciton")
        let filtered = viewModel.itemModel!.items!
            .filter { (model) -> Bool in
                return model.category == viewModel.itemModel!.itemCategories?[section].code && model.visibility == true && model.type != "direct"
        }
        print(filtered.count)
        return filtered.count//viewModel.mockitems[viewModel.mockitemCategory[section]]?.count ?? 0
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GiftItem.identifier, for: indexPath) as? GiftItem else { return UICollectionViewCell() }
//        guard let dataof = viewModel.mockitems[viewModel.mockitemCategory[indexPath.section]] else {
        let dataof = viewModel.filtered.filter({ (model) -> Bool in
                return model.category == itemCategories[indexPath.section].code
            }).sorted(by: { $0.sortNo < $1.sortNo })
        let data = dataof[indexPath.row]
//        cell.setConfig(model: data)
        cell.setConfig_Dal(model: data)
        
        return cell
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.setPageControl()
    }
    
    func setPageControl() {
        if let indexPath = self.itemCollectionView.indexPathsForVisibleItems.first, indexPath.section < self.itemCollectionView.numberOfSections {
            let sectionCount = self.itemCollectionView.numberOfItems(inSection: indexPath.section)
            //self.setCategoryLine(section: indexPath.section)
            // 총 페이지 카운트
            pageControl.numberOfPages = Int(ceil(Float(sectionCount) / 8))
            let row = indexPath.row
            if row < 6 {
                pageControl.currentPage = 0
            } else {
                pageControl.currentPage = row % 8 == 0 ? Int(ceil(Float(row - 1) / 8)) : (row - 1) / 8
            }
            
        }
    }
    // 선택한 인덱스가 있고 해당 인덱스로 이동할 경우
    func setPageControll(indexPath: IndexPath) {
        if indexPath.section >= self.itemCollectionView.numberOfSections {
            return
        }
        
        let sectionCount = self.itemCollectionView.numberOfItems(inSection: indexPath.section)
        
        // 총 페이지 카운트
        pageControl.numberOfPages = Int(ceil(Float(sectionCount) / 8))
        
        let row = indexPath.row
        
        if row < 8 {
            pageControl.currentPage = 0
        } else {
            pageControl.currentPage = row % 8 == 0 ? Int(ceil(Float(row - 1) / 8)) : (row - 1) / 8
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            self.itemCollectionView.scrollToItem(at: indexPath, at: .left, animated: true)
//            self.setCategoryLine(section: indexPath.section)
        })
    }
}
