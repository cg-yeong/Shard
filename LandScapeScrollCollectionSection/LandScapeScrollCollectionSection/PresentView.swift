//
//  PresentView.swift
//  LandScapeScrollCollectionSection
//
//  Created by root0 on 2022/06/15.
//

import Foundation
import UIKit
import SnapKit
import Then
import RxSwift

class PresentView: UIView {
    
    lazy var backgroundView = UIView().then {
        $0.backgroundColor = .clear
    }
    
    lazy var itemPlateView: UIView = UIView().then {
        $0.backgroundColor = .black
    }
    
    lazy var categoryArticle: UIScrollView = UIScrollView().then { article in
//        article.isScrollEnabled = true
        article.isPagingEnabled = true
        article.showsVerticalScrollIndicator = true
        article.showsHorizontalScrollIndicator = true
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
    
    lazy var categoryLine: UIView = UIView().then {
        $0.backgroundColor = UIColor(red: 1, green: 60/255, blue: 123/255, alpha: 1)
        $0.layer.cornerRadius = 2
        $0.clipsToBounds = true
    }
    
    lazy var itemCollectionView: UICollectionView = .init(frame: .zero, collectionViewLayout: SectionHorizontalFlowLayout()).then {
        $0.decelerationRate = .fast
        $0.isPagingEnabled = true
        $0.backgroundColor = .orange
        $0.showsHorizontalScrollIndicator = false
        $0.showsVerticalScrollIndicator = false
        $0.register(GiftItem.self, forCellWithReuseIdentifier: GiftItem.identifier)
    }
    
    lazy var pageControl = UIPageControl().then {
        $0.tintColor = .white
        $0.backgroundColor = .black
    }
    lazy var pageArticle: UIView = .init().then {
        $0.addSubview(pageControl)
        $0.backgroundColor = .darkGray
        pageControl.snp.remakeConstraints {
            $0.height.equalTo(10)
            $0.center.equalToSuperview()
        }
    }
    
    lazy var bottomMenuView: UIView = UIView().then {
        $0.backgroundColor = .cyan
    }
    
    var viewModel: GiftItemViewModel = GiftItemViewModel()
    let bag = DisposeBag()
    
    var itemList: [ItemModel] = []
    var itemCategories: [ItemCategoryData] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSnapView()
        setConstraint()
        bind()
        itemCollectionView.delegate = self
        itemCollectionView.dataSource = self
        
        setPageControll(indexPath: IndexPath(row: 0, section: 0))
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    func addSnapView() {
        addSubview(backgroundView)
        addSubview(itemPlateView)
        itemPlateView.addSubview(categoryArticle)
        itemPlateView.addSubview(bottomMenuView)
        itemPlateView.addSubview(itemCollectionView)
        itemPlateView.addSubview(pageArticle)
        
    }
    
    func bind() {
        let otherTap = UITapGestureRecognizer()
        backgroundView.addGestureRecognizer(otherTap)
        otherTap.rx.event
            .bind { [weak self] _ in
                self?.isHidden = true
            }
            .disposed(by: bag)
    }
    
    func setConstraint() {
        backgroundView.snp.remakeConstraints {
            $0.edges.equalToSuperview()
        }
        itemPlateView.snp.remakeConstraints {
            $0.bottom.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.height.equalTo(203)
            $0.leading.equalToSuperview().offset(35)
        }
        
        categoryArticle.snp.remakeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
            $0.height.equalTo(36)
        }
        
        bottomMenuView.snp.remakeConstraints {
            $0.bottom.equalTo(self.safeAreaInsets.bottom).offset(-20)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(36)
            $0.width.equalToSuperview().offset(-40)
        }
        
        itemCollectionView.snp.remakeConstraints {
            $0.centerX.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
            $0.bottom.equalTo(bottomMenuView.snp.top).offset(-15)
            
            $0.top.equalTo(categoryArticle.snp.bottom).offset(4)
        }
        
//        viewModel.mockitemCategory.forEach { category in
//        itemCategories.forEach { category in
//            let category = category.value
//            let btn = UIButton()
//            btn.isUserInteractionEnabled = true
//            btn.setTitle(category, for: .normal)
//            btn.addTarget(self, action: #selector(mngStackBtn(_:)), for: .touchUpInside)
//            btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
//            btn.titleLabel?.sizeToFit()
//
//            categoryStack.addArrangedSubview(btn)
//            btn.snp.remakeConstraints { make in
//                make.height.equalToSuperview()
//                make.width.equalTo(btn.titleLabel!.snp.width).offset(10)
//            }
//        }
        setviewModelData()
        
        
        pageArticle.snp.remakeConstraints {
            $0.bottom.equalTo(bottomMenuView.snp.top)
            $0.centerX.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.top.equalTo(itemCollectionView.snp.bottom)
        }
    }
    
    
}

extension PresentView {
    @objc func mngStackBtn(_ sender: UIButton) {
//        guard viewModel.mockitemCategory.contains(sender.title(for: .normal) ?? "") else { return }
        let sectionIndex = itemCategories.map({ $0.code }).firstIndex(of: sender.title(for: .normal) ?? "") ?? 0
//        let sectionIndex = viewModel.mockitemCategory.firstIndex(of: sender.title(for: .normal) ?? "") ?? 0
        setPageControll(indexPath: IndexPath(item: 0, section: sectionIndex))
        sender.isSelected = !sender.isSelected
        if sender.state == .selected {
            sender.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        } else {
            sender.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        }
        print(sender.title(for: .normal) ?? "empty")
    }
    
    func setviewModelData() {
        guard viewModel.itemModel?.itemCategories != nil else { return }
        viewModel.itemModel?.itemCategories!.forEach { category in
            let category = category.code
            let btn = UIButton()
            btn.isUserInteractionEnabled = true
            btn.setTitle(category, for: .normal)
            btn.setTitle(category, for: .selected)
            btn.setTitleColor(.white, for: .normal)
            btn.setTitleColor(UIColor(red: 172/255, green: 172/255, blue: 172/255, alpha: 1), for: .selected)
            btn.addTarget(self, action: #selector(mngStackBtn(_:)), for: .touchUpInside)
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .regular)
            
            btn.titleLabel?.sizeToFit()
            
            
            categoryStack.addArrangedSubview(btn)
            btn.snp.remakeConstraints { make in
                make.height.equalToSuperview()
                make.width.equalTo(btn.titleLabel!.snp.width).offset(10)
            }
        }
    }
    
    func setCategoryLine(section: Int) {
//        categoryStack.arrangedSubviews.firstin
        categoryLine.snp.remakeConstraints {
            $0.width.equalTo(20)
            $0.height.equalTo(4)
            $0.bottom.equalToSuperview()
        }
    }
}
