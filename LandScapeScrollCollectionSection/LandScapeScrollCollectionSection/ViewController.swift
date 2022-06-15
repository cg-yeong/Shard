//
//  ViewController.swift
//  LandScapeScrollCollectionSection
//
//  Created by root0 on 2022/06/09.
//

import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
    }
    
    lazy var plateView: UIView = UIView().then {
        $0.backgroundColor = .gray
    }
    
    lazy var firstLabel: UILabel = UILabel().then {
        $0.text = "First Init22"
        $0.textColor = .white
        $0.isUserInteractionEnabled = true
    }
    
    
    lazy var presentView: PresentView = PresentView(frame: view.frame).then {
        $0.backgroundColor = .clear.withAlphaComponent(0.5)
        $0.isUserInteractionEnabled = true
        $0.isHidden = true
    }
    
    var viewModel = GiftItemViewModel()
    
    var itemList: [ItemModel] = []
    var itemCategory: [ItemCategoryData] = []
    
    var bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        addSnapView()
        
        let openPresentView = UITapGestureRecognizer()
        firstLabel.addGestureRecognizer(openPresentView)
        
        openPresentView.rx.event
            .bind { [weak self] _ in
                guard let self = self else { return }
                print("tap \(self.viewModel.itemModel == nil)")
                guard let model = self.viewModel.itemModel else { return }
                self.presentView.isHidden = false
                self.presentView.itemCategories = model.itemCategories ?? []
                self.presentView.itemList = model.items ?? []
                self.presentView.itemCollectionView.reloadData()
            }
            .disposed(by: bag)
        
    }
    
    
    
    
    
}

