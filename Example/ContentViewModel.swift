//
//  ContentViewModel.swift
//
//
//  Created by fuziki on 2023/08/14¥5.
//

import AVFoundation
import Foundation
import VoicevoxCore
import libVoicevoxCore

class ContentViewModel: ObservableObject {
    @Published var text: String = "この音声はアイフォーン上で生成されているのだ。"

    var synthesizer: Synthesizer? = nil
    var player: AVAudioPlayer?

    func onTap() {
        if synthesizer == nil {
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
            synthesizer = Synthesizer(openJtalk: ojrc, options: initialize_options)
        }

        let synthesizer = synthesizer!

        let aq = synthesizer.audioQuery(text: text, styleId: 1, options: VoicevoxAudioQueryOptions(kana: false))
        let wav = synthesizer.synthesis(audioQuery: aq, styleId: 1, options: voicevox_default_synthesis_options)
//        let wav = synthesizer.textToSpeech(text: text, styleId: 1, options: voicevox_default_tts_options)

        if player?.isPlaying == true {
            player?.stop()
        }
        player = try? AVAudioPlayer(data: wav)
        player?.play()
    }
}

