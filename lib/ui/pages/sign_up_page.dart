part of 'pages.dart';

class SignUpPage extends StatefulWidget {
  final RegistrationData registrationData;

  SignUpPage(this.registrationData);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();

    nameController.text = widget.registrationData.name;
    emailController.text = widget.registrationData.email;
  }

  @override
  Widget build(BuildContext context) {
    context
        .watch<ThemeBloc>()
        .add(ChangeTheme(ThemeData().copyWith(primaryColor: mainColor)));
    return WillPopScope(
      onWillPop: () async {
        getNavigation.Get.back();
        // context.read<PageBloc>().add(GoToSplashPage());

        return;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: defaultMargin),
          child: ScrollConfiguration(
            behavior: ScrollBehavior()
              ..buildViewportChrome(context, null, AxisDirection.down),
            child: ListView(
              children: [
                Column(
                  children: [
                    Container(
                      height: 56,
                      margin: EdgeInsets.only(top: 20, bottom: 30),
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: GestureDetector(
                                onTap: () {
                                  getNavigation.Get.back();
                                  // context
                                  //     .read<PageBloc>()
                                  //     .add(GoToSplashPage());
                                },
                                child: Icon(
                                  MdiIcons.arrowLeft,
                                  color: Colors.black,
                                )),
                          ),
                          Center(
                              child: Text(
                            "Create New\nYour Account",
                            style: blackTextFont.copyWith(
                                fontSize: 20, fontWeight: FontWeight.w600),
                            textAlign: TextAlign.center,
                          )),
                        ],
                      ),
                    ),
                    Container(
                      width: 100,
                      height: 115,
                      child: Stack(
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: (widget.registrationData.profileImage ==
                                        null)
                                    ? AssetImage("assets/user_pic.png")
                                    : FileImage(
                                        widget.registrationData.profileImage),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: GestureDetector(
                              onTap: () async {
                                // TO DO: AMBIL FOTO PROFIL
                                if (widget.registrationData.profileImage ==
                                    null) {
                                  widget.registrationData.profileImage =
                                      await getImage();
                                } else {
                                  widget.registrationData.profileImage = null;
                                }

                                setState(() {});
                              },
                              child: Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: AssetImage(
                                        (widget.registrationData.profileImage ==
                                                null)
                                            ? "assets/btn_add_photo.png"
                                            : "assets/btn_change_photo.png"),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 36),
                    TextField(
                      style: blackTextFont,
                      controller: nameController,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: accentColor4, width: 1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: mainColor, width: 2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        labelText: "Full Name",
                        focusColor: Colors.green,
                        hintText: "Full Name",
                        hintStyle: greyTextFont.copyWith(
                            color: accentColor3, fontWeight: FontWeight.w500),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      style: blackTextFont,
                      textInputAction: TextInputAction.next,
                      controller: emailController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: accentColor4, width: 1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: mainColor, width: 2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        labelText: "Email Address",
                        hintText: "Email Address",
                      ),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      style: blackTextFont,
                      controller: passwordController,
                      textInputAction: TextInputAction.next,
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: accentColor4, width: 1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: mainColor, width: 2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        labelText: "Password",
                        hintText: "Password",
                      ),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      style: blackTextFont,
                      textInputAction: TextInputAction.done,
                      controller: confirmPasswordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: accentColor4, width: 1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: mainColor, width: 2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        labelText: "Confirm Password",
                        hintText: "Confirm Password",
                      ),
                    ),
                    SizedBox(height: 30),
                    FloatingActionButton(
                      elevation: 0,
                      backgroundColor: mainColor,
                      child: Icon(Icons.arrow_forward, color: Colors.white),
                      onPressed: () {
                        if (!(nameController.text.trim() != "" &&
                            emailController.text.trim() != "" &&
                            passwordController.text.trim() != "" &&
                            confirmPasswordController.text.trim() != "")) {
                          Flushbar(
                            margin: EdgeInsets.all(8),
                            borderRadius: 8,
                            duration: Duration(seconds: 2),
                            flushbarPosition: FlushbarPosition.TOP,
                            backgroundColor: Color(0xFFFF5B5B),
                            icon: Icon(
                              Icons.info_outline,
                              color: Colors.white,
                            ),
                            message: "Please fill all the fields.",
                          )..show(context);
                        } else if (!EmailValidator.validate(
                            emailController.text)) {
                          Flushbar(
                            margin: EdgeInsets.all(8),
                            borderRadius: 8,
                            duration: Duration(seconds: 2),
                            flushbarPosition: FlushbarPosition.TOP,
                            backgroundColor: Color(0xFFFF5B5B),
                            icon: Icon(
                              Icons.info_outline,
                              color: Colors.white,
                            ),
                            message: "Please enter a valid email address.",
                          )..show(context);
                        } else if (passwordController.text.length < 6) {
                          Flushbar(
                            margin: EdgeInsets.all(8),
                            borderRadius: 8,
                            duration: Duration(seconds: 2),
                            flushbarPosition: FlushbarPosition.TOP,
                            backgroundColor: Color(0xFFFF5B5B),
                            icon: Icon(
                              Icons.info_outline,
                              color: Colors.white,
                            ),
                            message: "Password must be at least 6 characters.",
                          )..show(context);
                        } else if (passwordController.text !=
                            confirmPasswordController.text) {
                          Flushbar(
                            margin: EdgeInsets.all(8),
                            borderRadius: 8,
                            duration: Duration(seconds: 2),
                            flushbarPosition: FlushbarPosition.TOP,
                            backgroundColor: Color(0xFFFF5B5B),
                            icon: Icon(
                              Icons.info_outline,
                              color: Colors.white,
                            ),
                            message: "Please make sure your passwords match.",
                          )..show(context);
                        } else {
                          widget.registrationData.name = nameController.text;
                          widget.registrationData.email = emailController.text;
                          widget.registrationData.password =
                              passwordController.text;

                          // TO DO : Go To Preference Page
                          getNavigation.Get.to(
                              PreferencePage(widget.registrationData),
                              transition: getNavigation.Transition.rightToLeft);
                          // context
                          //     .read<PageBloc>()
                          //     .add(GoToPreferencePage(widget.registrationData));
                        }
                      },
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
