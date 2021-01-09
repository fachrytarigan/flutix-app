part of 'widgets.dart';

class ProfileList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //note: EDIT PROFILE
        BlocBuilder<UserBloc, UserState>(
          builder: (_, userState) => Material(
            color: Colors.transparent,
            child: InkWell(
              highlightColor: accentColor4,
              onTap: () {
                getNavigation.Get.to(
                  EditProfilePage((userState as UserLoaded).user),
                  transition: getNavigation.Transition.rightToLeft,
                );
                // context
                //     .read<PageBloc>()
                //     .add(GoToEditProfilePage((userState as UserLoaded).user));
              },
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                        vertical: 14, horizontal: defaultMargin),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 28,
                          height: 28,
                          child: Image.asset(
                              "assets/account_circle_24px_outlined.png"),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          "Edit Profile",
                          style: blackTextFont.copyWith(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 24),
                    child: DottedLine(
                      dashColor: Color(0xFFDDDDDD),
                      dashGapLength: 6,
                      dashLength: 6,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        //note: MY WALLET
        BlocBuilder<UserBloc, UserState>(
          builder: (_, userState) => Material(
            color: Colors.transparent,
            child: InkWell(
              highlightColor: accentColor4,
              onTap: () {
                getNavigation.Get.offAll(
                  WalletPage(ProfilePage()),
                  transition: getNavigation.Transition.rightToLeft,
                );

                // context.read<PageBloc>().add(GoToWalletPage(
                //     GoToProfilePage((userState as UserLoaded).user)));
              },
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                        vertical: 14, horizontal: defaultMargin),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 28,
                          height: 28,
                          child: Image.asset(
                              "assets/account_balance_wallet_24px_outlined.png"),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          "My Wallet",
                          style: blackTextFont.copyWith(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 24),
                    child: DottedLine(
                      dashColor: Color(0xFFDDDDDD),
                      dashGapLength: 6,
                      dashLength: 6,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        //note: CHANGE LANGUAGE
        Material(
          color: Colors.transparent,
          child: InkWell(
            highlightColor: accentColor4,
            onTap: () {},
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                      vertical: 14, horizontal: defaultMargin),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 28,
                        height: 28,
                        child:
                            Image.asset("assets/translate_24px_outlined.png"),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        "Change Language",
                        style: blackTextFont.copyWith(fontSize: 16),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 24),
                  child: DottedLine(
                    dashColor: Color(0xFFDDDDDD),
                    dashGapLength: 6,
                    dashLength: 6,
                  ),
                ),
              ],
            ),
          ),
        ),

        //note: HELP CENTRE
        Material(
          color: Colors.transparent,
          child: InkWell(
            highlightColor: accentColor4,
            onTap: () {},
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                      vertical: 14, horizontal: defaultMargin),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 28,
                        height: 28,
                        child: Image.asset(
                            "assets/verified_user_24px_outlined.png"),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        "Help Centre",
                        style: blackTextFont.copyWith(fontSize: 16),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 24),
                  child: DottedLine(
                    dashColor: Color(0xFFDDDDDD),
                    dashGapLength: 6,
                    dashLength: 6,
                  ),
                ),
              ],
            ),
          ),
        ),

        //note: RATE FLUTIX APP
        Material(
          color: Colors.transparent,
          child: InkWell(
            highlightColor: accentColor4,
            onTap: () {},
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                      vertical: 14, horizontal: defaultMargin),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 28,
                        height: 28,
                        child: Image.asset("assets/thumb_up_24px_outlined.png"),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        "Rate Flutix App",
                        style: blackTextFont.copyWith(fontSize: 16),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 24),
                  child: DottedLine(
                    dashColor: Color(0xFFDDDDDD),
                    dashGapLength: 6,
                    dashLength: 6,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
