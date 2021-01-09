part of 'pages.dart';

class TicketDetailPage extends StatelessWidget {
  final Ticket ticket;

  TicketDetailPage(this.ticket);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        getNavigation.Get.back();
        // context.read<PageBloc>().add(GoToMainPage(
        //       bottomNavigationIndex: 1,
        //     ));
        return;
      },
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              color: mainColor,
            ),
            SafeArea(
              child: Container(
                color: Color(0xFFF7F6F9),
                child: ListView(
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(
                          defaultMargin, 20, defaultMargin, 30),
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: GestureDetector(
                              onTap: () {
                                getNavigation.Get.back();
                                // context.read<PageBloc>().add(GoToMainPage(
                                //       bottomNavigationIndex: 1,
                                //     ));
                              },
                              child: Icon(
                                MdiIcons.arrowLeft,
                                color: Colors.black,
                                size: 26,
                              ),
                            ),
                          ),
                          Center(
                            child: Text(
                              "Ticket Details",
                              style: blackTextFont.copyWith(fontSize: 20),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // note: TICKET DETAIL
                    ClipPath(
                      clipper: TicketBottomClipper(),
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: defaultMargin),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16),
                          ),
                        ),
                        child: Column(
                          children: [
                            // note: POSTER MOVIE
                            Container(
                              height: 170,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(12),
                                  topRight: Radius.circular(12),
                                ),
                                image: DecorationImage(
                                  image: NetworkImage(imageBaseURL +
                                      "w780" +
                                      ticket.movieDetail.backdropPath),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),

                            //note: MOVIE DETAIL
                            Padding(
                              padding: EdgeInsets.fromLTRB(16, 16, 16, 24),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width -
                                        2 * defaultMargin -
                                        32,
                                    child: Text(
                                      ticket.movieDetail.title,
                                      style:
                                          blackTextFont.copyWith(fontSize: 18),
                                      maxLines: 2,
                                      overflow: TextOverflow.clip,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 6,
                                  ),
                                  Text(
                                    ticket.movieDetail.genresAndLanguage,
                                    style: greyTextFont.copyWith(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  SizedBox(
                                    height: 6,
                                  ),
                                  RatingStars(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    voteAverage: ticket.movieDetail.voteAverage,
                                    fontSize: 12,
                                    fontColor: accentColor3,
                                  ),
                                ],
                              ),
                            ),

                            //note: CINEMA, DATE TIME, SEAT NUMBER, ID ORDER
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 16, right: 16, bottom: 12),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Cinema",
                                    style: greyTextFont.copyWith(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.5,
                                    child: Text(
                                      ticket.theater.name,
                                      style: blackTextFont.copyWith(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      textAlign: TextAlign.end,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 16, right: 16, bottom: 12),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Date & Time",
                                    style: greyTextFont.copyWith(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.5,
                                    child: Text(
                                      ticket.time.dateAndTime,
                                      style: whiteNumberFont.copyWith(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      textAlign: TextAlign.end,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 16, right: 16, bottom: 12),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Seat Number",
                                    style: greyTextFont.copyWith(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.5,
                                    child: Text(
                                      ticket.seatsInString,
                                      style: whiteNumberFont.copyWith(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      textAlign: TextAlign.end,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 16, right: 16, bottom: 12),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "ID Order",
                                    style: greyTextFont.copyWith(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Text(
                                    ticket.bookingCode,
                                    style: whiteNumberFont.copyWith(
                                        color: Colors.black, fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            DottedLine(
                              dashColor: Color(0xFFDDDDDD),
                              lineThickness: 3,
                              dashLength: 10,
                              dashGapLength: 7,
                            ),
                          ],
                        ),
                      ),
                    ),

                    //note: NAME, TOTAL PRICE, QR CODE
                    BlocBuilder<UserBloc, UserState>(
                      builder: (context, userState) {
                        UserModel user = (userState as UserLoaded).user;
                        return ClipPath(
                          clipper: TicketTopClipper(),
                          child: Container(
                            margin:
                                EdgeInsets.symmetric(horizontal: defaultMargin),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(16),
                                bottomRight: Radius.circular(16),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width -
                                      2 * defaultMargin -
                                      2 * 16 -
                                      120,
                                  margin: EdgeInsets.only(left: 16),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Name",
                                        style: greyTextFont.copyWith(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 4,
                                      ),
                                      Text(
                                        user.name,
                                        style: blackTextFont.copyWith(
                                          fontSize: 16,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        "Price",
                                        style: greyTextFont.copyWith(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 4,
                                      ),
                                      Text(
                                        NumberFormat.currency(
                                                locale: "id_ID",
                                                decimalDigits: 0,
                                                symbol: "IDR ")
                                            .format(ticket.totalPrice),
                                        style: whiteNumberFont.copyWith(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 120,
                                  height: 120,
                                  margin: EdgeInsets.only(
                                      top: 20, bottom: 10, right: 16),
                                  child: Image(
                                    image: AssetImage("assets/img_qr_code.png"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 50),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class TicketBottomClipper extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height * 0.95);
    path.quadraticBezierTo(
        size.width * 0.1, size.height * 0.95, size.width * 0.1, size.height);
    path.lineTo(size.width * 0.9, size.height);
    path.quadraticBezierTo(
        size.width * 0.9, size.height * 0.95, size.width, size.height * 0.95);
    path.lineTo(size.width, 0);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

class TicketTopClipper extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, size.height * 0.1);
    path.quadraticBezierTo(
        size.width * 0.9, size.height * 0.1, size.width * 0.9, 0);
    path.lineTo(size.width * 0.1, 0);
    path.quadraticBezierTo(
        size.width * 0.1, size.height * 0.1, 0, size.height * 0.1);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
