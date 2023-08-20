//
//  VoicevoxCore.swift
//
//
//  Created by fuziki on 2023/08/14.
//

import Foundation
import VoicevoxCore

public enum VoicevoxCore {
    public static var version: String {
        (NSString(utf8String: voicevox_version) as? String) ?? "err"
    }

    public static func set(modelsRoot: URL) {
        setenv("VV_MODELS_ROOT_DIR", modelsRoot.path, 1)
    }
}
