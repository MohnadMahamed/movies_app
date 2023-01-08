import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:movies_app/movies/domain/usecases/get_search_results_usecase.dart';
import 'package:movies_app/movies/presentation/controllers/search/search_cubit.dart';

class SearchBarWidget extends StatelessWidget {
  final dynamic cubit;
  const SearchBarWidget({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) => Padding(
        padding: const EdgeInsets.only(top: 60.0, right: 15.0, left: 15.0),
        child: TextFormField(
          onFieldSubmitted: (value) {
            SearchCubit.get(context).searchMovies(SearchParameters(
                1, SearchCubit.get(context).searchController.text));
            SearchCubit.get(context).searchFocusNode.requestFocus();
            SearchCubit.get(context).putActivePageOne();
          },
          focusNode: SearchCubit.get(context).searchFocusNode,
          controller: SearchCubit.get(context).searchController,
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
          decoration: InputDecoration(
            hintText: 'Search Here'.tr,
            prefixIcon: SearchCubit.get(context).isSearch
                ? IconButton(
                    onPressed: () {
                      SearchCubit.get(context).searchFocusNode.unfocus();
                      SearchCubit.get(context).searchController.clear();
                      SearchCubit.get(context).putActivePageOne();
                      SearchCubit.get(context).searchMovies(
                          const SearchParameters(1, 'mohnadmhnmmnmzx1snmnmn'));
                    },
                    icon: Icon(
                      Icons.backspace_outlined,
                      size: 27.0,
                      color: cubit.isDark ? Colors.black54 : Colors.white70,
                    ),
                  )
                : IconButton(
                    onPressed: () {
                      ZoomDrawer.of(context)!.toggle();
                    },
                    icon: Icon(
                      Icons.menu,
                      size: 27.0,
                      color: cubit.isDark ? Colors.black54 : Colors.white70,
                    ),
                  ),
            hintStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
            filled: true,
            fillColor: cubit.isDark
                ? Colors.white.withOpacity(.7)
                : Colors.black.withOpacity(.7),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide:
                  const BorderSide(width: 0.0, color: Colors.transparent),
            ),
          ),
        ),
      ),
    );
  }
}
