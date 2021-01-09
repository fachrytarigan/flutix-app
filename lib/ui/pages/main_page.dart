part of 'pages.dart';

class MainPage extends StatefulWidget {
  final int bottomNavbarIndex;

  MainPage({this.bottomNavbarIndex = 0});
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int bottomNavbarIndex;
  PageController pageController;

  @override
  void initState() {
    super.initState();

    bottomNavbarIndex = widget.bottomNavbarIndex;
    pageController = PageController(initialPage: bottomNavbarIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(color: accentColor1),
          SafeArea(
            child: Container(
              color: Color(0xFFF7F6F9),
              child: ScrollConfiguration(
                behavior: ScrollBehavior()
                  ..buildViewportChrome(context, null, AxisDirection.down),
                child: PageView(
                  controller: pageController,
                  onPageChanged: (index) {
                    setState(() {
                      bottomNavbarIndex = index;
                    });
                  },
                  children: [
                    MoviePage(),
                    TicketPage(),
                  ],
                ),
              ),
            ),
          ),
          customBottomNavBar(),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: 50,
              height: 50,
              margin: EdgeInsets.only(bottom: 45),
              child: FloatingActionButton(
                backgroundColor: accentColor2,
                elevation: 0.0,
                child: SizedBox(
                  width: 25,
                  height: 25,
                  child: Icon(
                    MdiIcons.walletPlus,
                    color: Color(0xFF8C741D),
                  ),
                ),
                onPressed: () {
                  getNavigation.Get.to(
                    TopUpPage(),
                    transition: getNavigation.Transition.downToUp,
                  );
                  //context.read<PageBloc>().add(GoToTopUpPage(GoToMainPage()));
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget customBottomNavBar() => Align(
        alignment: Alignment.bottomCenter,
        child: ClipPath(
          clipper: BottomNavBarClipper(),
          child: Container(
            height: 70,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: BottomNavigationBar(
                elevation: 0,
                backgroundColor: Colors.transparent,
                selectedItemColor: Colors.black,
                unselectedItemColor: accentColor4,
                unselectedLabelStyle: blackTextFont,
                selectedLabelStyle: blackTextFont,
                selectedFontSize: 13,
                unselectedFontSize: 13,
                currentIndex: bottomNavbarIndex,
                onTap: (index) {
                  setState(() {
                    bottomNavbarIndex = index;
                    pageController.jumpToPage(index);
                  });
                },
                items: [
                  BottomNavigationBarItem(
                      label: "New Movies",
                      icon: Container(
                        height: 20,
                        margin: EdgeInsets.only(bottom: 8),
                        child: Image.asset((bottomNavbarIndex == 0)
                            ? "assets/ic_movies.png"
                            : "assets/ic_movies_grey.png"),
                      )),
                  BottomNavigationBarItem(
                      label: "My Tickets",
                      icon: Container(
                        height: 20,
                        margin: EdgeInsets.only(bottom: 8),
                        child: Image.asset((bottomNavbarIndex == 1)
                            ? "assets/ic_ticket.png"
                            : "assets/ic_ticket_grey.png"),
                      )),
                ]),
          ),
        ),
      );
}

class BottomNavBarClipper extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    Path path = Path();
    path.lineTo(size.width / 2 - 30, 0);
    path.quadraticBezierTo(size.width / 2 - 30, 33, size.width / 2, 33);
    path.quadraticBezierTo(size.width / 2 + 30, 33, size.width / 2 + 30, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) => false;
}
