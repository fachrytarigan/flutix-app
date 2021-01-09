part of 'pages.dart';

class ProfilePage extends StatefulWidget {
  // final UserModel user;

  // ProfilePage({this.user});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        getNavigation.Get.offAll(
          MainPage(),
          transition: getNavigation.Transition.leftToRight,
        );
        // context.read<PageBloc>().add(GoToMainPage());
        return;
      },
      child: Scaffold(
        body: Stack(
          children: [
            Container(color: mainColor),
            SafeArea(
              child: Container(
                color: Colors.white,
                child:
                    BlocBuilder<UserBloc, UserState>(builder: (_, userState) {
                  UserModel user = (userState as UserLoaded).user;
                  return ListView(
                    children: [
                      Column(
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: GestureDetector(
                              onTap: () {
                                getNavigation.Get.offAll(
                                  MainPage(),
                                  transition:
                                      getNavigation.Transition.leftToRight,
                                );
                                // context.read<PageBloc>().add(GoToMainPage());
                              },
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: defaultMargin, top: 20),
                                child: Icon(
                                  MdiIcons.arrowLeft,
                                  color: Colors.black,
                                  size: 26,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 20, bottom: 40),
                            child: Column(
                              children: [
                                Container(
                                  width: 130,
                                  height: 130,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: (user.profilePicture == "")
                                          ? AssetImage("assets/user_pic.png")
                                          : NetworkImage(user.profilePicture),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  user.name,
                                  style: blackTextFont.copyWith(fontSize: 18),
                                ),
                                SizedBox(
                                  height: 6,
                                ),
                                Text(
                                  user.email,
                                  style: greyTextFont.copyWith(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          ProfileList(),
                          SizedBox(height: 24),
                          Container(
                            width: 250,
                            height: 50,
                            child: RaisedButton(
                              elevation: 0,
                              color: accentColor2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                "Sign Out",
                                style: blackTextFont,
                              ),
                              onPressed: () async {
                                context.read<UserBloc>().add(SignOut());

                                // await AuthServices.signOut();
                                getNavigation.Get.offAll(Wrapper());
                                // context.read<PageBloc>().add(GoToSplashPage());
                              },
                            ),
                          ),
                          SizedBox(height: 30),
                        ],
                      ),
                    ],
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
