//
//  CameraViewModel.swift
//  Camera_demo
//
//  Created by root0 on 2022/05/19.
//

import Foundation
import RxSwift
import RxCocoa

protocol ViewModel {
    associatedtype Input
    associatedtype Output
    
    var dBag: DisposeBag { get set }
    
    func transform(input: Input) -> Output
}

class CameraViewModel: ViewModel {
    typealias Input = Void
    typealias Output = Void
    
    
    var model = Camera()
    
    
    
    var dBag = DisposeBag()
    
    init() {
        
    }
    
    func transform(input: Void) -> Void {
        
    }
    
}
