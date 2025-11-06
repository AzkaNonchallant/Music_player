class Song {
  final String songName;
  final String artistName;
  final String albumArtImagePath; // lokal
  final String albumArtUrl;       // online
  final String audioPath;         // lokal
  final String audioUrl;          // online

  Song({
    required this.songName,
    required this.artistName,
    required this.albumArtImagePath,
    required this.albumArtUrl,
    required this.audioPath,
    required this.audioUrl,
  });
}
