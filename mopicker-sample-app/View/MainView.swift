//
//  ContentView.swift
//  mopicker-sample-app
//
//  Created by Ivan Obodovskyi on 19.03.2020.
//  Copyright © 2020 Ivan Obodovskyi. All rights reserved.
//

import SwiftUI


struct MainViewCore: View {
    @ObservedObject var mainViewModel: MainViewModel
    
    init(with viewModel: MainViewModel) {
        self.mainViewModel = viewModel
    }
    
    var body: some View {
        VStack {
            CategoriesView { (id) in
                self.mainViewModel.showGenreMovies(id: id)
            }
            GridView(columns: 2, items: Array(mainViewModel.moviesByGenre).filter({
                Array($0.genreIDS).contains(mainViewModel.genreID)
            }), content: { (width, height, item) in
                NavigationLink(destination: MovieDetailView(viewModel: DetailViewModel(movieId: item.id , name: item.title ))) {
                    GridCell(result: item)
                        .multilineTextAlignment(.center)
                        .lineLimit(Int.max)
                        .padding(10)
                        .shadow(radius: 15)
                        .frame(width: width, height: height, alignment: .center)
                }.buttonStyle(PlainButtonStyle())
            })
        }
    }
}

struct MainViewOpenSource: View {
    
    private var mainViewModel: MainViewModel
    
    init(with viewModel: MainViewModel) {
        self.mainViewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            MainViewCore(with: self.mainViewModel)
            .navigationBarItems(trailing: NavigationLink(destination: MovieSearchView(), label: {
                Image(uiImage: UIImage(named: "search50.png")!).resizable().frame(width: 20, height: 20)
            }))
                .navigationBarTitle("mopicker", displayMode: .inline)
        }
    }
}


struct MainViewProduction: View {
    private var mainViewModel: MainViewModel
    @Environment(\.presentationMode) var presentationMode
    
    init(with viewModel: MainViewModel) {
        self.mainViewModel = viewModel
    }
    
    var body: some View {
        MainViewCore(with: self.mainViewModel)
                .navigationBarItems(leading:  Button(action: {
                    AuthManager.shared.signOut()
                    self.presentationMode.wrappedValue.dismiss()
                }, label: {
                    Image(uiImage: UIImage(named: "signOut")!).resizable().frame(width: 20, height: 20)
                }), trailing: NavigationLink(destination: MovieSearchView(), label: {
                    Image(uiImage: UIImage(named: "search50.png")!).resizable().frame(width: 20, height: 20)
                }))
                    .navigationBarTitle("mopicker", displayMode: .inline)
    }
}


struct MainView: View {
    @ObservedObject var mainViewModel = MainViewModel()
    
    var body: some View {
        Group {
            if AppConstants.isOpenSource {
                MainViewOpenSource(with: mainViewModel)
            } else {
                MainViewProduction(with: mainViewModel)
            }
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
