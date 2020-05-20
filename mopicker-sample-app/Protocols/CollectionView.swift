//
//  CollectionView.swift
//  mopicker-sample-app
//
//  Created by Ivan Obodovskyi on 23.03.2020.
//  Copyright © 2020 Ivan Obodovskyi. All rights reserved.
//

import SwiftUI

struct CollectionView<T: CollectionViewPresentable>: UIViewRepresentable {    
    var viewModel: T
    
    public func makeUIView(context: UIViewRepresentableContext<CollectionView<T>>) -> UICollectionView {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: viewModel.layout)
        viewModel.setup(collectionView)
        
        return collectionView
    }
    
    public func updateUIView(_ uiView: UICollectionView, context: UIViewRepresentableContext<CollectionView<T>>) {
        uiView.reloadData()
    }
}
