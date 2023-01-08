import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:movies_app/core/animation/fade_animation.dart';
import 'package:movies_app/core/network/api_constances.dart';
import 'package:movies_app/core/theme/app_colors.dart';
import 'package:movies_app/movies/presentation/controllers/app_controller/app_language.dart';
import 'package:movies_app/movies/presentation/controllers/app_controller/cubit/app_cubit.dart';
import 'package:movies_app/movies/presentation/controllers/search/search_cubit.dart';
import 'package:movies_app/movies/presentation/screens/drawer/favourite/empty_list.dart';
import 'package:movies_app/movies/presentation/screens/movie_detail/movie_detail_screen.dart';
import 'package:movies_app/movies/presentation/widgets/cutome_text.dart';
import 'package:im_stepper/stepper.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<int> listOfNumber(int number) {
      List<int> pageCount = [];

      for (int i = 1; i <= number; i++) {
        pageCount.add(i);
      }
      return pageCount;
    }

    return Padding(
      padding: const EdgeInsets.only(top: 170.0, left: 15.0, right: 15.0),
      child: BlocBuilder<SearchCubit, SearchState>(
        builder: (context, state) => (SearchCubit.get(context)
                    .searchMoviesList
                    .totalResults ==
                0)
            ? const EmptyList(
                text: 'No Result Movies',
              )
            : Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomeText(
                          text:
                              '${SearchCubit.get(context).searchMoviesList.totalResults} Movies'),
                      CustomeText(
                          text:
                              '${SearchCubit.get(context).searchMoviesList.totalPages} Pages'),
                    ],
                  ),
                  SingleChildScrollView(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.66,
                      child: ListView.separated(
                          shrinkWrap: true,
                          // physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) => SizedBox(
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                MovieDetailScreen(
                                                    id: SearchCubit.get(context)
                                                        .searchMoviesList
                                                        .results[index]
                                                        .id)));
                                  },
                                  child: FadeAnimation(
                                    .3 * index,
                                    child: Container(
                                      // height: 100,
                                      // width: 100,
                                      decoration: BoxDecoration(
                                        color: AppColors.mainAppColors
                                            .withOpacity(.3),
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              height: 90.0,
                                              width: 90,
                                              // padding: const EdgeInsets.all(5),
                                              clipBehavior: Clip.antiAlias,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                              ),
                                              child: CachedNetworkImage(
                                                imageUrl: ApiConstance.imageUrl(
                                                    SearchCubit.get(context)
                                                        .searchMoviesList
                                                        .results[index]
                                                        .backdropPath!),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8.0),
                                              child: CustomeText(
                                                  maxLines: 3,
                                                  text: SearchCubit.get(context)
                                                      .searchMoviesList
                                                      .results[index]
                                                      .title!),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                          separatorBuilder: (context, index) => const SizedBox(
                                height: 15,
                              ),
                          itemCount: SearchCubit.get(context)
                              .searchMoviesList
                              .results
                              .length),
                    ),
                  ),
                  // const SizedBox(height: 20.0),
                  BlocBuilder<AppCubit, AppState>(
                    builder: (contextt, state) =>
                        GetBuilder<AppLanguageController>(
                      init: Get.find<AppLanguageController>(),
                      builder: (controller) => Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          InkWell(
                              onTap: () {
                                SearchCubit.get(context).decreaseActivePage();
                              },
                              child: Center(
                                child: Icon(
                                  controller.appLanguage == 'en'
                                      ? Icons.arrow_circle_left_outlined
                                      : Icons.arrow_circle_right_outlined,
                                  size: 30.0,
                                  color: AppCubit.get(context).isDark
                                      ? Colors.black87
                                      : Colors.white70,
                                ),
                              )),
                          Expanded(
                            child: NumberStepper(
                              numbers: listOfNumber(SearchCubit.get(context)
                                  .searchMoviesList
                                  .totalPages),
                              numberStyle: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(color: Colors.white),
                              stepRadius: 17.0,
                              activeStepColor: AppColors.mainAppColors,
                              stepColor: Colors.grey[500],
                              activeStepBorderWidth: 4,
                              enableStepTapping: false,
                              enableNextPreviousButtons: false,
                              activeStep:
                                  SearchCubit.get(context).activePage - 1,
                              stepReachedAnimationDuration:
                                  const Duration(seconds: 1),
                              stepReachedAnimationEffect: Curves.easeInQuint,
                              lineDotRadius: 2.0,
                              lineColor: AppColors.mainAppColors,
                            ),
                          ),
                          InkWell(
                              onTap: () {
                                SearchCubit.get(context).increaseActivePage();
                              },
                              child: Center(
                                child: Icon(
                                  controller.appLanguage == 'en'
                                      ? Icons.arrow_circle_right_outlined
                                      : Icons.arrow_circle_left_outlined,
                                  size: 30.0,
                                  color: AppCubit.get(context).isDark
                                      ? Colors.black87
                                      : Colors.white70,
                                ),
                              )),
                        ],
                      ),
                    ),
                  ),
                  // CustomeButton(text: 'Search', onTap: () {})
                ],
              ),
      ),
    );
  }
}
