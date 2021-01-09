part of 'pages.dart';

class SelectSeatPage extends StatefulWidget {
  final Ticket ticket;

  SelectSeatPage(this.ticket);

  @override
  _SelectSeatPageState createState() => _SelectSeatPageState();
}

class _SelectSeatPageState extends State<SelectSeatPage> {
  List<String> selectedSeats = [];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          getNavigation.Get.back();

          // context
          //     .read<PageBloc>()
          //     .add(GoToSelectSchedulePage(widget.ticket.movieDetail));
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
                  child: ListView(
                    children: [
                      //note: HEADER TITLE MOVIE
                      Container(
                        height: 60,
                        margin: EdgeInsets.fromLTRB(
                            defaultMargin, 20, defaultMargin, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              child: GestureDetector(
                                  onTap: () {
                                    getNavigation.Get.back();
                                    // context.read<PageBloc>().add(
                                    //     GoToSelectSchedulePage(
                                    //         widget.ticket.movieDetail));
                                  },
                                  child: Icon(
                                    MdiIcons.arrowLeft,
                                    color: Colors.black,
                                    size: 26,
                                  )),
                            ),
                            Row(
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  child: Text(
                                    widget.ticket.movieDetail.title,
                                    style: blackTextFont.copyWith(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600),
                                    maxLines: 2,
                                    overflow: TextOverflow.clip,
                                    textAlign: TextAlign.end,
                                  ),
                                ),
                                SizedBox(
                                  width: 16,
                                ),
                                Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    image: DecorationImage(
                                        image: NetworkImage(imageBaseURL +
                                            "w500" +
                                            widget.ticket.movieDetail
                                                .backdropPath),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        height: 40,
                        thickness: 1,
                        color: accentColor3,
                        indent: defaultMargin,
                        endIndent: defaultMargin,
                      ),

                      // note: SELECT YOUR SEAT AND CINEMA SCREEN
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 10, bottom: 16),
                            child: Text("Select Your Seat",
                                style: blackTextFont.copyWith(fontSize: 14)),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width -
                                2 * defaultMargin,
                            height: 100,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("assets/screen.png"),
                              ),
                            ),
                          )
                        ],
                      ),

                      //note: SEATS
                      generateSeats(),
                      SizedBox(
                        height: 30,
                      ),
                      // note: NEXT BUTTON
                      Align(
                        alignment: Alignment.topCenter,
                        child: FloatingActionButton(
                          elevation: 0,
                          backgroundColor: selectedSeats.length > 0
                              ? mainColor
                              : accentColor4,
                          child: Icon(
                            Icons.arrow_forward,
                            color: selectedSeats.length > 0
                                ? Colors.white
                                : accentColor3,
                          ),
                          onPressed: selectedSeats.length > 0
                              ? () {
                                  getNavigation.Get.to(
                                    CheckoutPage(widget.ticket
                                        .copyWith(seats: selectedSeats)),
                                    transition:
                                        getNavigation.Transition.rightToLeft,
                                  );
                                  // context.read<PageBloc>().add(GoToCheckoutPage(
                                  //     widget.ticket
                                  //         .copyWith(seats: selectedSeats)));
                                }
                              : null,
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }

  Column generateSeats() {
    List<int> numberOfSeats = [4, 6, 6, 6, 6, 6];
    List<Widget> widgets = [];

    for (int i = 0; i < numberOfSeats.length; i++) {
      widgets.add(
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
                numberOfSeats[i],
                (index) => Padding(
                      padding: EdgeInsets.only(
                          left: index == 0 ? 0 : 16, bottom: 16),
                      child: SelectableBox(
                        "${String.fromCharCode(i + 65)}${index + 1}",
                        width: 40,
                        height: 40,
                        textStyle: whiteNumberFont.copyWith(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.w400),
                        isSelected: selectedSeats.contains(
                            "${String.fromCharCode(i + 65)}${index + 1}"),
                        onTap: () {
                          String seatNumber =
                              "${String.fromCharCode(i + 65)}${index + 1}";

                          setState(() {
                            if (selectedSeats.contains(seatNumber)) {
                              selectedSeats.remove(seatNumber);
                            } else {
                              selectedSeats.add(seatNumber);
                            }
                          });
                        },
                        isEnabled: index != 0,
                      ),
                    ))),
      );
    }

    return Column(children: widgets);
  }
}
