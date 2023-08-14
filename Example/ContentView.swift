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
        VStack(spacing: 32) {
            TextField("", text: $vm.text)
                .textFieldStyle(.roundedBorder)
            Button {
                vm.onTap()
            } label: {
                Text("読み上げる")
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
