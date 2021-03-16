//
//  PlaylistProvider.swift
//  AVFoundation_Audio
//
//  Created by Egor Badaev on 10.03.2021.
//

import Foundation

struct PlaylistProvider {
    static let playlist = [
        AudioTrack(
            artist: "Queen",
            title: "Show Must Go On",
            filename: "Queen",
            filetype: .mp3),
        AudioTrack(
            artist: "AC/DC",
            title: "Highway to Hell",
            filename: "ACDC",
            filetype: .m4a),
        AudioTrack(
            artist: "Billy Idol",
            title: "Rebel Yell",
            filename: "BillyIdol",
            filetype: .mp3),
        AudioTrack(
            artist: "Creedence Clearwater Revival",
            title: "Fortunate Son",
            filename: "CreedenceClearwaterRevival",
            filetype: .mp3),
        AudioTrack(
            artist: "Led Zeppelin",
            title: "Immigrant Song",
            filename: "LedZeppelin",
            filetype: .mp3),
        AudioTrack(
            artist: "Survivor",
            title: "Eye of the Tiger",
            filename: "Survivor",
            filetype: .mp3)
    ]
}
