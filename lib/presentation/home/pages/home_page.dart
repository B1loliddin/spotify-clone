import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotify_clone/common/helpers/check_theme_mode.dart';
import 'package:spotify_clone/common/widgets/app_bar/basic_app_bar.dart';
import 'package:spotify_clone/common/widgets/loading.dart';
import 'package:spotify_clone/core/configs/assets/app_images.dart';
import 'package:spotify_clone/core/configs/assets/app_vectors.dart';
import 'package:spotify_clone/core/configs/theme/app_colors.dart';
import 'package:spotify_clone/domain/entities/song/song_entity.dart';
import 'package:spotify_clone/presentation/home/bloc/news_songs_bloc/news_songs_bloc.dart';
import 'package:spotify_clone/presentation/home/bloc/playist/playlist_bloc.dart';
import 'package:transparent_image/transparent_image.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late final TabController tabController;

  @override
  void initState() {
    super.initState();
    _initAllControllers();
    _getNewsSongs();
    _getPlaylist();
  }

  @override
  void dispose() {
    _disposeAllControllers();
    super.dispose();
  }

  void _getNewsSongs() =>
      context.read<NewsSongsBloc>().add(const NewsSongsGetNewsSongs());

  void _getPlaylist() =>
      context.read<PlaylistBloc>().add(const PlaylistGetPlaylist());

  void _initAllControllers() {
    tabController = TabController(length: 4, vsync: this);
  }

  void _disposeAllControllers() {
    tabController.dispose();
  }

  void _navigateToSongPlayerPage(SongEntity song) => Navigator.pushNamed(
        context,
        '/song_player_page',
        arguments: song,
      );

  @override
  Widget build(BuildContext context) {
    final phonePadding = MediaQuery.of(context).padding;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: BasicAppBar(
        hideBackButton: true,
        title: SvgPicture.asset(
          AppVectors.spotifyLogo,
          width: 40,
          height: 40,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0),
        child: ListView(
          children: [
            SizedBox(height: 40),
            /// #top card
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(30)),
                    child: ColoredBox(
                      color: AppColors.primary,
                      child: SizedBox(
                        height: 160,
                        width: MediaQuery.sizeOf(context).width,
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 15,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'New Album',
                                style: TextStyle(
                                  color: AppColors.fffbfbfb,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                'Happier Than\nEver',
                                style: TextStyle(
                                  fontSize: 22,
                                  color: AppColors.fffbfbfb,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Billie Eilish',
                                style: TextStyle(
                                  color: AppColors.fffbfbfb,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: SvgPicture.asset(AppVectors.homeCardPattern),
                  ),
                  Positioned(
                    top: -38,
                    right: 50,
                    child: Transform.scale(
                      scale: 1.3,
                      child: const Image(
                        image: AssetImage(AppImages.homeArtist),
                        width: 300,
                        height: 175,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),

            /// #tab bar
            TabBar(
              controller: tabController,
              labelColor:
                  context.isDarkMode ? AppColors.ffdbdbdb : AppColors.black,
              unselectedLabelColor:
                  context.isDarkMode ? AppColors.ff616161 : AppColors.ffbebebe,
              isScrollable: true,
              dividerColor: AppColors.transparent,
              labelPadding: const EdgeInsets.only(bottom: 5, right: 50),
              indicatorColor: AppColors.primary,
              tabs: const [
                Text(
                  'News',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  'Videos',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  'Artists',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  'Podcasts',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),

            /// #tab bar songs
            SizedBox(
              height: 300,
              child: TabBarView(
                controller: tabController,
                children: [
                  /// #news songs
                  BlocBuilder<NewsSongsBloc, NewsSongsState>(
                    builder: (context, state) {
                      if (state is NewsSongsLoading) {
                        return const Loading();
                      } else if (state is NewsSongsFailure) {
                        return Center(
                          child: Text(state.message),
                        );
                      } else if (state is NewsSongsGetNewsSongsSuccess) {
                        List<SongEntity> songs = state.songs;

                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: songs.length,
                          itemBuilder: (context, index) {
                            final song = songs[index];

                            if (index == 0)  {
                              return Row(
                                children: [
                                  SizedBox(width: 30),

                                  /// #
                                  Padding(
                                    padding: const EdgeInsets.only(right: 15),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        /// #
                                        Stack(
                                          alignment: Alignment.bottomRight,
                                          children: [
                                            ClipRRect(
                                              borderRadius: const BorderRadius.all(
                                                Radius.circular(30),
                                              ),
                                              child: GestureDetector(
                                                onTap: () =>
                                                    _navigateToSongPlayerPage(song),
                                                child: FadeInImage(
                                                  placeholder: MemoryImage(
                                                    kTransparentImage,
                                                  ),
                                                  image: NetworkImage(
                                                    songs[index].coverDownloadUrl!,
                                                  ),
                                                  width: 160,
                                                  height: 220,
                                                  fit: BoxFit.fitHeight,
                                                ),
                                              ),
                                            ),

                                            /// #
                                            Transform(
                                              transform: Matrix4.translationValues(
                                                10,
                                                10,
                                                10,
                                              ),
                                              child: ClipOval(
                                                child: ColoredBox(
                                                  color: context.isDarkMode
                                                      ? AppColors.ff2c2c2c
                                                      : AppColors.ffe6e6e6,
                                                  child: const SizedBox(
                                                    width: 40,
                                                    height: 40,
                                                    child: Icon(
                                                      Icons.play_arrow_rounded,
                                                      color: AppColors.ff959595,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 15),

                                        Padding(
                                          padding: const EdgeInsets.only(left: 10),
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              /// #
                                              Text(
                                                song.title,
                                                style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              const SizedBox(height: 5),

                                              /// #
                                              Text(
                                                song.artist,
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            }

                            /// #
                            return Padding(
                              padding: const EdgeInsets.only(right: 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  /// #
                                  Stack(
                                    alignment: Alignment.bottomRight,
                                    children: [
                                      ClipRRect(
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(30),
                                        ),
                                        child: GestureDetector(
                                          onTap: () =>
                                              _navigateToSongPlayerPage(song),
                                          child: FadeInImage(
                                            placeholder: MemoryImage(
                                              kTransparentImage,
                                            ),
                                            image: NetworkImage(
                                              songs[index].coverDownloadUrl!,
                                            ),
                                            width: 160,
                                            height: 220,
                                            fit: BoxFit.fitHeight,
                                          ),
                                        ),
                                      ),

                                      /// #
                                      Transform(
                                        transform: Matrix4.translationValues(
                                          10,
                                          10,
                                          10,
                                        ),
                                        child: ClipOval(
                                          child: ColoredBox(
                                            color: context.isDarkMode
                                                ? AppColors.ff2c2c2c
                                                : AppColors.ffe6e6e6,
                                            child: const SizedBox(
                                              width: 40,
                                              height: 40,
                                              child: Icon(
                                                Icons.play_arrow_rounded,
                                                color: AppColors.ff959595,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 15),

                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        /// #
                                        Text(
                                          song.title,
                                          style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 5),

                                        /// #
                                        Text(
                                          song.artist,
                                          style: const TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      }

                      return const Loading();
                    },
                  ),

                  /// #
                  Container(color: Colors.blue),
                  Container(color: Colors.orange),
                  Container(color: Colors.red),
                ],
              ),
            ),
            const SizedBox(height: 32),

            /// #playlist text
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Playlist',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text('See More'),
                ],
              ),
            ),
            const SizedBox(height: 25),

            /// #playlist
            BlocBuilder<PlaylistBloc, PlaylistState>(
              builder: (BuildContext context, PlaylistState state) {
                if (state is PlaylistLoading) {
                  return const Loading();
                } else if (state is PlaylistFailure) {
                  return Center(
                    child: Text(state.message),
                  );
                } else if (state is PlaylistGetPlaylistSuccess) {
                  List<SongEntity> playlist = state.playlist;

                  return Padding(
                    padding: EdgeInsets.only(
                      left: 30,
                      right: 30,
                      bottom: phonePadding.bottom + 30,
                    ),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: playlist.length,
                      itemBuilder: (context, index) {
                        final song = playlist[index];

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Row(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                            children: [
                              /// #
                              Row(
                                children: [
                                  /// #
                                  ClipOval(
                                    child: ColoredBox(
                                      color: context.isDarkMode
                                          ? AppColors.ff2c2c2c
                                          : AppColors.ffe6e6e6,
                                      child: const SizedBox(
                                        width: 40,
                                        height: 40,
                                        child: Icon(
                                          Icons.play_arrow_rounded,
                                          color: AppColors.ff959595,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 20),

                                  /// #
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      /// #
                                      Text(
                                        song.title,
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 5),

                                      /// #
                                      Text(
                                        song.artist,
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),

                              Row(
                                children: [
                                  /// #
                                  Text(
                                    song.duration
                                        .toString()
                                        .replaceAll('.', ':'),
                                  ),
                                  const SizedBox(width: 40),

                                  /// #
                                  const Icon(
                                    Icons.favorite,
                                    color: AppColors.ff565656,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                }

                return const Loading();
              },
            ),
          ],
        ),
      ),
    );
  }
}
