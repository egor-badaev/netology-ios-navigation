//
//  RecorderViewController.swift
//  Navigation
//
//  Created by Egor Badaev on 22.03.2021.
//  Copyright © 2021 Egor Badaev. All rights reserved.
//

import UIKit
import AVFoundation

class RecorderViewController: UIViewController {
    
    //MARK: - Properties
    
    private static let defaultButtonTitle = "Start recording"
    
    private lazy var recordButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "record.circle.fill"), for: .normal)
        button.setTitle(RecorderViewController.defaultButtonTitle, for: .normal)
        if #available(iOS 13.0, *) {
            button.setTitleColor(.label, for: .normal)
            
        } else {
            button.setTitleColor(.black, for: .normal)
        }
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 0)
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        button.addTarget(self, action: #selector(recordButtonTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var playButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "play.fill"), for: .normal)
        button.setTitle("Play recording", for: .normal)
        if #available(iOS 13.0, *) {
            button.setTitleColor(.label, for: .normal)
            button.tintColor = .label
        } else {
            button.setTitleColor(.black, for: .normal)
            button.tintColor = .black
        }
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 0)
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        button.isHidden = true
        button.addTarget(self, action: #selector(playButtonTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var avContainer: UIStackView = {
        let containerView = UIStackView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.axis = .vertical
        containerView.spacing = 10.0
        
        containerView.addArrangedSubview(recordButton)
        containerView.addArrangedSubview(playButton)
        
        return containerView
    }()
    
    private lazy var goToSettingsButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Перейти в настройки", for: .normal)
        button.addTarget(self, action: #selector(goToSettingsButtonTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var noPermissionsView: UIStackView = {
        let containerView = UIStackView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.axis = .vertical
        containerView.spacing = 10.0
        
        let headerLabel = UILabel()
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        headerLabel.numberOfLines = 0
        headerLabel.textAlignment = .center
        headerLabel.font = .systemFont(ofSize: 17.0, weight: .semibold)
        headerLabel.text = "Отсутствуют разрешения на запись аудио"
        containerView.addArrangedSubview(headerLabel)

        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 14.0)
        if #available(iOS 13.0, *) {
            label.textColor = .secondaryLabel
        } else {
            label.textColor = .darkGray
        }
        label.text = "Перейдите в настройки, чтобы предоставить разрешения"
        containerView.addArrangedSubview(label)
        
        containerView.addArrangedSubview(goToSettingsButton)
        
        return containerView
    }()
    
    private var recordingSession = AVAudioSession.sharedInstance()
    private var audioRecorder: AVAudioRecorder!
    private var player: AVAudioPlayer!
    private let audioFilename: URL = {
        let documentsPaths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectoryURL = documentsPaths[0]
        let audioFilename = documentsDirectoryURL.appendingPathComponent("recording.m4a")
        
        return audioFilename
    }()
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        handleRecordPermissionsRequest()
    }
    
    //MARK: - Actions
    
    @objc private func recordButtonTapped(_ sender: UIButton) {
        if(audioRecorder == nil) {
            startRecording()
        } else {
            finishRecording(success: true)
        }
        
    }
    
    @objc private func playButtonTapped(_ sender: UIButton) {
        if player == nil {
            playRecording()
        } else {
            stopPlayback()
        }
    }
    
    @objc private func goToSettingsButtonTapped(_ sender: UIButton) {
        guard let url = URL(string:UIApplication.openSettingsURLString) else { return }
        if UIApplication.shared.canOpenURL(url){
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            let alert = AlertFactory.makeInfoAlert(title: "Непредвиденная ошибка", message: "Невозможно перейти в настройки")
            self.present(alert, animated: true) { [weak self] in
                self?.goToSettingsButton.isHidden = true
            }
        }
    }
    
    //MARK: - UI
    
    private func setupUI() {
        if #available(iOS 13.0, *) {
            view.backgroundColor = .systemBackground
        } else {
            view.backgroundColor = .white
        }
    }
    
    private func showNoPermissionsUI() {
        view.addSubview(noPermissionsView)
        let constraints = [
            noPermissionsView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: AppConstants.margin),
            noPermissionsView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -AppConstants.margin),
            noPermissionsView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    private func showRecordingUI() {
        view.addSubview(avContainer)

        let constraints = [
            avContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: AppConstants.margin),
            avContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -AppConstants.margin),
            avContainer.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    //MARK: - Player
    
    private func playRecording() {
        do {
            player = try AVAudioPlayer(contentsOf: audioFilename)
            player.delegate = self
            player.play()
            
            playButton.setImage(UIImage(named: "stop.fill"), for: .normal)
            playButton.setTitle("Stop playback", for: .normal)
        }
        catch {
            let alert = AlertFactory.makeErrorAlert("Невозможно проиграть файл")
            self.present(alert, animated: true) { [unowned self] in
                self.stopPlayback()
            }
        }
    }
    
    private func stopPlayback() {
        player.stop()
        player = nil
        
        playButton.setImage(UIImage(named: "play.fill"), for: .normal)
        playButton.setTitle("Play recording", for: .normal)
    }
    
    //MARK: - AVAudioRecorder
    
    private func handleRecordPermissionsRequest() {
        do {
            try recordingSession.setCategory(.playAndRecord, mode: .default)
            try recordingSession.setActive(true)
            recordingSession.requestRecordPermission() { [unowned self] allowed in
                DispatchQueue.main.async {
                    if allowed {
                        self.showRecordingUI()
                    } else {
                        self.showNoPermissionsUI()
                    }
                }
            }
        } catch {
            self.showNoPermissionsUI()
        }
    }
    
    private func startRecording() {
        
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        
        do {
            audioRecorder = try AVAudioRecorder(url: audioFilename, settings: settings)
            audioRecorder.delegate = self
            audioRecorder.record()
            
            recordButton.setTitle("Stop recording", for: .normal)
        } catch {
            finishRecording(success: false)
        }
    }
    
    private func finishRecording(success: Bool) {
        audioRecorder.stop()
        audioRecorder = nil

        if success {
            recordButton.setTitle("Re-record", for: .normal)
            playButton.isHidden = false
        } else {
            let alert = AlertFactory.makeErrorAlert("Не удалось записать аудио!")
            self.present(alert, animated: true) { [unowned self] in
                self.recordButton.setTitle(RecorderViewController.defaultButtonTitle, for: .normal)
                playButton.isHidden = true
            }
        }
    }
}

//MARK: - AVAudioRecorderDelegate
extension RecorderViewController: AVAudioRecorderDelegate {
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if(!flag) {
            finishRecording(success: flag)
        }
    }
}

//MARK: - AVAudioPlayerDelegate
extension RecorderViewController: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        stopPlayback()
    }
}
