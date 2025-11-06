// import 'package:flutter/material.dart';
// import 'package:music_player/components/drawer.dart';
// import 'package:music_player/models/provider_song.dart';
// import 'package:music_player/models/song.dart';
// import 'package:music_player/pages/song_pages.dart';
// import 'package:provider/provider.dart';
// import '';

// class HomePages extends StatefulWidget {
//   const HomePages({super.key});

//   @override
//   State<HomePages> createState() => _HomePagesState();
// }

// class _HomePagesState extends State<HomePages> {

//   late final dynamic providerSong;

//   @override
//   void initState() {
//     super.initState();

//     providerSong = Provider.of<ProviderSong>(context, listen: false);
//   }

//   void goToSong(int songIndex) {
//     providerSong.currentSongIndex = songIndex;

//   Navigator.push(context, MaterialPageRoute(builder: (context) => SongPages(),),);
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Theme.of(context).colorScheme.background,
//       appBar: AppBar(title: Text('P L A Y L I S T')),
//       drawer: MyDrawer(),
//       body: Consumer<ProviderSong>(builder:
//       (context, value, child) {
//         final List<Song> playlist = value.Playlist;
//         return ListView.builder(
//           itemCount: playlist.length,
//           itemBuilder: (context, index) {
//             final Song song = playlist[index];

//             return ListTile(
//               title: Text(song.songName),
//               subtitle: Text(song.ArtistName),
//               leading: Image.asset(song.albumArtImagePath),
//               onTap: () => goToSong(index),
//             );
//           });
//       },
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:music_player/components/drawer.dart';
import 'package:music_player/models/provider_song.dart';
import 'package:music_player/models/song.dart';
import 'package:music_player/pages/song_pages.dart';
import 'package:provider/provider.dart';

class HomePages extends StatefulWidget {
  const HomePages({super.key});

  @override
  State<HomePages> createState() => _HomePagesState();
}

class _HomePagesState extends State<HomePages> {
  void goToSong(int songIndex) {
    final provider = Provider.of<ProviderSong>(context, listen: false);
    provider.currentSongIndex = songIndex;

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SongPages()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('P L A Y L I S T')),
      drawer: MyDrawer(),
      body: Consumer<ProviderSong>(
        builder: (context, value, child) {
          if (value.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final List<Song> playlist = value.Playlist;

          return ListView.builder(
            itemCount: playlist.length,
            itemBuilder: (context, index) {
              final song = playlist[index];

              return ListTile(
                leading: song.albumArtUrl.isNotEmpty
                    ? Image.network(song.albumArtUrl, width: 50, height: 50)
                    : Image.asset(song.albumArtImagePath, width: 50, height: 50),
                title: Text(song.songName),
                subtitle: Text(song.artistName),
                onTap: () => goToSong(index),
              );
            },
          );
        },
      ),
    );
  }
}
