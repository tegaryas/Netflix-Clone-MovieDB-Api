import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moviedb_app/bloc/cast_movie/castmovie_cubit.dart';
import 'package:moviedb_app/bloc/detail_movies/detailmovie_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviedb_app/config/config.dart';
import 'package:moviedb_app/helpers/helper.dart';
import 'package:moviedb_app/models/movie_detail_model.dart';
import 'package:moviedb_app/pages/search/search_page.dart';

class DetailMoviePage extends StatefulWidget {
  final int movieId;
  const DetailMoviePage({
    Key? key,
    required this.movieId,
  }) : super(key: key);

  @override
  State<DetailMoviePage> createState() => _DetailMoviePageState();
}

class _DetailMoviePageState extends State<DetailMoviePage> {
  @override
  void initState() {
    context.read<DetailMovieCubit>().getDetailMovies(widget.movieId);
    context.read<CastMovieCubit>().getCastMovies(widget.movieId);
    super.initState();
  }

  _onSelectedPopupMenu(String value, String homePage) {
    if (value == 'Share') {
      return null;
    } else {
      return Helper.launchUrl(homePage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white,
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
        body: SingleChildScrollView(
          child: BlocBuilder<DetailMovieCubit, DetailMovieState>(
            builder: (context, state) {
              if (state is DetailMovieLoading) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: const Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Colors.white,
                      ),
                    ),
                  ),
                );
              } else if (state is DetailMovieLoaded) {
                MovieDetail detail = state.detailMovies;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildCarouselImage(detail, context),
                    _buildMovieInfo(detail),
                    const SizedBox(
                      height: 20,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.0),
                      child: Text(
                        "Daftar Pemeran",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    _buildMovieCast(),
                    const SizedBox(
                      height: 50,
                    ),
                  ],
                );
              } else if (state is DetailMovieFailed) {
                return const Center(
                  child: Text(
                    'Fetch Gagal',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                );
              } else {
                return Container();
              }
            },
          ),
        ));
  }

  Widget _buildMovieCast() {
    return BlocBuilder<CastMovieCubit, CastMovieState>(
      builder: (context, state) {
        if (state is CastMovieLoaded) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.11,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
              ),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final cast = state.movieCast.cast![index];
                return SizedBox(
                  height: MediaQuery.of(context).size.height * 0.11,
                  width: 80,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      cast.profilePath != null
                          ? CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.grey.withOpacity(0.4),
                              backgroundImage: NetworkImage(
                                Config.baseImageUrl + cast.profilePath!,
                              ),
                            )
                          : CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.grey.withOpacity(0.4),
                              child: const Center(
                                child: Icon(
                                  Icons.person,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        cast.name!,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(
                  width: 5,
                );
              },
              itemCount: state.movieCast.cast!.length,
            ),
          );
        } else if (state is CastMovieLoading) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.2,
            width: MediaQuery.of(context).size.width,
            child: const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  Colors.white,
                ),
              ),
            ),
          );
        } else if (state is DetailMovieFailed) {
          return const Center(
            child: Text(
              'Fetch Gagal',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }

  Widget _buildMovieInfo(MovieDetail detail) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 15.0,
        vertical: 10.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            detail.title!,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Text(
                '${detail.voteAverage!.toInt() * 10}% match',
                style: const TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Text(
                DateFormat.y().format(detail.releaseDate!),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 5,
                  vertical: 1,
                ),
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(2),
                ),
                child: Center(
                  child: Text(
                    detail.adult == true ? "R18" : "PG",
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 5,
                  vertical: 1,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                  ),
                  borderRadius: BorderRadius.circular(2),
                ),
                child: const Center(
                  child: Text(
                    "HD",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              vertical: 8,
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
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  "Play",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            detail.overview!,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.normal,
              fontSize: 16,
              height: 1.5,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              const Text(
                "Genre:  ",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
              ...List.generate(
                  detail.genres!.length > 4 ? 4 : detail.genres!.length,
                  (index) {
                return detail.genres!.length > 4
                    ? Text(
                        index < 3
                            ? detail.genres![index].name! + ", "
                            : detail.genres![index].name! + "... ",
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                      )
                    : Text(
                        detail.genres![index] == detail.genres!.last
                            ? detail.genres![index].name! + ""
                            : detail.genres![index].name! + ", ",
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                      );
              }),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            "Durasi:  " + Helper.convertHoursMinutes(detail.runtime!),
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 16,
            ),
          ),
          const SizedBox(
            height: 30,
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
                      height: 10,
                    ),
                    Text(
                      'My List',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                width: 80,
                child: Column(
                  children: const [
                    Icon(
                      Icons.thumb_up_alt,
                      color: Colors.white,
                      size: 28,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Rated',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                    )
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  _onSelectedPopupMenu("", Uri.encodeFull(detail.homepage!));
                },
                child: SizedBox(
                  width: 80,
                  child: Column(
                    children: const [
                      Icon(
                        Icons.share,
                        color: Colors.white,
                        size: 28,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Share',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCarouselImage(MovieDetail detail, BuildContext context) {
    return CarouselSlider(
      items: detail.images!.backdrops!.map((movie) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    Config.baseImageUrlOri + movie.filePath!,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
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
            );
          },
        );
      }).toList(),
      options: CarouselOptions(
        height: MediaQuery.of(context).size.height * 0.25,
        viewportFraction: 1,
        enlargeCenterPage: false,
      ),
    );
  }
}
