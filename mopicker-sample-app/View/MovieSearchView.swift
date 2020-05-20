//
//  MovieSearchView.swift
//  mopicker-sample-app
//
//  Created by Ivan Obodovskyi on 05.05.2020.
//  Copyright © 2020 Ivan Obodovskyi. All rights reserved.
//

import SwiftUI
import Combine

struct MovieSearchView: View {
    
    @ObservedObject var viewModel: MovieSearchViewModel = MovieSearchViewModel()
    
    var body: some View {
            VStack {
                HStack {
                    Image(systemName: "magnifyingglass")
                    TextField("Search", text: $viewModel.searchQuiery) {
                        self.endEditing()
                    }.onTapGesture {
                        self.endEditing()
                    }
                    if !viewModel.searchQuiery.isEmpty {
                        Button(action: { 
                            self.viewModel.searchQuiery = ""
                        }) {
                            Image(systemName: "xmark.circle.fill")
                        }
                    } else {
                        EmptyView()
                    }
                }
                .padding(.all, 10)
                List {
                    if viewModel.searchResult == nil {
                        Text("")
                    } else if viewModel.searchQuiery.isEmpty {
                        Text("")
                    } else {
                        ForEach(viewModel.searchResult!) { result in
                            NavigationLink(destination: MovieDetailView(viewModel: DetailViewModel(movieId: result.id, name: result.title))) {
                                Text(result.title)
                            }
                        }
                    }
                }
            }
    }
}

struct MovieSearchView_Previews: PreviewProvider {
    static var previews: some View {
        Text("Privet")
    }
}


struct HiddenNavigationLink<Destination : View>: View {

    public var destination:  Destination
    public var isActive: Binding<Bool>

    var body: some View {

        NavigationLink(destination: self.destination, isActive: self.isActive)
        { EmptyView() }
            .frame(width: 0, height: 0)
            .disabled(true)
            .hidden()
    }
}

struct ActivateButton<Label> : View where Label : View {

    public var activates: Binding<Bool>
    public var label: Label

    public init(activates: Binding<Bool>, @ViewBuilder label: () -> Label) {
        self.activates = activates
        self.label = label()
    }

    var body: some View {
        Button(action: { self.activates.wrappedValue = true }, label: { self.label } )
    }
}
