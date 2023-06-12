//
//  ViewController.swift
//  ChattingLayoutUsingColleciontView
//
//  Created by root0 on 2023/06/05.
//

import UIKit
import SnapKit
import Then

class ViewController: UIViewController {

    var chats = R.storeMemberDummyChat
    var cellCount = 0
    
    var chatCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = .init(width: 60, height: 60)
        chatCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        chatCollectionView.backgroundColor = .white
        
        self.view.addSubview(chatCollectionView)
        
        chatCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        chatCollectionView.register(YourChat.self, forCellWithReuseIdentifier: YourChat.identifier)
        if let fl = chatCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            fl.minimumLineSpacing = 0
            fl.estimatedItemSize = CGSize(width: self.chatCollectionView.frame.width, height: 28)
        }
        
        chatCollectionView.delegate = self
        chatCollectionView.dataSource = self
        
        
        
    }
    
    

    func clear() {
        chats.removeAll()
        chatCollectionView.reloadData()
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return chats.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: YourChat.identifier, for: indexPath) as! YourChat
            
        cell.bind(with: chats[indexPath.row])
            
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = chatCollectionView.bounds.width
        let estimatedheight: CGFloat = 28
        let dummyFrame = CGRect(x: 0, y: 0, width: cellWidth, height: estimatedheight)
        let dummyCell = YourChat(frame: dummyFrame)
        let estimatedSize = dummyCell.systemLayoutSizeFitting(CGSize(width: cellWidth, height: 28))
        return CGSize(width: cellWidth, height: estimatedSize.height)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print(scrollView.contentOffset)
        if scrollView == chatCollectionView {
            if scrollView.contentOffset.y <= scrollView.frame.size.height {
                
            } else {
                
                print(scrollView.contentOffset.y)
            }
        }
    }
    
}
