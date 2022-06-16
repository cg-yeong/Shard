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
            return model.category == viewModel.itemModel?.itemCategories![indexPath.section].code
            }).sorted(by: { $0.sortNo < $1.sortNo })
        let data = dataof[indexPath.row]
//        cell.setConfig(model: data)
        cell.setConfig_Dal(model: data)
        
        return cell
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.setPageControl()
    }
    
    
}
