import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moviedb_app/bloc/cast_movie/castmovie_cubit.dart';
import 'package:moviedb_app/bloc/detail_movies/detailmovie_cubit.dart';
import 'package:moviedb_app/bloc/popular_movies/popularmovie_cubit.dart';
import 'package:moviedb_app/bloc/search_movie/searchmovie_cubit.dart';
import 'package:moviedb_app/bloc/top_rated_movies/topratedmovie_cubit.dart';
import 'package:moviedb_app/bloc/upcoming_movies/upcomingmovie_cubit.dart';
import 'package:moviedb_app/pages/home/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.black,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => PopularMovieCubit()..getPopularMovies(),
        ),
        BlocProvider(
          create: (context) => TopRatedMovieCubit()..getTopRatedMovies(),
        ),
        BlocProvider(
          create: (context) => UpcomingMovieCubit()..getUpcomingMovies(),
        ),
        BlocProvider(
          create: (context) => DetailMovieCubit(),
        ),
        BlocProvider(
          create: (context) => CastMovieCubit(),
        ),
        BlocProvider(
          create: (context) => SearchmovieCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.red,
          textTheme: GoogleFonts.latoTextTheme(
            Theme.of(context).textTheme,
          ),
        ),
        home: const HomePage(),
      ),
    );
  }
}
