part of 'pages.dart';

class CheckoutPage extends StatefulWidget {
  final Ticket ticket;

  CheckoutPage(this.ticket);
  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  @override
  Widget build(BuildContext context) {
    int total = 38000 * widget.ticket.seats.length;

    return WillPopScope(
        onWillPop: () async {
          getNavigation.Get.back();
          // context.read<PageBloc>().add(GoToSelectSeatPage(widget.ticket));
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
                  color: Colors.white,
                  //padding: EdgeInsets.symmetric(horizontal: defaultMargin),
                  child: ListView(children: [
                    Container(
                      height: 56,
                      margin: EdgeInsets.fromLTRB(
                          defaultMargin, 20, defaultMargin, 30),
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: GestureDetector(
                              onTap: () {
                                getNavigation.Get.back();
                                // context
                                //     .read<PageBloc>()
                                //     .add(GoToSelectSeatPage(widget.ticket));
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
                              "Checkout\nMovie",
                              style: blackTextFont.copyWith(fontSize: 20),
                              textAlign: TextAlign.center,
                            ),
                          )
                        ],
                      ),
                    ),
                    BlocBuilder<UserBloc, UserState>(
                      builder: (_, userState) {
                        UserModel user = (userState as UserLoaded).user;
                        return Column(
                          children: [
                            //note: MOVIE DETAILS
                            Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: defaultMargin),
                              child: Row(
                                children: [
                                  Container(
                                    width: 70,
                                    height: 90,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        image: DecorationImage(
                                          image: NetworkImage(imageBaseURL +
                                              "w780" +
                                              widget.ticket.movieDetail
                                                  .posterPath),
                                          fit: BoxFit.cover,
                                        )),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 20),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              2 * defaultMargin -
                                              20 -
                                              70,
                                          child: Text(
                                            widget.ticket.movieDetail.title,
                                            style: blackTextFont.copyWith(
                                                fontSize: 18),
                                            maxLines: 2,
                                            overflow: TextOverflow.clip,
                                          ),
                                        ),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              2 * defaultMargin -
                                              20 -
                                              70,
                                          margin: EdgeInsets.only(
                                              top: 6, bottom: 6),
                                          child: Text(
                                            widget.ticket.movieDetail
                                                .genresAndLanguage,
                                            style: greyTextFont.copyWith(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400),
                                            maxLines: 2,
                                            overflow: TextOverflow.clip,
                                          ),
                                        ),
                                        RatingStars(
                                          voteAverage: widget
                                              .ticket.movieDetail.voteAverage,
                                          fontSize: 12,
                                          starSize: 16,
                                          fontColor: accentColor3,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: 20, horizontal: defaultMargin),
                              child: Divider(
                                color: accentColor3,
                                thickness: 1,
                              ),
                            ),

                            //note: TICKET DETAILS
                            Padding(
                              padding: EdgeInsets.only(
                                  left: defaultMargin,
                                  right: defaultMargin,
                                  bottom: 12),
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
                                    widget.ticket.bookingCode,
                                    style: whiteNumberFont.copyWith(
                                        color: Colors.black, fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: defaultMargin,
                                  right: defaultMargin,
                                  bottom: 12),
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
                                      widget.ticket.theater.name,
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
                                  left: defaultMargin,
                                  right: defaultMargin,
                                  bottom: 12),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Date & Time",
                                    style: greyTextFont.copyWith(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Text(
                                    widget.ticket.time.dateAndTime,
                                    style: whiteNumberFont.copyWith(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: defaultMargin,
                                  right: defaultMargin,
                                  bottom: 12),
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
                                      widget.ticket.seatsInString,
                                      style: whiteNumberFont.copyWith(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400),
                                      textAlign: TextAlign.end,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: defaultMargin,
                                  right: defaultMargin,
                                  bottom: 12),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Price",
                                    style: greyTextFont.copyWith(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Text(
                                    "IDR 35.000 x ${widget.ticket.seats.length}",
                                    style: whiteNumberFont.copyWith(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400),
                                    textAlign: TextAlign.end,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: defaultMargin,
                                  right: defaultMargin,
                                  bottom: 12),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Fee",
                                    style: greyTextFont.copyWith(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Text(
                                    "IDR 3.000 x ${widget.ticket.seats.length}",
                                    style: whiteNumberFont.copyWith(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400),
                                    textAlign: TextAlign.end,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: defaultMargin,
                                  right: defaultMargin,
                                  bottom: 12),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Total",
                                    style: greyTextFont.copyWith(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Text(
                                    NumberFormat.currency(
                                            locale: "id_ID",
                                            decimalDigits: 0,
                                            symbol: "IDR ")
                                        .format(total),
                                    style: whiteNumberFont.copyWith(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                    textAlign: TextAlign.end,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(
                                  defaultMargin, 10, defaultMargin, 20),
                              child: Divider(
                                color: accentColor3,
                                thickness: 1,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: defaultMargin,
                                  right: defaultMargin,
                                  bottom: 12),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Your Wallet",
                                    style: greyTextFont.copyWith(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Text(
                                    NumberFormat.currency(
                                            locale: "id_ID",
                                            decimalDigits: 0,
                                            symbol: "IDR ")
                                        .format(user.balance),
                                    style: whiteNumberFont.copyWith(
                                        color: user.balance >= total
                                            ? Color(0xFF40A989)
                                            : Color(0xFFFF5B5B),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                    textAlign: TextAlign.end,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: 250,
                              height: 45,
                              margin: EdgeInsets.only(top: 30, bottom: 50),
                              child: RaisedButton(
                                elevation: 0,
                                child: Text(
                                  user.balance >= total
                                      ? "Checkout Now"
                                      : "Top Up My Wallet",
                                  style: whiteTextFont.copyWith(
                                      fontSize: 16,
                                      color: user.balance >= total
                                          ? Colors.white
                                          : Colors.black),
                                ),
                                color: user.balance >= total
                                    ? Color(0xFF40A989)
                                    : Color(0xFFFFD439),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                                onPressed: () {
                                  if (user.balance >= total) {
                                    // Uang Cukup
                                    FlutixTransaction transaction =
                                        FlutixTransaction(
                                            userID: user.id,
                                            title:
                                                widget.ticket.movieDetail.title,
                                            subtitle:
                                                widget.ticket.theater.name,
                                            time: DateTime.now(),
                                            amount: -total,
                                            picture: widget
                                                .ticket.movieDetail.posterPath);

                                    getNavigation.Get.offAll(
                                      SuccessPage(
                                          widget.ticket
                                              .copyWith(totalPrice: total),
                                          transaction),
                                      transition:
                                          getNavigation.Transition.fadeIn,
                                    );

                                    // context.read<PageBloc>().add(
                                    //     GoToSuccessPage(
                                    //         widget.ticket
                                    //             .copyWith(totalPrice: total),
                                    //         transaction));
                                  } else {
                                    // Uang Tidak Cukup
                                  }
                                },
                              ),
                            ),
                          ],
                        );
                      },
                    )
                  ]),
                ),
              ),
            ],
          ),
        ));
  }
}
