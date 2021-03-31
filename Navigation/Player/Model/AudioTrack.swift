//
//  AudioTrack.swift
//  AVFoundation_Audio
//
//  Created by Egor Badaev on 10.03.2021.
//

import Foundation

enum Filetype: String {
    case mp3 = "mp3"
    case m4a = "m4a"
}

struct AudioTrack {
    var artist: String
    var title: String
    var filename: String
    var filetype: Filetype
}
