//
//  KeyPadContainer.swift
//  GroupBox
//
//  Created by root0 on 8/1/24.
//

import SwiftUI
import Combine

final class KeyPadContainer<Intent, Model>: ObservableObject {
    let intent: Intent
    let model: Model

    private var cBag: Set<AnyCancellable> = []

    init(intent: Intent, model: Model, modelChangePublisher: ObjectWillChangePublisher) {
        self.intent = intent
        self.model = model

        modelChangePublisher
            .receive(on: RunLoop.main)
            .sink(receiveValue: objectWillChange.send)
            .store(in: &cBag)
    }
}
