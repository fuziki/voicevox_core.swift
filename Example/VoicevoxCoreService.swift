//
//  VoicevoxCoreService.swift
//  Example
//
//  Created by fuziki on 2023/08/17.
//

import Foundation
import VoicevoxCore
import VoicevoxCoreSwift

protocol VoicevoxCoreServiceProtocol {
    func createAudioQuery(text: String) -> AudioQuery
    func synthesis(audioQuery: AudioQuery) -> Data
}

class VoicevoxCoreServiceProtocolMock: VoicevoxCoreServiceProtocol {
    func createAudioQuery(text: String) -> AudioQuery {
        .init(accentPhrases: [
            .init(moras: [
                .init(text: "コ", vowel: "", vowelLength: 0, pitch: 1),
                .init(text: "ン", vowel: "", vowelLength: 0, pitch: 8)
            ],
                  accent: 1,
                  isInterrogative: false),
            .init(moras: [
                .init(text: "デ", vowel: "", vowelLength: 0, pitch: 5),
                .init(text: "ス", vowel: "", vowelLength: 0, pitch: 5)
            ],
                  accent: 1,
                  isInterrogative: false)
        ],
              speedScale: 1,
              pitchScale: 1,
              intonationScale: 1,
              volumeScale: 1,
              prePhonemeLength: 1,
              postPhonemeLength: 1,
              outputSamplingRate: 1,
              outputStereo: false,
              kana: "")
    }
    func synthesis(audioQuery: AudioQuery) -> Data {
        .init()
    }
}

class VoicevoxCoreService: VoicevoxCoreServiceProtocol {
    let synthesizer: Synthesizer
    init() {
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
        var initialize_options: VoicevoxInitializeOptions = voicevox_make_default_initialize_options()
        initialize_options.load_all_models = true
        synthesizer = Synthesizer(openJtalk: ojrc, options: initialize_options)
    }

    func createAudioQuery(text: String) -> AudioQuery {
        synthesizer.audioQuery(text: text, styleId: 1, options: VoicevoxAudioQueryOptions(kana: false))
    }

    func synthesis(audioQuery: AudioQuery) -> Data {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        let wav = synthesizer.synthesis(audioQuery: audioQuery, styleId: 1, options: voicevox_make_default_synthesis_options())
        return wav
    }
}
