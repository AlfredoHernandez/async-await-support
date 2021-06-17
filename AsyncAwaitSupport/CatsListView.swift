//
//  Copyright © 2021 Jesús Alfredo Hernández Alarcón. All rights reserved.
//

import SwiftUI

struct CatsView: View {
    @State var cats: [Cat] = []
    let loader = RemoteCatsLoader()

    var body: some View {
        NavigationView {
            if #available(iOS 15.0, *) {
                CatsListView(cats: cats).task(loadAsyncCats)
            } else {
                CatsListView(cats: cats).onAppear(perform: loadCats)
            }
        }
    }
    
    @available(iOS 15.0, *)
    private func loadAsyncCats() async {
        do {
            let result = try await loader.load()
            self.cats = result
        } catch {
            print("Error: \(error)")
        }
    }
    
    private func loadCats() {
        loader.load { result in
            if case let .success(cats) = result {
                self.cats = cats
            }
        }
    }
}

struct CatsListView: View {
    let cats: [Cat]

    var body: some View {
        List(cats) { cat in
            HStack {
                Image("cat", bundle: .main)
                    .resizable()
                    .clipShape(Circle())
                    .shadow(radius: 2)
                    .frame(width: 64, height: 64, alignment: .center)
                VStack(alignment: .leading) {
                    HStack(spacing: 4) {
                        Text("Cat name:")
                            .fontWeight(.bold)
                        Text(cat.name)
                    }
                    HStack(spacing: 4) {
                        Text("Cat id:")
                            .fontWeight(.bold)
                        Text(cat.id)
                    }
                }
            }
        }
        .listStyle(DefaultListStyle())
        .navigationTitle(Text("Async Await"))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CatsView()
    }
}
