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
    var offsetView = UIView().then {
        $0.backgroundColor = .systemPink.withAlphaComponent(1)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = .init(width: 60, height: 60)
        chatCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        chatCollectionView.backgroundColor = .white
        chatCollectionView.contentInset = .init(top: 8, left: 0, bottom: 8, right: 0)
        self.view.addSubview(chatCollectionView)
        
        chatCollectionView.snp.makeConstraints {
            $0.edges.equalTo(self.view.safeAreaLayoutGuide)
        }
        
        chatCollectionView.register(YourChat.self, forCellWithReuseIdentifier: YourChat.identifier)
        if let fl = chatCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            fl.minimumLineSpacing = 0
            fl.estimatedItemSize = CGSize(width: self.chatCollectionView.frame.width, height: 28)
        }
        
        chatCollectionView.delegate = self
        chatCollectionView.dataSource = self
        
        self.view.addSubview(offsetView)
        offsetView.translatesAutoresizingMaskIntoConstraints = false
        offsetView.snp.makeConstraints {
            $0.width.equalTo(chatCollectionView.bounds.width)
            $0.height.equalTo(2)
            $0.leading.trailing.equalTo(chatCollectionView)
            $0.bottom.equalTo(chatCollectionView.snp.bottom)
        }
        
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
        let previPath = indexPath.row - 1
        if previPath >= 0 {
            print( chats[previPath].name == chats[indexPath.row].name )
            cell.bind(with: chats[indexPath.row], isSameWithPrev: chats[previPath].name == chats[indexPath.row].name)
        } else {
            cell.bind(with: chats[indexPath.row])
        }
        
            
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
//        print(scrollView.contentOffset.y)
        
        if scrollView == chatCollectionView {
            //let point = CGPoint(x: 0, y: 0)
            let point = CGPoint(x: 0, y: chatCollectionView.contentOffset.y + chatCollectionView.bounds.size.height)
            
            if let indexPath = chatCollectionView.indexPathForItem(at: point), let sCell = chatCollectionView.cellForItem(at: indexPath) as? YourChat {
                let dPoint = chatCollectionView.convert(CGPoint(x: 0, y: point.y - sCell.profileView.frame.size.height), to: sCell.contentView)
                //let dPoint = chatCollectionView.convert(point, to: sCell.contentView)
//                print(dPoint)
                let extraDistantProfile = sCell.container.frame.size.height - sCell.profileView.frame.size.height
                let availableDistant = min(max(0, dPoint.y), sCell.container.frame.size.height - 42.0)
                print(availableDistant)
                sCell.translateYProfileView(distant: availableDistant)
            }
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, targetContentOffsetForProposedContentOffset proposedContentOffset: CGPoint) -> CGPoint {
        <#code#>
    }
    
}
