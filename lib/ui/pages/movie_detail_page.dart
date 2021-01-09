part of 'pages.dart';

class MovieDetailPage extends StatelessWidget {
  final Movie movie;

  MovieDetailPage(this.movie);

  @override
  Widget build(BuildContext context) {
    MovieDetail movieDetail;
    List<Credit> credits;

    return WillPopScope(
      onWillPop: () async {
        getNavigation.Get.back();
        // context.read<PageBloc>().add(GoToMainPage());
        return;
      },
      child: ScrollConfiguration(
        behavior: ScrollBehavior()
          ..buildViewportChrome(context, null, AxisDirection.down),
        child: Scaffold(
          body: FutureBuilder(
            future: MovieServices.getDetails(movie),
            builder: (_, snapshot) {
              if (snapshot.hasData) {
                movieDetail = snapshot.data;
                return FutureBuilder(
                  future: MovieServices.getCredits(movie.id),
                  builder: (_, snapshot) {
                    if (snapshot.hasData) {
                      credits = snapshot.data;
                      return Stack(
                        children: [
                          Container(
                            color: mainColor,
                          ),
                          SafeArea(
                            child: Container(
                              color: Colors.white,
                              //padding: EdgeInsets.all(0),
                              child: ListView(
                                children: [
                                  //note: HEADER MOVIE BACKDROP
                                  Stack(
                                    children: [
                                      Container(
                                        height: 240,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: NetworkImage(imageBaseURL +
                                                "w780" +
                                                movieDetail.backdropPath),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        child: Align(
                                          alignment: Alignment.bottomCenter,
                                          child: Container(
                                            height: 120,
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                begin: Alignment.bottomCenter,
                                                end: Alignment.topCenter,
                                                colors: [
                                                  Colors.white.withOpacity(1),
                                                  Colors.white.withOpacity(0),
                                                ],
                                                //tileMode: TileMode.clamp,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: GestureDetector(
                                          onTap: () {
                                            getNavigation.Get.back();
                                            // context
                                            //     .read<PageBloc>()
                                            //     .add(GoToMainPage());
                                          },
                                          child: Container(
                                            padding: EdgeInsets.only(
                                                top: 20, left: defaultMargin),
                                            //margin: EdgeInsets.only(top: 20),
                                            child: Icon(
                                              MdiIcons.arrowLeft,
                                              color: Colors.white,
                                              size: 26,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                  //note: MOVIE TITLE, GENRE, LANGUAGE, RATING
                                  Container(
                                    margin: EdgeInsets.symmetric(vertical: 12),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              2 * defaultMargin,
                                          child: Text(
                                            movieDetail.title,
                                            style: blackTextFont.copyWith(
                                                fontSize: 22),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 6,
                                        ),
                                        Text(
                                          movieDetail.genresAndLanguage,
                                          style: greyTextFont.copyWith(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black54,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        RatingStars(
                                          voteAverage: movieDetail.voteAverage,
                                          fontSize: 13,
                                          fontColor: Colors.grey,
                                          starSize: 20,
                                        ),
                                      ],
                                    ),
                                  ),

                                  //note: CAST AND CREW
                                  Container(
                                    margin: EdgeInsets.fromLTRB(
                                        defaultMargin, 12, defaultMargin, 12),
                                    child: Text(
                                      "Casts & Crew",
                                      style: blackTextFont.copyWith(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 100,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: credits.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Container(
                                          margin: EdgeInsets.only(
                                              left: (index == 0)
                                                  ? defaultMargin
                                                  : 12,
                                              right:
                                                  (index == credits.length - 1)
                                                      ? defaultMargin
                                                      : 0),
                                          child: CreditCard(credits[index]),
                                        );
                                      },
                                    ),
                                  ),

                                  //note: STORYLINE
                                  Container(
                                    margin: EdgeInsets.fromLTRB(
                                        defaultMargin, 12, defaultMargin, 6),
                                    child: Text(
                                      "Storyline",
                                      style: blackTextFont.copyWith(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(
                                        defaultMargin, 0, defaultMargin, 30),
                                    child: Text(
                                      movieDetail.overview,
                                      style: greyTextFont.copyWith(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      maxLines: 5,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),

                                  //note: BUTTON CONTINUE TO BOOK
                                  Column(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.symmetric(
                                          horizontal: 24,
                                        ),
                                        width: 250,
                                        height: 50,
                                        child: RaisedButton(
                                          color: mainColor,
                                          elevation: 0,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          child: Text(
                                            "Continue to Book",
                                            style: whiteTextFont.copyWith(
                                                fontSize: 16),
                                          ),
                                          onPressed: () {
                                            // context.read<PageBloc>().add(
                                            //     GoToSelectSchedulePage(
                                            //         movieDetail));

                                            getNavigation.Get.to(
                                              SelectSchedulePage(movieDetail),
                                              transition: getNavigation
                                                  .Transition.rightToLeft,
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 50,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    } else {
                      return SpinKitRing(color: mainColor);
                    }
                  },
                );
              } else {
                return SpinKitRing(color: mainColor);
              }
            },
          ),
        ),
      ),
    );
  }
}
