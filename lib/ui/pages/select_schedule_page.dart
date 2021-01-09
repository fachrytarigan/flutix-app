part of 'pages.dart';

class SelectSchedulePage extends StatefulWidget {
  final MovieDetail movieDetail;

  SelectSchedulePage(this.movieDetail);

  @override
  _SelectSchedulePageState createState() => _SelectSchedulePageState();
}

class _SelectSchedulePageState extends State<SelectSchedulePage> {
  List<DateTime> dates;
  DateTime selectedDate;
  int selectedTime;
  Theater selectedTheater;
  bool isValid = false;

  @override
  void initState() {
    super.initState();
    dates =
        List.generate(7, (index) => DateTime.now().add(Duration(days: index)));

    selectedDate = dates[0];
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        getNavigation.Get.back();
        // context.read<PageBloc>().add(GoToMovieDetailPage(widget.movieDetail));
        return;
      },
      child: ScrollConfiguration(
        behavior: ScrollBehavior()
          ..buildViewportChrome(context, null, AxisDirection.down),
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
                      //note: BACK BUTTON
                      Row(
                        children: [
                          Container(
                            margin:
                                EdgeInsets.only(top: 20, left: defaultMargin),
                            child: GestureDetector(
                              onTap: () {
                                getNavigation.Get.back();
                                // context.read<PageBloc>().add(
                                //     GoToMovieDetailPage(widget.movieDetail));
                              },
                              child: Icon(
                                MdiIcons.arrowLeft,
                                color: Colors.black,
                                size: 26,
                              ),
                            ),
                          ),
                        ],
                      ),

                      // note: CHOOSE DATE
                      Container(
                        margin: EdgeInsets.fromLTRB(
                            defaultMargin, 20, defaultMargin, 16),
                        child: Text(
                          "Choose Date",
                          style: blackTextFont.copyWith(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 36),
                        height: 90,
                        child: ListView.builder(
                          itemCount: dates.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (_, index) {
                            return Container(
                              margin: EdgeInsets.only(
                                  left: (index == 0) ? defaultMargin : 16,
                                  right: (index == dates.length - 1)
                                      ? defaultMargin
                                      : 0),
                              child: DateCard(
                                dates[index],
                                isSelected: selectedDate == dates[index],
                                onTap: () {
                                  setState(() {
                                    selectedDate = dates[index];
                                  });
                                },
                              ),
                            );
                          },
                        ),
                      ),

                      //note: CHOOSE TIME
                      generateTimeTable(),

                      SizedBox(
                        height: 10,
                      ),

                      //note: NEXT BUTTON => CHOOSE SEAT
                      Align(
                        alignment: Alignment.topCenter,
                        child: BlocBuilder<UserBloc, UserState>(
                          builder: (_, userState) => FloatingActionButton(
                            elevation: 0,
                            backgroundColor:
                                (isValid) ? mainColor : accentColor4,
                            child: Icon(
                              Icons.arrow_forward,
                              color: (isValid) ? Colors.white : accentColor3,
                            ),
                            onPressed: isValid
                                ? () {
                                    getNavigation.Get.to(
                                      SelectSeatPage(
                                        Ticket(
                                          widget.movieDetail,
                                          selectedTheater,
                                          DateTime(
                                              selectedDate.year,
                                              selectedDate.month,
                                              selectedDate.day,
                                              selectedTime),
                                          randomAlphaNumeric(12).toUpperCase(),
                                          null,
                                          (userState as UserLoaded).user.name,
                                          null,
                                        ),
                                      ),
                                      transition:
                                          getNavigation.Transition.rightToLeft,
                                    );
                                    // context
                                    //     .read<PageBloc>()
                                    //     .add(GoToSelectSeatPage(
                                    //       Ticket(
                                    //         widget.movieDetail,
                                    //         selectedTheater,
                                    //         DateTime(
                                    //             selectedDate.year,
                                    //             selectedDate.month,
                                    //             selectedDate.day,
                                    //             selectedTime),
                                    //         randomAlphaNumeric(12)
                                    //             .toUpperCase(),
                                    //         null,
                                    //         (userState as UserLoaded).user.name,
                                    //         null,
                                    //       ),
                                    //     ));
                                  }
                                : null,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Column generateTimeTable() {
    List<int> schedule = List.generate(7, (index) => 10 + index * 2);
    List<Widget> widgets = [];

    for (var theater in dummytheaters) {
      widgets.add(Container(
        margin: EdgeInsets.fromLTRB(defaultMargin, 0, defaultMargin, 16),
        child: Text(
          theater.name,
          style: blackTextFont.copyWith(fontSize: 16),
        ),
      ));

      widgets.add(Container(
        height: 60,
        margin: EdgeInsets.only(bottom: 10),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: schedule.length,
          itemBuilder: (_, index) {
            return Row(
              children: [
                Container(
                  margin: EdgeInsets.only(
                      left: (index == 0) ? defaultMargin : 16,
                      right:
                          (index == schedule.length - 1) ? defaultMargin : 0),
                  child: SelectableBox("${schedule[index]}:00",
                      height: 60,
                      textStyle: whiteNumberFont.copyWith(
                          fontSize: 16, color: Colors.black),
                      isSelected: selectedTheater == theater &&
                          selectedTime == schedule[index],
                      isEnabled: schedule[index] > DateTime.now().hour ||
                          selectedDate.day != DateTime.now().day, onTap: () {
                    setState(() {
                      selectedTheater = theater;
                      selectedTime = schedule[index];
                      isValid = true;
                    });
                  }),
                ),
              ],
            );
          },
        ),
      ));

      widgets.add(Divider(
        color: accentColor4,
        height: 40,
        thickness: 0.5,
        // indent: defaultMargin,
        // endIndent: defaultMargin,
      ));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widgets,
    );
  }
}
