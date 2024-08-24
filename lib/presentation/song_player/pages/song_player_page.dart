import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_clone/common/widgets/app_bar/basic_app_bar.dart';
import 'package:spotify_clone/common/widgets/loading.dart';
import 'package:spotify_clone/core/configs/theme/app_colors.dart';
import 'package:spotify_clone/domain/entities/song/song_entity.dart';
import 'package:spotify_clone/presentation/song_player/bloc/song_player_cubit.dart';

class SongPlayerPage extends StatefulWidget {
  const SongPlayerPage({
    super.key,
  });

  @override
  State<SongPlayerPage> createState() => _SongPlayerPageState();
}

class _SongPlayerPageState extends State<SongPlayerPage> {
  late final SongEntity song;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    song = ModalRoute.of(context)!.settings.arguments as SongEntity;

    context.read<SongPlayerCubit>().loadSong(song.songDownloadUrl!);
  }

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes.remainder(60);
    final second = duration.inSeconds.remainder(60);

    return '${minutes.toString().padLeft(2, '0')}:${second.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        title: const Text(
          'Now playing',
        ),
        action: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.more_vert_rounded),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 25),

              /// #cover
              SizedBox(
                height: 350,
                width: MediaQuery.sizeOf(context).width,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(30)),
                    image: DecorationImage(
                      image: NetworkImage(song.coverDownloadUrl!),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              /// #title, artist, favorite icon
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  /// #title and artist text
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// #
                      Text(
                        song.title,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),

                      /// #
                      Text(
                        song.artist,
                        style: const TextStyle(
                          fontSize: 22,
                        ),
                      ),
                    ],
                  ),

                  /// #favorite icon
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.favorite_border_outlined,
                      size: 26,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 50),

              /// #
              BlocBuilder<SongPlayerCubit, SongPlayerState>(
                builder: (context, state) {
                  if (state is SongPlayerLoading) {
                    return Loading();
                  } else if (state is SongPlayerLoaded) {
                    return Column(
                      children: [
                        Slider(
                          value: context
                              .read<SongPlayerCubit>()
                              .songPosition
                              .inSeconds
                              .toDouble(),
                          min: 0.0,
                          max: context
                              .read<SongPlayerCubit>()
                              .songDuration
                              .inSeconds
                              .toDouble(),
                          onChangeEnd: (double value) {
                            context
                                .read<SongPlayerCubit>()
                                .seekToPosition(value);
                          },
                          onChanged: (double value) {
                            context
                                .read<SongPlayerCubit>()
                                .updateTemporaryPosition(value);
                          },
                        ),

                        /// #timeline
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              _formatDuration(
                                context.read<SongPlayerCubit>().songPosition,
                              ),
                            ),
                            Text(
                              _formatDuration(
                                context.read<SongPlayerCubit>().songDuration,
                              ),
                            ),
                          ],
                        ),

                        /// #play pause button
                        GestureDetector(
                          onTap: () {
                            context.read<SongPlayerCubit>().playOrPauseSong();
                          },
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.primary,
                            ),
                            child: SizedBox(
                              width: 60,
                              height: 60,
                              child:
                                  BlocBuilder<SongPlayerCubit, SongPlayerState>(
                                builder: (context, state) {
                                  return Icon(
                                    context
                                            .read<SongPlayerCubit>()
                                            .audioPlayer
                                            .playing
                                        ? Icons.pause
                                        : Icons.play_arrow_rounded,
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }

                  return Loading();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
