import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:movies_app/core/animation/fade_animation.dart';
import 'package:movies_app/core/network/api_constances.dart';
import 'package:movies_app/core/utils/enums.dart';
import 'package:movies_app/movies/presentation/controllers/movies_bloc.dart';
import 'package:movies_app/movies/presentation/controllers/movies_state.dart';
import 'package:movies_app/movies/presentation/screens/movie_detail/movie_detail_screen.dart';
import 'package:movies_app/movies/presentation/widgets/custome_static_color_text.dart';

class NowPlayingComponent extends StatelessWidget {
  const NowPlayingComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoviesBloc, MoviesState>(
      buildWhen: (previous, current) =>
          previous.nowPlayingState != current.nowPlayingState,
      builder: (context, state) {
        switch (state.nowPlayingState) {
          case RequestState.loading:
            return SizedBox(
              height: 400.0,
              child: Center(
                child: SizedBox(
                  height: 200.0,
                  width: 200.0,
                  child: Lottie.asset('assets/json/loading.json'),
                ),
              ),
            );
          case RequestState.loaded:
            return FadeIn(
              duration: const Duration(milliseconds: 500),
              child: CarouselSlider(
                options: CarouselOptions(
                  height: 500.0,
                  viewportFraction: 1.0,
                  onPageChanged: (index, reason) {},
                ),
                items: state.nowPlayingMovies.map(
                  (item) {
                    return GestureDetector(
                      key: const Key('openMovieMinimalDetail'),
                      onTap: () {
                        // AuthCubit.get(context).addToFavourite(FavouriteModel(
                        //     id: item.id,
                        //     title: item.title,
                        //     backdropPath: item.backdropPath));

                        // AuthCubit.get(context).addToFavourite(
                        //     item.id, item.title, item.backdropPath);

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    MovieDetailScreen(id: item.id)));
                      },
                      child: Stack(
                        children: [
                          ShaderMask(
                            shaderCallback: (rect) {
                              return const LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  // fromLTRB
                                  Colors.transparent,
                                  Colors.black,
                                  Colors.black,
                                  Colors.transparent,
                                ],
                                stops: [0, 0.3, 0.5, 1],
                              ).createShader(
                                Rect.fromLTRB(0, 0, rect.width, rect.height),
                              );
                            },
                            blendMode: BlendMode.dstIn,
                            child: FadeAnimation(
                              0.1,
                              child: CachedNetworkImage(
                                height: 560.0,
                                imageUrl:
                                    ApiConstance.imageUrl(item.backdropPath!),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          // Align(
                          //   alignment: Alignment.center,
                          //   child: IconButton(
                          //       onPressed: () {

                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) =>
                          //             const FavouriteScreen()));
                          //       },
                          //       icon: const Icon(
                          //         Icons.favorite,
                          //         size: 50,
                          //         color: Colors.red,
                          //       )),
                          // ),

                          Padding(
                            padding: const EdgeInsets.only(bottom: 30.0),
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 16.0),
                                    child: FadeAnimation(
                                      0.2,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Padding(
                                            padding:
                                                EdgeInsets.only(bottom: 5.0),
                                            child: Icon(
                                              Icons.circle,
                                              color: Colors.redAccent,
                                              size: 18.0,
                                            ),
                                          ),
                                          const SizedBox(width: 4.0),
                                          CustomeStaticColorText(
                                            color: Colors.white,
                                            size: 20.0,
                                            text: 'Now Playing'.tr,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 16.0),
                                    child: FadeAnimation(
                                      .3,
                                      child: CustomeStaticColorText(
                                        color: Colors.white,
                                        text: item.title,
                                        size: 22.0,
                                        // textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ).toList(),
              ),
            );
          case RequestState.error:
            return SizedBox(
              height: 400,
              child: Text(
                state.nowPlayingMessage,
              ),
            );
        }
      },
    );
  }
}
