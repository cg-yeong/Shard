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
        article.addSubview(categoryLine)
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
        
        viewModel.im.bind { [weak self] _ in
            guard let self = self else { return }
            print("알리얄라")
            self.setviewModelData()
        }.disposed(by: bag)
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
        //setviewModelData()
        
        
        pageArticle.snp.remakeConstraints {
            $0.bottom.equalTo(bottomMenuView.snp.top)
            $0.centerX.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.top.equalTo(itemCollectionView.snp.bottom)
        }
    }
    
    
}

extension PresentView {
    
    func setPageControl() {
        if let indexPath = self.itemCollectionView.indexPathsForVisibleItems.first, indexPath.section < self.itemCollectionView.numberOfSections {
            let sectionCount = self.itemCollectionView.numberOfItems(inSection: indexPath.section)
            self.setCategoryLine(section: indexPath.section)
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
            self.setCategoryLine(section: indexPath.section)
        })
    }
    
    @objc func mngStackBtn(_ sender: UIButton) {
        let sectionIndex = viewModel.itemModel?.itemCategories!.map({ $0.code }).firstIndex(of: sender.title(for: .normal) ?? "") ?? 0
        setPageControll(indexPath: IndexPath(item: 0, section: sectionIndex))
        
//        categoryLine.snp.remakeConstraints {
//            $0.width.equalTo(20)
//            $0.height.equalTo(4)
//            $0.centerX.equalTo(sender)
//            $0.bottom.equalTo(sender)
//        }
        print(sender.title(for: .normal) ?? "empty")
    }
    
    func setviewModelData() {
        guard viewModel.itemModel?.itemCategories != nil else { return }
        viewModel.itemModel?.itemCategories!.enumerated().forEach { idx, val in
            
            let category = val.code
            let btn = UIButton()
            btn.tag = 450 + idx + 1
            btn.isUserInteractionEnabled = true
            btn.setTitle(category, for: .normal)
            btn.setTitleColor(UIColor(red: 172/255, green: 172/255, blue: 172/255, alpha: 1), for: .normal)
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
        guard let categoryBtn = categoryStack.viewWithTag(451 + section) as? UIButton else { return }
        
        categoryStack.arrangedSubviews.enumerated().forEach { [weak self] idx, uiv in
            guard let cateBtn = uiv as? UIButton else { return }
            if idx == section {
                cateBtn.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .bold)
                cateBtn.setTitleColor(.white, for: .normal)
            } else {
                cateBtn.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .regular)
                cateBtn.setTitleColor(UIColor(red: 172/255, green: 172/255, blue: 172/255, alpha: 1), for: .normal)
            }
        }
        categoryLine.snp.remakeConstraints {
            $0.width.equalTo(20)
            $0.height.equalTo(4)
            $0.centerX.equalTo(categoryBtn)
            $0.bottom.equalTo(categoryBtn)
        }
    }
}
