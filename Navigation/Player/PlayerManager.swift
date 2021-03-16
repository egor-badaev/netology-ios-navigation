//
//  PlayerManager.swift
//  Navigation
//
//  Created by Egor Badaev on 17.03.2021.
//  Copyright © 2021 Egor Badaev. All rights reserved.
//

import Foundation
import AVFoundation

protocol PlayerManagerDelegate: AnyObject {
    func setTrack(_ track: AudioTrack)
    func togglePlayPause()
}

class PlayerManager: NSObject {

    enum TrackSwitchDirection {
        case previous
        case next
    }

    static let shared: PlayerManager = {
        let instance = PlayerManager()
        return instance
    }()
    
    weak var delegate: PlayerManagerDelegate?

    private lazy var player: AVAudioPlayer = {
        let player = AVAudioPlayer()
        return player
    }()
    private let playlist = PlaylistProvider.playlist
    private var currentTrackIndex: Int = 0 {
        didSet {
            guard playlist.indices.contains(currentTrackIndex) else {
                return
            }
            let track = playlist[currentTrackIndex]
            
            delegate?.setTrack(track)
            
        }
    }
    
    func setup() {
        currentTrackIndex = 0
        loadTrack(number: currentTrackIndex)
    }
    
    func startPlayback(updatingPlayPause shouldToggleButtonState: Bool = true) {
        guard !player.isPlaying else {
            return
        }
        
        player.play()
        if shouldToggleButtonState {
            delegate?.togglePlayPause()
        }
    }

    func pausePlayback() {
        guard player.isPlaying else {
            return
        }
        
        player.pause()
        delegate?.togglePlayPause()
    }
    
    func stopPlayback() {
        if player.isPlaying {
            delegate?.togglePlayPause()
        }
        player.stop()
        player.currentTime = 0.0

    }
    
    func switchTrack(_ direction: TrackSwitchDirection, looping: Bool = true, toggling: Bool = true) {
        var shouldPlay = true
        stopPlayback()
        currentTrackIndex = direction == .next ? currentTrackIndex + 1 : currentTrackIndex - 1
        if !playlist.indices.contains(currentTrackIndex) {
            if !looping {
                shouldPlay = false
            }
            currentTrackIndex = (direction == .next ? playlist.indices.first : playlist.indices.last) ?? 0
        }
        loadTrack(number: currentTrackIndex)
        
        if shouldPlay {
            startPlayback(updatingPlayPause: toggling)
        }
    }

    private func loadTrack(number index: Int) {
        guard playlist.indices.contains(index) else {
            return
        }
        
        let audioTrack = playlist[index]
        
        do {
            player = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: audioTrack.filename, ofType: audioTrack.filetype.rawValue)!))
            player.delegate = self
            player.prepareToPlay()
        }
        catch {
            print(error)
        }
    }
}

//MARK: - AVAudioPlayerDelegate

extension PlayerManager: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        switchTrack(.next, looping: false, toggling: false)
    }
}
