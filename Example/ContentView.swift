//
//  ContentView.swift
//  Example
//  
//  Created by fuziki on 2023/08/13
//  
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var vm: ContentViewModel

    var body: some View {
        VStack(spacing: 32) {
            TextField("", text: $vm.text)
                .textFieldStyle(.roundedBorder)
            Button {
                vm.updateText()
            } label: {
                Text("テキストを更新")
            }
            Button {
                vm.read()
            } label: {
                Text("読み上げる")
            }
            ScrollView(.horizontal) {
                HStack(spacing: 24) {
                    ForEach(0..<vm.audioQuery.accentPhrases.count, id: \.self) { i in
                        HStack(spacing: 0) {
                            ForEach(0..<vm.audioQuery.accentPhrases[i].moras.count, id: \.self) { j in
                                VStack {
                                    Text(vm.audioQuery.accentPhrases[i].moras[j].text)
                                    Slider(value: $vm.audioQuery.accentPhrases[i].moras[j].pitch, in: 3...7)
                                        .frame(width: 256, height: 48)
                                        .rotationEffect(.degrees(-90))
                                        .frame(width: 48, height: 256)
                                }
                            }
                        }
                    }
                }
            }
        }
        .padding(.horizontal, 8)
        .frame(maxHeight: .infinity)
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(vm: .init(voicevoxCoreService: VoicevoxCoreServiceProtocolMock()))
    }
}
