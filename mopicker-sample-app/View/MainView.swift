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
            GeometryReader { (parentGeometry) in
                GridView(columns: 2, items: Array(self.mainViewModel.moviesByGenre).filter({
                    Array($0.genreIDS).contains(self.mainViewModel.genreID)
                }), content: { (childGeo, width, height, item) in
                    NavigationLink(destination: MovieDetailView(viewModel: DetailViewModel(movieId: item.id , name: item.title ))) {
                            GridCell(result: item)
                            .multilineTextAlignment(.center)
                            .lineLimit(Int.max)
                            .padding(10)
                            .shadow(radius: 15)
                            .frame(width: width, height: height, alignment: .center)
                                
                        }.buttonStyle(PlainButtonStyle())
                    .onFrameChange({ (frame) in
                        if frame.midY - parentGeometry.frame(in: .global).midY < 600 {
                            self.mainViewModel.loadMoreMovies(currentItem: item)
                            print("fire off request")
                        }
                        print(frame.midY - parentGeometry.frame(in: .global).midY)
                        print("PARENT: \(parentGeometry.frame(in: .global).minY), \n CHILD: \(childGeo.frame(in: .global).minY)")
                    }, enabled: item.id == self.mainViewModel.moviesByGenre.last?.id)
                })
            }
        }
    }
}

extension View {

    func onFrameChange(_ frameHandler: @escaping (CGRect)->(),
                    enabled isEnabled: Bool = true) -> some View {

        guard isEnabled else { return AnyView(self) }

        return AnyView(self.background(GeometryReader { (geometry: GeometryProxy) in

            Color.clear.beforeReturn {

                frameHandler(geometry.frame(in: .global))
            }
        }))
    }

    private func beforeReturn(_ onBeforeReturn: ()->()) -> Self {
        onBeforeReturn()
        return self
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
