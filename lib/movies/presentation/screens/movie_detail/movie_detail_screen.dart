import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:movies_app/core/animation/fade_animation.dart';
import 'package:movies_app/core/network/api_constances.dart';
import 'package:movies_app/core/services/services_lacator.dart';
import 'package:movies_app/core/theme/app_colors.dart';
import 'package:movies_app/core/utils/app_string.dart';
import 'package:movies_app/core/utils/enums.dart';
import 'package:movies_app/movies/domain/entities/genres.dart';
import 'package:movies_app/movies/presentation/controllers/app_controller/cubit/app_cubit.dart';
import 'package:movies_app/movies/presentation/controllers/auth_controller/cubit/auth_cubit.dart';
import 'package:movies_app/movies/presentation/controllers/movie_details_bloc.dart';
import 'package:movies_app/movies/presentation/widgets/custome_static_color_text.dart';
import 'package:movies_app/movies/presentation/widgets/cutome_text.dart';
import 'package:movies_app/movies/presentation/widgets/expanded_text.dart';
import 'package:shimmer/shimmer.dart';

class MovieDetailScreen extends StatelessWidget {
  final int id;
  final bool fromFavScreen;

  const MovieDetailScreen(
      {Key? key, required this.id, this.fromFavScreen = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<MovieDetailsBloc>()
        ..add(GetMovieDetailsEvent(id))
        ..add(GetMovieRecommendationEvent(id)),
      child: Scaffold(
        body: MovieDetailContent(
          fromFavScreen: fromFavScreen,
        ),
      ),
    );
  }
}

class MovieDetailContent extends StatelessWidget {
  final bool fromFavScreen;
  final void Function()? addToFavFromSearch;

  const MovieDetailContent(
      {Key? key, this.fromFavScreen = false, this.addToFavFromSearch})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit()..onInit(),
      child: BlocBuilder<AuthCubit, AuthState>(builder: (context, state) {
        // var cubit = AuthCubit.get(context);

        return BlocBuilder<MovieDetailsBloc, MovieDetailsState>(
          builder: (context, state) {
            switch (state.movieDetailsState) {
              case RequestState.loading:
                return Center(
                  child: SizedBox(
                    height: 250.0,
                    width: 250.0,
                    child: Lottie.asset('assets/json/loading.json'),
                  ),
                );
              case RequestState.loaded:
                return CustomScrollView(
                  key: const Key('movieDetailScrollView'),
                  slivers: [
                    SliverAppBar(
                      pinned: true,
                      expandedHeight: 300.0,
                      flexibleSpace: FlexibleSpaceBar(
                        background: FadeAnimation(
                          .1,
                          child: FadeIn(
                            duration: const Duration(milliseconds: 500),
                            child: ShaderMask(
                              shaderCallback: (rect) {
                                return const LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.transparent,
                                    Colors.black,
                                    Colors.black,
                                    Colors.transparent,
                                  ],
                                  stops: [0.0, 0.5, 1.0, 1.0],
                                ).createShader(
                                  Rect.fromLTRB(
                                      0.0, 0.0, rect.width, rect.height),
                                );
                              },
                              blendMode: BlendMode.dstIn,
                              child: CachedNetworkImage(
                                height: 250,
                                width: MediaQuery.of(context).size.width,
                                imageUrl: ApiConstance.imageUrl(
                                    state.movieDetails!.backdropPath!),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: FadeInUp(
                        from: 20,
                        duration: const Duration(milliseconds: 500),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // IconButton(
                              //     onPressed: () {
                              //       AuthCubit.get(context).removeFromFavourite(
                              //           state.movieDetails!.id,
                              //           state.movieDetails!.title,
                              //           state.movieDetails!.title);
                              //     },
                              //     icon: const Icon(
                              //       Icons.remove,
                              //       size: 50.0,
                              //       color: Colors.red,
                              //     )),
                              FadeAnimation(
                                .2,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        children: [
                                          CustomeText(
                                            text: state.movieDetails!.title,
                                            size: 23.0,
                                          ),
                                          const SizedBox(height: 8.0),
                                          Row(
                                            children: [
                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  vertical: 5.0,
                                                  horizontal: 8.0,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: Colors.grey[800],
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          4.0),
                                                ),
                                                child: CustomeStaticColorText(
                                                  text: state
                                                      .movieDetails!.releaseDate
                                                      .split('-')[0],
                                                  size: 15,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              const SizedBox(width: 16.0),
                                              Row(
                                                children: [
                                                  const Icon(
                                                    Icons.star,
                                                    color: Colors.amber,
                                                    size: 20.0,
                                                  ),
                                                  const SizedBox(width: 4.0),
                                                  CustomeText(
                                                    text: (state.movieDetails!
                                                                .voteAverage /
                                                            2)
                                                        .toStringAsFixed(1),
                                                    // size: 17.0,
                                                  ),
                                                  const SizedBox(width: 4.0),
                                                  Text(
                                                    '(${state.movieDetails!.voteAverage})',
                                                    style: const TextStyle(
                                                      fontSize: 1.0,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      letterSpacing: 1.2,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(width: 16.0),
                                              CustomeText(
                                                text: _showDuration(state
                                                    .movieDetails!.runtime),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    BlocBuilder<AuthCubit, AuthState>(
                                        builder: (context, statte) {
                                      var cubit = AuthCubit.get(context);

                                      return AuthCubit.get(context).user == null
                                          ? const SizedBox(
                                              height: 50,
                                              width: 50,
                                            )
                                          : Container(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              decoration: BoxDecoration(
                                                color: AppColors.mainAppColors
                                                    .withOpacity(.3),
                                                borderRadius:
                                                    BorderRadius.circular(50.0),
                                              ),
                                              child: Center(
                                                child: InkWell(
                                                  onTap: () {
                                                    if (fromFavScreen) {
                                                      if (cubit.userModel.favIds
                                                          .contains(state
                                                              .movieDetails!
                                                              .id)) {
                                                        Navigator.pop(context);
                                                        cubit.removeFromFavourite(
                                                            state.movieDetails!
                                                                .id,
                                                            state.movieDetails!
                                                                .title,
                                                            state.movieDetails!
                                                                .posterPath!);
                                                      } else if (!(cubit
                                                          .userModel.favIds
                                                          .contains(state
                                                              .movieDetails!
                                                              .id))) {
                                                        cubit.addToFavourite(
                                                            state.movieDetails!
                                                                .id,
                                                            state.movieDetails!
                                                                .title,
                                                            state.movieDetails!
                                                                .posterPath!);
                                                      }
                                                    }

                                                    if (fromFavScreen ==
                                                        false) {
                                                      (cubit.userModel.favIds
                                                              .contains(state
                                                                  .movieDetails!
                                                                  .id))
                                                          ? cubit.removeFromFavourite(
                                                              state
                                                                  .movieDetails!
                                                                  .id,
                                                              state
                                                                  .movieDetails!
                                                                  .title,
                                                              state
                                                                  .movieDetails!
                                                                  .posterPath!)
                                                          : cubit.addToFavourite(
                                                              state
                                                                  .movieDetails!
                                                                  .id,
                                                              state
                                                                  .movieDetails!
                                                                  .title,
                                                              state
                                                                  .movieDetails!
                                                                  .posterPath!);
                                                    }
                                                  },
                                                  child: cubit.userModel.favIds
                                                          .contains(state
                                                              .movieDetails!.id)
                                                      ? Icon(
                                                          Icons.favorite,
                                                          size: 50.0,
                                                          color: Colors
                                                              .red.shade300,
                                                        )
                                                      : Icon(
                                                          Icons.favorite_border,
                                                          size: 50.0,
                                                          color: Colors
                                                              .red.shade300,
                                                        ),
                                                ),
                                              ),
                                            );
                                    }),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 20.0),
                              FadeAnimation(
                                0.3,
                                child: ExpandableTextWidget(
                                  text: state.movieDetails!.overview,
                                ),
                              ),
                              const SizedBox(height: 8.0),
                              FadeAnimation(
                                0.4,
                                child: CustomeStaticColorText(
                                  text:
                                      '${AppString.genres.tr} : ${_showGenres(state.movieDetails!.genres)}',
                                  color: AppCubit.get(context).isDark
                                      ? Colors.black54
                                      : Colors.white70,
                                  size: 20.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SliverPadding(
                      padding:
                          const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 24.0),
                      sliver: SliverToBoxAdapter(
                        child: FadeInUp(
                          from: 20,
                          duration: const Duration(milliseconds: 500),
                          child: FadeAnimation(
                            0.5,
                            child: CustomeText(
                              text: (AppString.moreLikeThis).tr,
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Tab(text: 'More like this'.toUpperCase()),
                    SliverPadding(
                      padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 24.0),
                      sliver: _showRecommendations(),
                    ),
                  ],
                );
              case RequestState.error:
                return Text(state.movieDetailsMessage);
            }
          },
        );
      }),
    );
  }

  String _showGenres(List<Genres> genres) {
    String result = '';
    for (var genre in genres) {
      result += '${genre.name}, ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }

  String _showDuration(int runtime) {
    final int hours = runtime ~/ 60;
    final int minutes = runtime % 60;

    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }

  Widget _showRecommendations() {
    return BlocBuilder<MovieDetailsBloc, MovieDetailsState>(
        builder: (context, state) {
      switch (state.movieDetailsState) {
        case RequestState.loading:
          return SizedBox(
            height: 40.0,
            width: 40.0,
            child: Lottie.asset('assets/json/loading.json'),
          );
        case RequestState.loaded:
          return SliverGrid(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final recommendation = state.recommendation[index];
                return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                MovieDetailScreen(id: recommendation.id)));
                  },
                  child: SizedBox(
                    child: FadeInUp(
                      from: 20,
                      duration: const Duration(milliseconds: 500),
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(4.0)),
                        child: FadeAnimation(
                          0.5,
                          child: CachedNetworkImage(
                            imageUrl: ApiConstance.imageUrl(
                                recommendation.backdropPath!),
                            placeholder: (context, url) => Shimmer.fromColors(
                              baseColor: Colors.grey[850]!,
                              highlightColor: Colors.grey[800]!,
                              child: Container(
                                height: 170.0,
                                width: 120.0,
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                            ),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                            height: 180.0,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
              childCount: state.recommendation.length,
            ),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
              childAspectRatio: 0.7,
              crossAxisCount: 3,
            ),
          );
        case RequestState.error:
          return Text(state.movieDetailsMessage);
      }
    });
  }
}
