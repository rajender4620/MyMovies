import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mymovies_app/mymovies_cubits/dashboard/cubit/movies_homepage_cubit.dart';
import 'package:mymovies_app/mymovies_cubits/dashboard/widgets/movies_listpage.dart';
import 'package:mymovies_app/utils/loading_page.dart';

class MovieHomePageView extends StatelessWidget {
  const MovieHomePageView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoviesHomepageCubit, MoviesHomepageState>(
      builder: (context, state) {
        if (state is MoviesHomepageInitial || state is MoviesHomepageLoading) {
          context.read<MoviesHomepageCubit>().init();
          return const Material(child: LoadingPage());
        } else if (state is MoviesHomepageFailed) {
          return const Material(
            child: Center(child: Text('Something went wrong')),
          );
        } else if (state is MoviesHomepageLoaded) {
          return SafeArea(
            child: Material(
              child: MoviesListpages(loadedstate: state),
            ),
          );
        }
        return Material(
          child: Container(),
        );
      },
    );
  }
}
