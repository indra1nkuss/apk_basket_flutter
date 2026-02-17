import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/foundation.dart';  // Tambah ini untuk debugPrint

class AudioManager {
  // ==========================================
  // Singleton pattern
  // ==========================================
  static final AudioManager _instance = AudioManager._internal();
  factory AudioManager() => _instance;
  AudioManager._internal();

  // ==========================================
  // State variables
  // ==========================================
  bool _isMusicEnabled = true;
  bool _isSfxEnabled = true;
  double _musicVolume = 0.7;
  double _sfxVolume = 1.0;

  // ==========================================
  // Getters
  // ==========================================
  bool get isMusicEnabled => _isMusicEnabled;
  bool get isSfxEnabled => _isSfxEnabled;
  double get musicVolume => _musicVolume;
  double get sfxVolume => _sfxVolume;

  // ==========================================
  // Initialize
  // ==========================================
  Future<void> initialize() async {
    try {
      await FlameAudio.audioCache.loadAll([
        'music/background_music.mp3',
        'sfx/collect.mp3',
        'sfx/explosion.mp3',
        'sfx/jump.mp3',
      ]);
      debugPrint('Audio initialized successfully');  // Ganti print
    } catch (e) {
      debugPrint('Error initializing audio: $e');    // Ganti print
    }
  }

  // ==========================================
  // Background Music
  // ==========================================
  void playBackgroundMusic() {
    if (_isMusicEnabled) {
      try {
        FlameAudio.bgm.play('music/background_music.mp3', volume: _musicVolume);
      } catch (e) {
        debugPrint('Error playing background music: $e');  // Ganti print
      }
    }
  }

  void stopBackgroundMusic() {
    try {
      FlameAudio.bgm.stop();
    } catch (e) {
      debugPrint('Error stopping background music: $e');  // Ganti print
    }
  }

  void pauseBackgroundMusic() {
    try {
      FlameAudio.bgm.pause();
    } catch (e) {
      debugPrint('Error pausing background music: $e');  // Ganti print
    }
  }

  void resumeBackgroundMusic() {
    if (_isMusicEnabled) {
      try {
        FlameAudio.bgm.resume();
      } catch (e) {
        debugPrint('Error resuming background music: $e');  // Ganti print
      }
    }
  }

  // ==========================================
  // Sound Effects
  // ==========================================
  void playSfx(String fileName) {
    if (_isSfxEnabled) {
      try {
        FlameAudio.play('sfx/$fileName', volume: _sfxVolume);
        debugPrint('Playing SFX: $fileName');  // Ganti print
      } catch (e) {
        debugPrint('Error playing SFX: $e');    // Ganti print
      }
    }
  }

  void playSfxWithVolume(String fileName, double volume) {
    if (_isSfxEnabled) {
      try {
        final adjustedVolume = (volume * _sfxVolume).clamp(0.0, 1.0);
        FlameAudio.play('sfx/$fileName', volume: adjustedVolume);
      } catch (e) {
        debugPrint('Error playing SFX with volume: $e');  // Ganti print
      }
    }
  }

  // ==========================================
  // Volume Control
  // ==========================================
  void setMusicVolume(double volume) {
    _musicVolume = volume.clamp(0.0, 1.0);
    try {
      FlameAudio.bgm.audioPlayer.setVolume(_musicVolume);
    } catch (e) {
      debugPrint('Error setting music volume: $e');  // Ganti print
    }
  }

  void setSfxVolume(double volume) {
    _sfxVolume = volume.clamp(0.0, 1.0);
  }

  // ==========================================
  // Toggle & Enable/Disable
  // ==========================================
  void toggleMusic() {
    _isMusicEnabled = !_isMusicEnabled;
    if (_isMusicEnabled) {
      resumeBackgroundMusic();
    } else {
      pauseBackgroundMusic();
    }
  }

  void toggleSfx() {
    _isSfxEnabled = !_isSfxEnabled;
  }

  void enableMusic() {
    if (!_isMusicEnabled) {
      _isMusicEnabled = true;
      resumeBackgroundMusic();
    }
  }

  void disableMusic() {
    if (_isMusicEnabled) {
      _isMusicEnabled = false;
      pauseBackgroundMusic();
    }
  }

  void enableSfx() {
    _isSfxEnabled = true;
  }

  void disableSfx() {
    _isSfxEnabled = false;
  }

  // ==========================================
  // Cleanup
  // ==========================================
  void dispose() {
    try {
      FlameAudio.bgm.dispose();
    } catch (e) {
      debugPrint('Error disposing audio: $e');  // Ganti print
    }
  }
}