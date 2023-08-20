//
//  OpenJtalkRc.swift
//  
//
//  Created by fuziki on 2023/08/14.
//

import Foundation
import VoicevoxCore

public class OpenJtalkRc {
    var ptr: OpaquePointer? = nil

    public init(openJtalkDic: URL) {
        let res = voicevox_open_jtalk_rc_new(openJtalkDic.path, &ptr)
    }

    public func use(userDict: UserDict) {
        let res = voicevox_open_jtalk_rc_use_user_dict(ptr, userDict.ptr)
    }
}
