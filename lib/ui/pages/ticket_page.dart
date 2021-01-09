part of 'pages.dart';

class TicketPage extends StatefulWidget {
  @override
  _TicketPageState createState() => _TicketPageState();
}

class _TicketPageState extends State<TicketPage> {
  bool isExpiredTickets = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        //note: CONTENT
        Container(
          color: Color(0xFFF7F6F9),
          child:
              BlocBuilder<TicketBloc, TicketState>(builder: (_, ticketState) {
            return Container(
              //margin: EdgeInsets.symmetric(horizontal: defaultMargin),
              child: TicketViewer(
                isExpiredTickets
                    ? ticketState.tickets
                        .where((ticket) => ticket.time.isBefore(DateTime.now()))
                        .toList()
                    : ticketState.tickets
                        .where(
                            (ticket) => !ticket.time.isBefore(DateTime.now()))
                        .toList(),
              ),
            );
          }),
        ),
        Container(
          height: 100,
          color: accentColor1,
        ),

        //note: HEADER
        SafeArea(
          child: ClipPath(
            clipper: HeaderClipper(),
            child: Container(
                height: 120,
                color: accentColor1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 30, left: defaultMargin),
                      child: Text(
                        "My Tickets",
                        style: whiteTextFont.copyWith(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                    ),
                    Row(
                      children: [
                        Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isExpiredTickets = !isExpiredTickets;
                                });
                              },
                              child: Text(
                                "Newest",
                                style: whiteTextFont.copyWith(
                                  fontSize: 16,
                                  color: !isExpiredTickets
                                      ? Colors.white
                                      : Color(0xFF615A80),
                                ),
                              ),
                            ),
                            SizedBox(height: 14),
                            Container(
                              height: 4,
                              width: MediaQuery.of(context).size.width * 0.5,
                              color: !isExpiredTickets
                                  ? accentColor2
                                  : Colors.transparent,
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isExpiredTickets = !isExpiredTickets;
                                });
                              },
                              child: Text(
                                "Oldest",
                                style: whiteTextFont.copyWith(
                                  fontSize: 16,
                                  color: isExpiredTickets
                                      ? Colors.white
                                      : Color(0xFF615A80),
                                ),
                              ),
                            ),
                            SizedBox(height: 14),
                            Container(
                              height: 4,
                              width: MediaQuery.of(context).size.width * 0.5,
                              color: isExpiredTickets
                                  ? accentColor2
                                  : Colors.transparent,
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                )),
          ),
        ),
      ]),
    );
  }
}

class HeaderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.lineTo(0, size.height - 20);
    path.quadraticBezierTo(0, size.height, 20, size.height);
    path.lineTo(size.width - 20, size.height);
    path.quadraticBezierTo(
        size.width, size.height, size.width, size.height - 20);
    path.lineTo(size.width, 0);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

class TicketViewer extends StatelessWidget {
  final List<Ticket> tickets;

  TicketViewer(this.tickets);
  @override
  Widget build(BuildContext context) {
    var sortedTickets = tickets;
    sortedTickets
        .sort((ticket1, ticket2) => ticket1.time.compareTo(ticket2.time));

    return ListView.builder(
      itemCount: sortedTickets.length,
      itemBuilder: (_, index) => Column(
        children: [
          SizedBox(
            height: index == 0 ? 120 : 0,
          ),
          Material(
            color: Colors.transparent,
            child: InkWell(
              highlightColor: accentColor4,
              //splashColor: Colors.amber,
              onTap: () {
                getNavigation.Get.to(
                  TicketDetailPage(sortedTickets[index]),
                  transition: getNavigation.Transition.rightToLeft,
                );
                // context
                //     .read<PageBloc>()
                //     .add(GoToTicketDetailPage(sortedTickets[index]));
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: defaultMargin,
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 70,
                          height: 90,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            image: DecorationImage(
                              image: NetworkImage(imageBaseURL +
                                  "w500" +
                                  sortedTickets[index].movieDetail.posterPath),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width -
                              2 * defaultMargin -
                              70 -
                              16,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                sortedTickets[index].movieDetail.title,
                                style: blackTextFont.copyWith(
                                  fontSize: 16,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.clip,
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              Text(
                                sortedTickets[index]
                                    .movieDetail
                                    .genresAndLanguage,
                                style: greyTextFont.copyWith(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.clip,
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              Text(
                                sortedTickets[index].theater.name,
                                style: greyTextFont.copyWith(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.clip,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Divider(
            thickness: 1,
            height: 0,
            color: accentColor4,
            indent: defaultMargin,
          ),
          SizedBox(
            height: index == sortedTickets.length - 1 ? 110 : 0,
          ),
        ],
      ),
    );
  }
}
