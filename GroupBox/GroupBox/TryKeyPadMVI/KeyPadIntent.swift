//
//  KeyPadIntent.swift
//  GroupBox
//
//  Created by root0 on 8/1/24.
//

import SwiftUI

protocol KeyPadIntentProtocol {
    func viewOnAppear()
}

class KeyPadIntent {
    private weak var model: KeyPadActionProtocol?

    init(model: KeyPadActionProtocol? = nil) {
        self.model = model
    }
}

extension KeyPadIntent: KeyPadIntentProtocol {
    func viewOnAppear() {
        //model?.typing(number: <#T##String#>)


    }
}
