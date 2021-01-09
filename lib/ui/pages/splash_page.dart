part of 'pages.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: defaultMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 135,
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage("assets/logo.png")),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 70, bottom: 16),
              child: Text(
                "New Experience",
                style: blackTextFont.copyWith(fontSize: 20),
              ),
            ),
            Container(
              child: Text(
                "Watch a new movie much\neasier than any before",
                style: greyTextFont.copyWith(
                    fontSize: 16, fontWeight: FontWeight.w200),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              width: 250,
              height: 45,
              margin: EdgeInsets.only(top: 70, bottom: 20),
              child: RaisedButton(
                  child: Text(
                    "Get Started",
                    style: whiteTextFont.copyWith(fontSize: 16),
                  ),
                  color: mainColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  onPressed: () {
                    getNavigation.Get.to(SignUpPage(RegistrationData()),
                        transition: getNavigation.Transition.downToUp);
                    // context
                    //     .read<PageBloc>()
                    //     .add(GoToRegistrationPage(RegistrationData()));
                  }),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account? ",
                    style: greyTextFont.copyWith(
                        fontSize: 14, fontWeight: FontWeight.w400),
                  ),
                  GestureDetector(
                    onTap: () {
                      getNavigation.Get.to(SignInPage(),
                          transition: getNavigation.Transition.downToUp);

                      // context.read<PageBloc>().add(GoToLoginPage());
                    },
                    child: Text(
                      "Sign In",
                      style: purpleTextFont.copyWith(fontSize: 14),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
