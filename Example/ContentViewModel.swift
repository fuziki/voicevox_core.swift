//
//  ContentViewModel.swift
//
//
//  Created by fuziki on 2023/08/14¥5.
//

import Foundation
import VoicevoxCore
import libVoicevoxCore

class ContentViewModel: ObservableObject {
    @Published var data: Data? = nil

    func onAppear() {
        print("version: \(VoicevoxCore.version)")

        // OpenJtalkRc
        let dictURL = Bundle.main.resourceURL!
            .appendingPathComponent("open_jtalk_dic_utf_8-1.11")
        let ojrc = OpenJtalkRc(openJtalkDic: dictURL)

        // UserDict
        let dict = UserDict()
        let world = UserDictWord(surface: "hoge", pronunciation: "フガ")
        world.type = .commonNoun
        world.priority = 10
        let uuid = dict.add(word: world)
        print("uuid: \(uuid)")
        ojrc.use(userDict: dict)

        // Set Model Root
        let modelURL = Bundle.main.resourceURL!
            .appendingPathComponent("models")
        VoicevoxCore.set(modelsRoot: modelURL)

        // Synthesizer
        var initialize_options: VoicevoxInitializeOptions = voicevox_default_initialize_options
        initialize_options.load_all_models = true
        let synthesizer = Synthesizer(openJtalk: ojrc, options: initialize_options)

        // AudioQuery
        let aq = synthesizer.audioQuery(text: "チョリース。世界。なのだヨ！hoge", styleId: 1, options: VoicevoxAudioQueryOptions(kana: false))
        print("aq: \(aq)")

        // wav
        data = synthesizer.synthesis(audioQuery: aq, styleId: 1, options: voicevox_default_synthesis_options)

        // wav
//        data = synthesizer.textToSpeech(text: "hogeなのさ、この世界は、hoge", styleId: 1, options: voicevox_default_tts_options)
    }
}

