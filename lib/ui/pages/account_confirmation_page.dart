part of 'pages.dart';

class AccountConfirmationPage extends StatefulWidget {
  final RegistrationData registrationData;

  AccountConfirmationPage(this.registrationData);

  @override
  _AccountConfirmationPageState createState() =>
      _AccountConfirmationPageState();
}

class _AccountConfirmationPageState extends State<AccountConfirmationPage> {
  bool isSigningUp = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        getNavigation.Get.back();
        // context
        //     .read<PageBloc>()
        //     .add(GoToPreferencePage(widget.registrationData));

        return;
      },
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: defaultMargin),
          color: Colors.white,
          child: ListView(
            children: [
              Container(
                height: 56,
                margin: EdgeInsets.only(top: 20, bottom: 90),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: GestureDetector(
                          onTap: () {
                            getNavigation.Get.back();
                            // context.read<PageBloc>().add(
                            //     GoToPreferencePage(widget.registrationData));
                          },
                          child: Icon(
                            MdiIcons.arrowLeft,
                            color: Colors.black,
                          )),
                    ),
                    Center(
                        child: Text(
                      "Confirm\nNew Account",
                      style: blackTextFont.copyWith(fontSize: 20),
                      textAlign: TextAlign.center,
                    )),
                  ],
                ),
              ),
              Container(
                width: 150,
                height: 150,
                margin: EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: (widget.registrationData.profileImage == null)
                        ? AssetImage("assets/user_pic.png")
                        : FileImage(widget.registrationData.profileImage),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Column(
                children: [
                  Text(
                    "Welcome",
                    style: blackTextFont.copyWith(
                        fontSize: 16, fontWeight: FontWeight.w300),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    "${widget.registrationData.name}",
                    textAlign: TextAlign.center,
                    style: blackTextFont.copyWith(fontSize: 20),
                  ),
                  SizedBox(
                    height: 110,
                  ),
                  (isSigningUp)
                      ? SpinKitRing(color: Color(0xFF40A989))
                      : SizedBox(
                          width: 250,
                          height: 45,
                          child: RaisedButton(
                            color: Color(0xFF40A989),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            child: Text(
                              "Create My Account",
                              style: whiteTextFont.copyWith(fontSize: 16),
                            ),
                            onPressed: () async {
                              setState(() {
                                isSigningUp = true;
                              });

                              imageFileToUpload =
                                  widget.registrationData.profileImage;

                              SignInSignUpResult result =
                                  await AuthServices.signUp(
                                      widget.registrationData.email,
                                      widget.registrationData.password,
                                      widget.registrationData.name,
                                      widget.registrationData.selectedGenres,
                                      widget.registrationData.selectedLang);

                              if (result.user == null) {
                                setState(() {
                                  isSigningUp = false;
                                });

                                Flushbar(
                                  margin: EdgeInsets.all(8),
                                  borderRadius: 8,
                                  duration: Duration(seconds: 3),
                                  flushbarPosition: FlushbarPosition.TOP,
                                  backgroundColor: Color(0xFFFF5B5B),
                                  icon: Icon(
                                    Icons.info_outline,
                                    color: Colors.white,
                                  ),
                                  message: result.message,
                                )..show(context);
                              } else {
                                getNavigation.Get.off(MainPage());
                              }
                            },
                          ),
                        ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
