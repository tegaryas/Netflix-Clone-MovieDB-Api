import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:moviedb_app/bloc/popular_movies/popularmovie_cubit.dart';
import 'package:moviedb_app/bloc/top_rated_movies/topratedmovie_cubit.dart';
import 'package:moviedb_app/bloc/upcoming_movies/upcomingmovie_cubit.dart';
import 'package:moviedb_app/config/config.dart';
import 'package:moviedb_app/models/movie_model.dart';
import 'package:moviedb_app/pages/detail/detail_page.dart';
import 'package:moviedb_app/pages/search/search_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentCarousel = 0;

  void _onPressMovie(int? movieId) {
    if (movieId != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DetailMoviePage(
            movieId: movieId,
          ),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
  }

  Future<void> _onRefresh() async {
    context.read<TopRatedMovieCubit>().getTopRatedMovies();
    context.read<UpcomingMovieCubit>().getUpcomingMovies();
    context.read<PopularMovieCubit>().getPopularMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leadingWidth: 80,
        leading: Padding(
          padding: const EdgeInsets.only(
            left: 20,
          ),
          child: Image.network(
            Config.baseImageUrl + "/wwemzKWzjKYJFfCeiB57q3r4Bcm.png",
            fit: BoxFit.fitWidth,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.cast_outlined,
              size: 24,
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SearchMoviePage(),
                ),
              );
            },
            icon: const Icon(
              Icons.search,
              size: 25,
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        color: Colors.red,
        child: SingleChildScrollView(
          child: Column(
            children: [
              BlocBuilder<PopularMovieCubit, PopularMovieState>(
                builder: (context, state) {
                  if (state is PopularMovieLoading) {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height * 0.6,
                      child: const Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.white,
                          ),
                        ),
                      ),
                    );
                  } else if (state is PopularMovieLoaded) {
                    return Stack(
                      children: [
                        _buildCarouselSlider(state.popularMovies),
                        _buildDotIndicator(state.popularMovies)
                      ],
                    );
                  } else {
                    return const Text("Data Failed");
                  }
                },
              ),
              const SizedBox(
                height: 20,
              ),
              BlocBuilder<UpcomingMovieCubit, UpcomingMovieState>(
                builder: (context, state) {
                  if (state is UpcomingMovieLoading) {
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15.0,
                          ),
                          child: Row(
                            children: const [
                              Text(
                                "Film Terbaru",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.3,
                          child: Center(
                            child: Transform.scale(
                              scale: 0.7,
                              child: const CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  } else if (state is UpcomingMovieLoaded) {
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15.0,
                          ),
                          child: Row(
                            children: const [
                              Text(
                                "Film Terbaru",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        _buildMovieList(state.upcomingMovies),
                      ],
                    );
                  } else {
                    return const Text("Data Failed");
                  }
                },
              ),
              const SizedBox(
                height: 50,
              ),
              BlocBuilder<TopRatedMovieCubit, TopRatedMovieState>(
                builder: (context, state) {
                  if (state is TopRatedMovieLoading) {
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15.0,
                          ),
                          child: Row(
                            children: const [
                              Text(
                                "Top Rated Film",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.3,
                          child: Center(
                            child: Transform.scale(
                              scale: 0.7,
                              child: const CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  } else if (state is TopRatedMovieLoaded) {
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15.0,
                          ),
                          child: Row(
                            children: const [
                              Text(
                                "Top Rated Film",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        _buildMovieList(state.topRatedMovies),
                      ],
                    );
                  } else {
                    return const Text("Data Failed");
                  }
                },
              ),
              const SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildCarouselSlider(List<MovieModel> popularMovies) {
    return CarouselSlider(
      items: popularMovies.sublist(0, 6).map((movie) {
        return Builder(
          builder: (BuildContext context) {
            return GestureDetector(
              onTap: () {
                _onPressMovie(movie.id);
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      Config.baseImageUrl + movie.posterPath!,
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                alignment: Alignment.bottomLeft,
                child: Stack(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: <Color>[
                            Colors.transparent,
                            Colors.transparent,
                            Colors.black,
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: <Color>[
                            Colors.black,
                            Colors.transparent,
                            Colors.transparent,
                            Colors.transparent,
                            Colors.transparent,
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 60,
                      left: 0,
                      right: 0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: Text(
                              '${movie.title}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SizedBox(
                                width: 80,
                                child: Column(
                                  children: const [
                                    Icon(
                                      Icons.check_rounded,
                                      color: Colors.white,
                                      size: 28,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      'My List',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  _onPressMovie(movie.id);
                                },
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.25,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 5,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Icon(
                                        Icons.play_arrow,
                                        color: Colors.black,
                                        size: 28,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        "Play",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 80,
                                child: Column(
                                  children: const [
                                    Icon(
                                      Icons.info_outline,
                                      color: Colors.white,
                                      size: 28,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      'Info',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }).toList(),
      options: CarouselOptions(
        autoPlay: true,
        autoPlayAnimationDuration: const Duration(milliseconds: 1600),
        height: MediaQuery.of(context).size.height * 0.6,
        viewportFraction: 1,
        enlargeCenterPage: false,
        onPageChanged: (index, reason) {
          setState(
            () {
              _currentCarousel = index;
            },
          );
        },
      ),
    );
  }

  _buildDotIndicator(List<MovieModel> popularMovies) {
    return Positioned(
      bottom: 20,
      left: 0,
      right: 0,
      child: DotsIndicator(
        dotsCount: popularMovies.sublist(0, 6).length,
        position: _currentCarousel.toDouble(),
        decorator: DotsDecorator(
          spacing: const EdgeInsets.all(3.0),
          size: const Size.square(6.0),
          activeSize: const Size(10.0, 6.0),
          activeColor: Colors.red,
          activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
      ),
    );
  }

  _buildMovieList(List<MovieModel> moviesList) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.30,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
        ),
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          var movie = moviesList[index];
          return GestureDetector(
              onTap: () {
                _onPressMovie(movie.id);
              },
              child: MovieCard(movie: movie));
        },
        separatorBuilder: (context, index) {
          return const SizedBox(
            width: 20,
          );
        },
        itemCount: moviesList.sublist(0, 10).length,
      ),
    );
  }
}

class MovieCard extends StatelessWidget {
  const MovieCard({
    Key? key,
    required this.movie,
  }) : super(key: key);

  final MovieModel movie;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              Config.baseImageUrl + movie.posterPath!,
              height: 180,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            movie.title!,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white,
              fontWeight: FontWeight.w500,
              height: 1.5,
            ),
          ),
          const Spacer(),
          RatingBar(
            onRatingUpdate: (rating) {},
            itemCount: 5,
            ignoreGestures: true,
            itemSize: 12.0,
            initialRating: movie.voteAverage! / 2,
            ratingWidget: RatingWidget(
              full: const Icon(
                Icons.star,
                color: Colors.amber,
              ),
              half: const Icon(
                Icons.star_half,
                color: Colors.white,
              ),
              empty: const Icon(
                Icons.star,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
