//
//  UserDict.swift
//  
//
//  Created by fuziki on 2023/08/14.
//

import Foundation
import VoicevoxCore

public class UserDict {
    var ptr: OpaquePointer? = nil
    public init() {
        ptr = voicevox_user_dict_new()
    }

    public func add(word: UserDictWord) -> UUID {
        var uuid: (UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8) = (0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
        let res = voicevox_user_dict_add_word(ptr, &word.word, &uuid)

        return withUnsafeMutableBytes(of: &uuid) { rawPointer in
            NSUUID(uuidBytes: rawPointer.baseAddress!.assumingMemoryBound(to: UInt8.self))
        } as UUID
    }
}

public enum UserDictWordType: UInt32 {
    /// 固有名詞
    case properNoun
    /// 一般名詞
    case commonNoun
    /// 動詞
    case verb
    /// 形容詞
    case adjective
    /// 接尾辞
    case suffix

    var voicevox: UInt32 {
        switch self {
        case .properNoun:
            return VOICEVOX_USER_DICT_WORD_TYPE_PROPER_NOUN.rawValue
        case .commonNoun:
            return VOICEVOX_USER_DICT_WORD_TYPE_COMMON_NOUN.rawValue
        case .verb:
            return VOICEVOX_USER_DICT_WORD_TYPE_VERB.rawValue
        case .adjective:
            return VOICEVOX_USER_DICT_WORD_TYPE_ADJECTIVE.rawValue
        case .suffix:
            return VOICEVOX_USER_DICT_WORD_TYPE_SUFFIX.rawValue
        }
    }

    public init?(voicevox: UInt32) {
        switch voicevox {
        case VOICEVOX_USER_DICT_WORD_TYPE_PROPER_NOUN.rawValue:
            self = .properNoun
        case VOICEVOX_USER_DICT_WORD_TYPE_COMMON_NOUN.rawValue:
            self = .commonNoun
        case VOICEVOX_USER_DICT_WORD_TYPE_VERB.rawValue:
            self = .verb
        case VOICEVOX_USER_DICT_WORD_TYPE_ADJECTIVE.rawValue:
            self = .adjective
        case VOICEVOX_USER_DICT_WORD_TYPE_SUFFIX.rawValue:
            self = .suffix
        default:
            return nil
        }
    }
}

public class UserDictWord {
    public var type: UserDictWordType {
        didSet {
            word.word_type = VoicevoxUserDictWordType(type.voicevox)
        }
    }

    public var priority: UInt32 {
        didSet {
            word.priority = priority
        }
    }

    var word: VoicevoxUserDictWord

    public init(surface: String, pronunciation: String) {
        word = voicevox_user_dict_word_make((surface as NSString).cString(using: NSUTF8StringEncoding),
                                            (pronunciation as NSString).cString(using: NSUTF8StringEncoding))
        type = .init(voicevox: UInt32(word.word_type)) ?? .properNoun
        priority = word.priority
    }
}
