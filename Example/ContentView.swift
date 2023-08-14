//
//  ContentView.swift
//  Example
//  
//  Created by fuziki on 2023/08/13
//  
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var vm = ContentViewModel()

    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
        .onAppear {
            vm.onAppear()
        }
        .onChange(of: vm.data) { data in
            guard let data else { return }
            let items = [data] as [Any]
            let activityVC = UIActivityViewController(activityItems: items, applicationActivities: nil)
            let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
            let rootVC = windowScene?.windows.first?.rootViewController
            rootVC?.present(activityVC, animated: true,completion: {})
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
