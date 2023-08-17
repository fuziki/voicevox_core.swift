//
//  ContentViewModel.swift
//
//
//  Created by fuziki on 2023/08/14¥5.
//

import AVFoundation
import Foundation
import VoicevoxCore

class ContentViewModel: ObservableObject {
    @Published var text: String = ""
    @Published var audioQuery: AudioQuery

    var player: AVAudioPlayer?

    let voicevoxCoreService: VoicevoxCoreServiceProtocol

    init(voicevoxCoreService: VoicevoxCoreServiceProtocol) {
        let text = "焼肉大好き"
        self.text = text
        audioQuery = voicevoxCoreService.createAudioQuery(text: text)
        self.voicevoxCoreService = voicevoxCoreService
    }

    func updateText() {
        audioQuery = voicevoxCoreService.createAudioQuery(text: text)
    }

    func read() {
        print(audioQuery)

        let wav = voicevoxCoreService.synthesis(audioQuery: audioQuery)

        if player?.isPlaying == true {
            player?.stop()
        }
        player = try? AVAudioPlayer(data: wav)
        player?.play()
    }
}
