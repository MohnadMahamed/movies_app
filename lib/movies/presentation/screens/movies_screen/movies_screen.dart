import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:movies_app/core/animation/fade_animation.dart';
import 'package:movies_app/core/services/services_lacator.dart';
import 'package:movies_app/core/utils/app_string.dart';
import 'package:movies_app/movies/presentation/screens/components/now_playing_component.dart';
import 'package:movies_app/movies/presentation/screens/components/popular_component.dart';
import 'package:movies_app/movies/presentation/screens/components/top_rarted_component.dart';
import 'package:movies_app/movies/presentation/controllers/app_controller/cubit/app_cubit.dart';
import 'package:movies_app/movies/presentation/controllers/movies_bloc.dart';
import 'package:movies_app/movies/presentation/controllers/movies_event.dart';
import 'package:movies_app/movies/presentation/controllers/search/search_cubit.dart';
import 'package:movies_app/movies/presentation/screens/search_screen/search_screen.dart';
import 'package:movies_app/movies/presentation/widgets/cutome_text.dart';
import 'package:movies_app/movies/presentation/widgets/search_bar_widget.dart';

class MoviesScreen extends StatelessWidget {
  const MoviesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = AppCubit.get(context);
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    debugPrint('object');
    return BlocProvider(
      create: (context) => sl<MoviesBloc>()
        ..add(GetNowPlayingMoviesEvent())
        ..add(GetPopularMoviesEvent())
        ..add(GetTopRatedMoviesEvent()),
      child: Scaffold(
        key: scaffoldKey,
        body: SingleChildScrollView(
          key: const Key('movieScrollView'),
          child: BlocBuilder<SearchCubit, SearchState>(
            builder: (context, state) => Stack(
              children: [
                SearchCubit.get(context).isSearch
                    ? const SearchScreen()
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const NowPlayingComponent(),
                          Container(
                            margin: const EdgeInsets.fromLTRB(
                                16.0, 24.0, 16.0, 8.0),
                            child: InkWell(
                              onTap: () {},
                              child: FadeAnimation(
                                .4,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomeText(
                                      text: (AppString.popular).tr,
                                      size: 20.0,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0),
                                      child: Row(
                                        children: [
                                          CustomeText(
                                            text: (AppString.seeMore).tr,
                                          ),
                                          const SizedBox(
                                            width: 3.0,
                                          ),
                                          Icon(Icons.arrow_forward_ios,
                                              size: 18.0,
                                              color: cubit.isDark
                                                  ? Colors.black54
                                                  : Colors.white70),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const PopularComponent(),
                          Container(
                            margin: const EdgeInsets.fromLTRB(
                              16.0,
                              24.0,
                              16.0,
                              8.0,
                            ),
                            child: FadeAnimation(
                              .6,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomeText(
                                    text: (AppString.topRated).tr,
                                    size: 20.0,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0),
                                    child: Row(
                                      children: [
                                        CustomeText(
                                          text: (AppString.seeMore).tr,
                                        ),
                                        const SizedBox(
                                          width: 3.0,
                                        ),
                                        Icon(Icons.arrow_forward_ios,
                                            size: 18.0,
                                            color: cubit.isDark
                                                ? Colors.black54
                                                : Colors.white70),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const FadeAnimation(.7, child: TopRatedComponent()),
                          const SizedBox(height: 50.0),
                        ],
                      ),
                FadeAnimation(1, child: SearchBarWidget(cubit: cubit)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget buildFloatingSearchBar(BuildContext context) {
  //   return Padding(
  //     padding: const EdgeInsets.only(top: 60.0, right: 15.0, left: 15.0),
  //     child: Container(
  //       // height: 30,
  //       // padding: const EdgeInsets.symmetric(horizontal: 10),
  //       width: double.infinity,
  //       decoration: BoxDecoration(
  //         borderRadius: BorderRadius.circular(10.0),
  //         // color: (AppCubit.get(context).isDark)
  //         //     ? Colors.white.withOpacity(.6)
  //         //     : Colors.red.withOpacity(.6),
  //       ),
  //       child: TextFormField(
  //         focusNode: AppCubit.get(context).searchFocusNode,
  //         decoration: InputDecoration(
  //           hintText: 'Search Here',
  //           prefixIcon: AppCubit.get(context).isSearch
  //               ? IconButton(
  //                   onPressed: () {
  //                     AppCubit.get(context).searchFocusNode.unfocus();
  //                   },
  //                   icon: Icon(
  //                     Icons.backspace_outlined,
  //                     size: 30.0,
  //                     color: (AppCubit.get(context).isDark)
  //                         ? Colors.black54
  //                         : Colors.white,
  //                   ),
  //                 )
  //               : IconButton(
  //                   onPressed: () {
  //                     ZoomDrawer.of(context)!.toggle();
  //                   },
  //                   icon: Icon(
  //                     Icons.menu,
  //                     size: 30.0,
  //                     color: (AppCubit.get(context).isDark)
  //                         ? Colors.black54
  //                         : Colors.white,
  //                   ),
  //                 ),
  //           hintStyle: TextStyle(
  //               color: AppCubit.get(context).isDark
  //                   ? Colors.black45
  //                   : Colors.white70,
  //               fontSize: 16,
  //               fontWeight: FontWeight.w600),
  //           filled: true,
  //           // fillColor: Colors.amber,
  //           fillColor: (AppCubit.get(context).isDark)
  //               ? Colors.white.withOpacity(.6)
  //               : Colors.red.withOpacity(.6),
  //           border: OutlineInputBorder(
  //             borderRadius: BorderRadius.circular(10.0),
  //           ),
  //           enabledBorder: OutlineInputBorder(
  //             borderRadius: BorderRadius.circular(10.0),
  //             borderSide:
  //                 const BorderSide(width: 0.0, color: Colors.transparent),
  //           ),
  //         ),
  //       ),
  //     ),
  //     // child: Row(
  //     //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //     //   children: [
  //     //     IconButton(
  //     //       onPressed: () {
  //     //         ZoomDrawer.of(context)!.toggle();
  //     //       },
  //     //       icon: Icon(
  //     //         Icons.menu,
  //     //         size: 30.0,
  //     //         color: (AppCubit.get(context).isDark)
  //     //             ? Colors.black54
  //     //             : Colors.white,
  //     //       ),
  //     //     ),
  //     //     TextButton(
  //     //         onPressed: () {
  //     //           Navigator.push(
  //     //               context,
  //     //               MaterialPageRoute(
  //     //                   builder: (context) => const SearchScreen()));
  //     //         },
  //     //         child: const CustomeText(
  //     //           text: 'Search For a movie',
  //     //           size: 20.0,
  //     //         )),
  //     //   ],
  //     // ),
  //   );
  // }

}
