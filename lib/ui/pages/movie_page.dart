part of 'pages.dart';

class MoviePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: ScrollBehavior()
        ..buildViewportChrome(context, null, AxisDirection.down),
      child: ListView(
        children: [
          // note: HEADER
          Container(
            //height: 120,
            padding: EdgeInsets.fromLTRB(defaultMargin, 20, defaultMargin, 28),
            decoration: BoxDecoration(
              color: accentColor1,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
            child: BlocBuilder<UserBloc, UserState>(
              builder: (_, userState) {
                if (userState is UserLoaded) {
                  if (imageFileToUpload != null) {
                    uploadImage(imageFileToUpload).then((downloadUrl) {
                      imageFileToUpload = null;
                      context
                          .read<UserBloc>()
                          .add(UpdateData(profileImage: downloadUrl));
                    });
                  }
                  return Row(
                    children: [
                      Stack(
                        children: [
                          SpinKitRing(
                            lineWidth: 3,
                            size: 50,
                            color: accentColor2,
                          ),
                          GestureDetector(
                            onTap: () {
                              getNavigation.Get.to(
                                ProfilePage(),
                                transition:
                                    getNavigation.Transition.rightToLeft,
                              );
                              // context
                              //     .read<PageBloc>()
                              //     .add(GoToProfilePage(userState.user));
                            },
                            child: Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: (userState.user.profilePicture == "")
                                      ? AssetImage("assets/user_pic.png")
                                      : NetworkImage(
                                          userState.user.profilePicture,
                                        ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 18,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width -
                                2 * defaultMargin -
                                68,
                            child: Text(
                              userState.user.name,
                              style: whiteTextFont.copyWith(fontSize: 18),
                              maxLines: 1,
                              overflow: TextOverflow.clip,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            NumberFormat.currency(
                                    locale: "id_ID",
                                    decimalDigits: 0,
                                    symbol: "IDR ")
                                .format(userState.user.balance),
                            // "IDR " + userState.user.balance.toString(),
                            style: yellowNumberFont.copyWith(
                                fontSize: 16, fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ],
                  );
                } else {
                  return SpinKitRing(
                    lineWidth: 3,
                    color: accentColor2,
                    size: 50,
                  );
                }
              },
            ),
          ),

          // note: NOW PLAYING
          Container(
            margin: EdgeInsets.fromLTRB(defaultMargin, 20, defaultMargin, 12),
            child: Text(
              "Now Playing",
              style: blackTextFont.copyWith(
                  fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 130,
            child: BlocBuilder<MovieBloc, MovieState>(
              builder: (_, movieState) {
                if (movieState is MovieLoaded) {
                  List<Movie> movies = movieState.movies.sublist(0, 10);

                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: movies.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        margin: EdgeInsets.only(
                            left: (index == 0) ? defaultMargin : 16,
                            right: (index == movies.length - 1)
                                ? defaultMargin
                                : 0),
                        child: MovieCard(
                          movies[index],
                          onTap: () {
                            getNavigation.Get.to(
                              MovieDetailPage(movies[index]),
                              transition: getNavigation.Transition.rightToLeft,
                            );
                            // context
                            //     .read<PageBloc>()
                            //     .add(GoToMovieDetailPage(movies[index]));
                          },
                        ),
                      );
                    },
                  );
                } else {
                  return SpinKitCircle(
                    color: mainColor,
                    size: 50,
                  );
                }
              },
            ),
          ),

          // note: BROWSE MOVIE
          Container(
            margin: EdgeInsets.fromLTRB(defaultMargin, 30, defaultMargin, 12),
            child: Text(
              "Browse Movie",
              style: blackTextFont.copyWith(
                  fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          BlocBuilder<UserBloc, UserState>(
            builder: (_, userState) {
              if (userState is UserLoaded) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: defaultMargin),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(
                      userState.user.selectedGenres.length,
                      (index) =>
                          BrowseButton(userState.user.selectedGenres[index]),
                    ),
                  ),
                );
              } else {
                return SpinKitCircle(
                  color: mainColor,
                  size: 40,
                );
              }
            },
          ),

          // note: COMING SOON
          Container(
            margin: EdgeInsets.fromLTRB(defaultMargin, 30, defaultMargin, 12),
            child: Text(
              "Coming Soon",
              style: blackTextFont.copyWith(
                  fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 140,
            child: BlocBuilder<MovieBloc, MovieState>(
              builder: (_, movieState) {
                if (movieState is MovieLoaded) {
                  List<Movie> movies = movieState.movies.sublist(10, 20);

                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: movies.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                          margin: EdgeInsets.only(
                              left: (index == 0) ? defaultMargin : 16,
                              right: (index == movies.length - 1)
                                  ? defaultMargin
                                  : 0),
                          child: ComingSoonCard(
                            movie: movies[index],
                            onTap: () {
                              context
                                  .read<PageBloc>()
                                  .add(GoToMovieDetailPage(movies[index]));
                            },
                          ));
                    },
                  );
                } else {
                  return SpinKitCircle(
                    color: mainColor,
                    size: 50,
                  );
                }
              },
            ),
          ),

          // note: PROMO SEMOGA BERUNTUNG
          Container(
            margin: EdgeInsets.fromLTRB(defaultMargin, 30, defaultMargin, 12),
            child: Text(
              "Semoga Beruntung",
              style: blackTextFont.copyWith(
                  fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Column(
            children: dummyPromo
                .map((e) => Padding(
                      padding: const EdgeInsets.fromLTRB(
                          defaultMargin, 0, defaultMargin, 16),
                      child: PromoCard(e),
                    ))
                .toList(),
          ),
          SizedBox(
            height: 120,
          )
        ],
      ),
    );
  }
}
