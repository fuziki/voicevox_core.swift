//
//  Synthesizer.swift
//  
//
//  Created by fuziki on 2023/08/14.
//

import Foundation
import VoicevoxCore

public class Synthesizer {
    var ptr: OpaquePointer? = nil

    public init(openJtalk: OpenJtalkRc, options: VoicevoxInitializeOptions) {
        let res = voicevox_synthesizer_new_with_initialize(openJtalk.ptr, options, &ptr)
    }

    public func audioQuery(text: String, styleId: VoicevoxStyleId, options: VoicevoxAudioQueryOptions) -> AudioQuery {
        var aq: UnsafeMutablePointer<CChar>? = nil
        let res = voicevox_synthesizer_create_audio_query(ptr,
                                                          (text as NSString).cString(using: NSUTF8StringEncoding),
                                                          styleId,
                                                          options,
                                                          &aq)
        let str = NSString(utf8String: aq!) as? String ?? ""
        return AudioQuery(json: str)
    }

    public func synthesis(audioQuery: AudioQuery, styleId: VoicevoxStyleId, options: VoicevoxSynthesisOptions) -> Data {
        var len: UInt = 0
        var out: UnsafeMutablePointer<UInt8>? = nil
        let res = voicevox_synthesizer_synthesis(ptr,
                                                 (audioQuery.json as NSString).cString(using: NSUTF8StringEncoding),
                                                 styleId,
                                                 options,
                                                 &len,
                                                 &out)
        guard let out else { return Data() }
        return Data(bytes: out, count: Int(len))
    }

    public func textToSpeech(text: String, styleId: VoicevoxStyleId, options: VoicevoxTtsOptions) -> Data {
        var len: UInt = 0
        var out: UnsafeMutablePointer<UInt8>? = nil
        let res = voicevox_synthesizer_tts(ptr,
                                           (text as NSString).cString(using: NSUTF8StringEncoding),
                                           styleId,
                                           options,
                                           &len,
                                           &out)
        guard let out else { return Data() }
        return Data(bytes: out, count: Int(len))
    }
}
