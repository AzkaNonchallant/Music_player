// import 'package:audioplayers/audioplayers.dart';
// import 'package:flutter/material.dart';
// import 'package:music_player/models/song.dart';

// class ProviderSong extends ChangeNotifier {
//   final List<Song> _playlist = [
    
//     Song(songName: "I wish I was Your Joke", ArtistName: "Reality Club", albumArtImagePath: "assets/images/i_wish_i_was.jpg" , audioPath: "mp3/i_wish.mp3",),

//     Song(songName: "Love Ephiaphny", ArtistName: "Reality Club", albumArtImagePath: "assets/images/ephi.jpg", audioPath: "mp3/love_ephi.mp3",),
    
//   ];

//   int? _currentSongIndex;

//   final AudioPlayer _audioPlayer = AudioPlayer();

//   Duration _currentDuration = Duration.zero;
//   Duration _totalDuration = Duration.zero;

  
//   ProviderSong(){
//     listenToDuration();
//   }

//   bool _isPlaying = false;

//   void play() async {
//     final String path = _playlist[_currentSongIndex!].audioPath;
//     await _audioPlayer.stop();
//     await _audioPlayer.play(AssetSource(path));
//     _isPlaying = true;
//     notifyListeners();
//   }

//   void pause() async {
//     await _audioPlayer.pause();
//     _isPlaying = false;
//     notifyListeners();
//   }

//   void resume() async {
//     await _audioPlayer.resume();
//     _isPlaying = true;
//     notifyListeners();
//   }

//   void PauseOrResume() async {
//     if (_isPlaying) {
//       pause();
//     }else {
//       resume();
//     }

//     notifyListeners();
//   }

//   void seek(Duration position) async {
//     await _audioPlayer.seek(position);
//   }

//   void playNextSong() {
//     if (_currentSongIndex != null) {
//       if (_currentSongIndex! < _playlist.length -1) {
//         currentSongIndex = _currentSongIndex! + 1;
//       }else {
//         currentSongIndex = 0;
//       }
//     }
//   } 

//   void playPreviousSong() async {
//     if(_currentDuration.inSeconds > 2) {
//       seek(Duration.zero);
//     }else {
//       if (_currentSongIndex! > 0) {
//         currentSongIndex = _currentSongIndex! - 1;
//       } else {
//         currentSongIndex = _playlist.length -1;
//       }
//     }
//   }


//   void listenToDuration() {
//     _audioPlayer.onDurationChanged.listen((newDuration) {
//       _totalDuration = newDuration;
//       notifyListeners();
//     });

//     _audioPlayer.onPositionChanged.listen((newPosition){
//       _currentDuration = newPosition;
//       notifyListeners();
//     });

//     _audioPlayer.onPlayerComplete.listen((event){playNextSong();});
//   }

//   List<Song> get Playlist => _playlist;
//   int? get currentSongIndex => _currentSongIndex;
//   bool get isPlaying => _isPlaying;
//   Duration get currentDuration => _currentDuration;
//   Duration get totalDuration => _totalDuration;


//   set currentSongIndex(int? newIndex) {
//     _currentSongIndex = newIndex;

//     if (newIndex != null) {
//       play();
//     }

//     notifyListeners();
//   }
// }

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:http/http.dart' as http;
import 'song.dart';

class ProviderSong extends ChangeNotifier {
  final AudioPlayer _audioPlayer = AudioPlayer();

  // 🔹 Awalnya berisi lagu lokal
  final List<Song> _playlist = [
    Song(
      songName: "I Wish I Was Your Joke",
      artistName: "Reality Club",
      albumArtImagePath: "assets/images/i_wish_i_was.jpg",
      audioPath: "mp3/i_wish.mp3",
      albumArtUrl: "",
      audioUrl: "",
    ),
    Song(
      songName: "Love Epiphany",
      artistName: "Reality Club",
      albumArtImagePath: "assets/images/ephi.jpg",
      audioPath: "mp3/love_ephi.mp3",
      albumArtUrl: "",
      audioUrl: "",
    ),
  ];

  int? _currentSongIndex;
  bool _isPlaying = false;
  bool _isLoading = false;

  Duration _currentDuration = Duration.zero;
  Duration _totalDuration = Duration.zero;

  ProviderSong() {
    listenToDuration();
    fetchSongs(); // 🔸 ambil data dari Deezer saat app jalan
  }

  // -----------------------------------
  // 🔹 AMBIL LAGU ONLINE DARI DEEZER API
  // -----------------------------------
  Future<void> fetchSongs() async {
    _isLoading = true;
    notifyListeners();
    try {
      final response = await http.get(
        Uri.parse(
            'https://api.codetabs.com/v1/proxy/?quest=https://api.deezer.com/chart'),
        headers: {'User-Agent': 'FlutterApp/1.0'},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> tracks = data['tracks']['data'];

        // 🔸 Tambahkan ke playlist lama (bukan ganti)
        for (var song in tracks) {
          _playlist.add(
            Song(
              songName: song['title'] ?? 'Unknown',
              artistName: song['artist']['name'] ?? 'Unknown Artist',
              albumArtImagePath: "", // karena ini online
              albumArtUrl: song['album']['cover_medium'] ?? "",
              audioPath: "", // lokal kosong
              audioUrl: song['preview'] ?? "",
            ),
          );
        }

        print("✅ Berhasil ambil ${tracks.length} lagu dari Deezer");
      } else {
        print("❌ Gagal ambil data: ${response.statusCode}");
      }
    } catch (e) {
      print("⚠️ Error fetchSongs: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // -----------------------------------
  // 🔹 PLAYBACK (Lokal & Online)
  // -----------------------------------
  void play() async {
    if (_currentSongIndex == null) return;
    final song = _playlist[_currentSongIndex!];

    await _audioPlayer.stop();

    // 🔸 Kalau punya file lokal, pakai AssetSource
    if (song.audioPath.isNotEmpty) {
      await _audioPlayer.play(AssetSource(song.audioPath));
      _isPlaying = true;
    }
    // 🔸 Kalau lagu online
    else if (song.audioUrl.isNotEmpty) {
      await _audioPlayer.play(UrlSource(song.audioUrl));
      _isPlaying = true;
    } else {
      debugPrint('No audio source for ${song.songName}');
    }

    notifyListeners();
  }

  void pause() async {
    await _audioPlayer.pause();
    _isPlaying = false;
    notifyListeners();
  }

  void resume() async {
    await _audioPlayer.resume();
    _isPlaying = true;
    notifyListeners();
  }

  void PauseOrResume() {
    if (_isPlaying) {
      pause();
    } else {
      resume();
    }
  }

  void seek(Duration position) async {
    await _audioPlayer.seek(position);
  }

  void playNextSong() {
    if (_currentSongIndex == null) return;
    if (_currentSongIndex! < _playlist.length - 1) {
      currentSongIndex = _currentSongIndex! + 1;
    } else {
      currentSongIndex = 0;
    }
  }

  void playPreviousSong() {
    if (_currentDuration.inSeconds > 2) {
      seek(Duration.zero);
    } else {
      if (_currentSongIndex! > 0) {
        currentSongIndex = _currentSongIndex! - 1;
      } else {
        currentSongIndex = _playlist.length - 1;
      }
    }
  }

  void listenToDuration() {
    _audioPlayer.onDurationChanged.listen((newDuration) {
      _totalDuration = newDuration;
      notifyListeners();
    });
    _audioPlayer.onPositionChanged.listen((newPosition) {
      _currentDuration = newPosition;
      notifyListeners();
    });
    _audioPlayer.onPlayerComplete.listen((event) => playNextSong());
  }

  // -----------------------------------
  // 🔹 GETTERS & SETTERS
  // -----------------------------------
  List<Song> get Playlist => _playlist;
  int? get currentSongIndex => _currentSongIndex;
  bool get isPlaying => _isPlaying;
  bool get isLoading => _isLoading;
  Duration get currentDuration => _currentDuration;
  Duration get totalDuration => _totalDuration;

  set currentSongIndex(int? newIndex) {
    _currentSongIndex = newIndex;
    if (newIndex != null) {
      play();
    }
    notifyListeners();
  }
}
