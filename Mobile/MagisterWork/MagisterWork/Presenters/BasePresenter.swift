//
//  BasePresenter.swift
//

import Foundation

class BasePresenter: ObservableObject {
    private var isFirstTimeAppear = true
    
    func onFirstTimeAppear() {}
    
    func onAppear() {
        if (isFirstTimeAppear) {
            isFirstTimeAppear = false
            onFirstTimeAppear()
        }
    }
    
    func onDisappear() {}
}
