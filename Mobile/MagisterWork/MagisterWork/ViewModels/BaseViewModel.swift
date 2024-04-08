//
//  BaseViewModel.swift
//

import Foundation

class BaseViewModel: ObservableObject {
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
