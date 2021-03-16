//
//  ViewController.swift
//  AVFoundation_Audio
//
//  Created by Niki Pavlove on 18.02.2021.
//

import UIKit
import AVFoundation

class PlayerViewController: UIViewController {
    
    private enum TrackSwitchDirection {
        case previous
        case next
    }

    // MARK: - Properties
    
    private var player = AVAudioPlayer()
    
    private lazy var playButton = AVControlButton(imageName: "play.fill", controller: self, selector: #selector(startPlaying))
    
    private lazy var stopButton = AVControlButton(imageName: "stop.fill", controller: self, selector: #selector(stopPlaying))
    
    private lazy var pauseButton: AVControlButton = {
        let pauseButton = AVControlButton(imageName: "pause.fill", controller: self, selector: #selector(pausePlaying))
        pauseButton.isHidden = true
        return pauseButton
    }()
    
    private lazy var previousButton = AVControlButton(imageName: "backward.end.fill", controller: self, selector: #selector(prevTrack))
    
    private lazy var nextButton = AVControlButton(imageName: "forward.end.fill", controller: self, selector: #selector(nextTrack))
    
    private lazy var avControlsView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 40.0
        stackView.addArrangedSubview(previousButton)
        stackView.addArrangedSubview(playButton)
        stackView.addArrangedSubview(pauseButton)
        stackView.addArrangedSubview(stopButton)
        stackView.addArrangedSubview(nextButton)
        return stackView
    }()
    
    private let trackLabel: UILabel = {
        let trackLabel = UILabel()
        trackLabel.translatesAutoresizingMaskIntoConstraints = false
        trackLabel.font = .systemFont(ofSize: 17.0, weight: .bold)
        trackLabel.textAlignment = .center
        if #available(iOS 13.0, *) {
            trackLabel.textColor = .label
        } else {
            trackLabel.textColor = .black
        }
        return trackLabel
    }()
    
    private let artistLabel: UILabel = {
        let artistLabel = UILabel()
        artistLabel.translatesAutoresizingMaskIntoConstraints = false
        artistLabel.font = .systemFont(ofSize: 14.0)
        artistLabel.textAlignment = .center
        if #available(iOS 13.0, *) {
            artistLabel.textColor = .secondaryLabel
        } else {
            artistLabel.textColor = .gray
        }
        return artistLabel
    }()
    
    private let playlist = PlaylistProvider.playlist
    private var currentTrackIndex: Int = 0 {
        didSet {
            guard playlist.indices.contains(currentTrackIndex) else {
                return
            }
            let track = playlist[currentTrackIndex]
            trackLabel.text = track.title
            artistLabel.text = track.artist
            
        }
    }
    
    //MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupUI()
        
        currentTrackIndex = 0
        loadTrack(number: currentTrackIndex)
        
    }
    
    //MARK: - Actions

    @objc private func startPlaying() {
        playTrack()
    }
    
    @objc private func stopPlaying() {
        if player.isPlaying {
            togglePlayPause()
        }
        player.stop()
        player.currentTime = 0.0
    }
    
    @objc private func pausePlaying() {
        guard player.isPlaying else {
            return
        }
        
        player.pause()
        togglePlayPause()
    }
    
    @objc private func prevTrack() {
        switchTrack(.previous)
    }
    
    @objc private func nextTrack() {
        switchTrack(.next)
    }
    
    // MARK: - Private methods
    
    private func playTrack(togglingButtonState shouldToggleButtonState: Bool = true) {
        guard !player.isPlaying else {
            return
        }
        
        player.play()
        if shouldToggleButtonState {
            togglePlayPause()
        }
    }
    
    private func switchTrack(_ direction: TrackSwitchDirection, looping: Bool = true, toggling: Bool = true) {
        var shouldPlay = true
        stopPlaying()
        currentTrackIndex = direction == .next ? currentTrackIndex + 1 : currentTrackIndex - 1
        if !playlist.indices.contains(currentTrackIndex) {
            if !looping {
                shouldPlay = false
            }
            currentTrackIndex = (direction == .next ? playlist.indices.first : playlist.indices.last) ?? 0
        }
        loadTrack(number: currentTrackIndex)
        
        if shouldPlay {
            playTrack(togglingButtonState: toggling)
        }
    }
    
    private func setupUI() {
        if #available(iOS 13.0, *) {
            view.backgroundColor = .systemBackground
        } else {
            view.backgroundColor = .white
        }
        view.addSubview(avControlsView)
        view.addSubview(trackLabel)
        view.addSubview(artistLabel)
        
        let constraints = [
            avControlsView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            avControlsView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            playButton.widthAnchor.constraint(equalToConstant: 18.0),
            pauseButton.widthAnchor.constraint(equalToConstant: 18.0),
            stopButton.widthAnchor.constraint(equalToConstant: 18.0),
            trackLabel.topAnchor.constraint(equalTo: avControlsView.bottomAnchor, constant: 32.0),
            trackLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16.0),
            trackLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16.0),
            artistLabel.topAnchor.constraint(equalTo: trackLabel.bottomAnchor, constant: 4.0),
            artistLabel.leadingAnchor.constraint(equalTo: trackLabel.leadingAnchor),
            artistLabel.trailingAnchor.constraint(equalTo: trackLabel.trailingAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)

    }
    
    private func togglePlayPause() {
        playButton.isHidden.toggle()
        pauseButton.isHidden.toggle()
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
extension PlayerViewController: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        switchTrack(.next, looping: false, toggling: false)
    }
}
