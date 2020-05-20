//
//  GridCellViewModel.swift
//  mopicker-sample-app
//
//  Created by Ivan Obodovskyi on 29.04.2020.
//  Copyright © 2020 Ivan Obodovskyi. All rights reserved.
//

import Combine
import SwiftUI

final class GridCellViewModel: ObservableObject {
    
    private var didChange = PassthroughSubject<Data, Never>()
    private var imageURLString: String
    private var networkingManager = NetworkingManager.shared
    
    @Published var imageData: Data = Data() {
        didSet {
            self.didChange.send(imageData)
        }
    }
    
    init(imageURL: String) {
        self.imageURLString = imageURL
        fetchImageData(url: imageURL)
    }
    
    private func fetchImageData(url: String) {
        networkingManager.requestImageData(ConstantNamespaces.requestOriginalImage + url) { [weak self] (imageData) in
            DispatchQueue.main.async {
                self?.imageData = imageData
            }
        }
    }
    
}
