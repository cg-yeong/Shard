//
//  ViewController.swift
//  LandScapeScrollCollectionSection
//
//  Created by root0 on 2022/06/09.
//

import UIKit
import SnapKit
import Then

class ViewController: UIViewController {
    
    lazy var plateView: UIView = UIView().then {
        $0.backgroundColor = .gray
    }
    
    lazy var firstLabel: UILabel = UILabel().then {
        $0.text = "First Init22"
        $0.textColor = .white
    }
    
    lazy var itemPlateView: UIView = UIView().then {
        $0.backgroundColor = .black
    }
    
    lazy var categoryArticle: UIScrollView = UIScrollView().then { article in
        article.isScrollEnabled = true
        article.showsVerticalScrollIndicator = true
        article.showsHorizontalScrollIndicator = true
        article.backgroundColor = .green
        article.addSubview(categoryStack)
        categoryStack.snp.remakeConstraints {
            $0.leading.trailing.top.bottom.equalTo(article.contentLayoutGuide)
            $0.width.lessThanOrEqualTo(article.frameLayoutGuide).priority(.low)
            $0.height.equalToSuperview()
        }
    }
    lazy var categoryStack: UIStackView = UIStackView().then {
        $0.spacing = 0
        $0.axis = .horizontal
        $0.alignment = .center
        $0.distribution = .equalSpacing
    }
    lazy var itemCollectionView: UICollectionView = .init(frame: .zero, collectionViewLayout: SectionHorizontalFlowLayout()).then {
        $0.backgroundColor = .orange
        $0.showsHorizontalScrollIndicator = true
        $0.showsVerticalScrollIndicator = false
        $0.register(GiftItem.self, forCellWithReuseIdentifier: GiftItem.identifier)
    }
    
    lazy var bottomMenuView: UIView = UIView().then {
        $0.backgroundColor = .cyan
    }
    
    var viewModel: GiftItemViewModel = GiftItemViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        addSnapView()
        itemCollectionView.delegate = self
        itemCollectionView.dataSource = self
        
    }
    
    @objc func mngStackBtn(_ sender: UIButton) {
        guard viewModel.itemCategory.contains(sender.title(for: .normal) ?? "") else { return }
        print(sender.title(for: .normal) ?? "empty")
    }
    
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.itemCategory.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.items[viewModel.itemCategory[section]]?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GiftItem.identifier, for: indexPath) as? GiftItem else { return UICollectionViewCell() }
        guard let dataof = viewModel.items[viewModel.itemCategory[indexPath.section]] else {
            return UICollectionViewCell()
        }
        let data = dataof[indexPath.row]
        cell.setConfig(model: data)
        
        return cell
    }
    
    
}
