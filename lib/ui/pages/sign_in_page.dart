part of 'pages.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isEmailValid = false;
  bool isPasswordValid = false;
  bool isSigningIn = false;

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ThemeBloc>(context)
        .add(ChangeTheme(ThemeData().copyWith(primaryColor: mainColor)));
    return WillPopScope(
      onWillPop: () {
        getNavigation.Get.back();
        return;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: defaultMargin),
          child: ScrollConfiguration(
            behavior: ScrollBehavior()
              ..buildViewportChrome(context, null, AxisDirection.down),
            child: ListView(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      height: 70,
                      child: Image.asset("assets/logo.png"),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 40, bottom: 76),
                      child: Text(
                        "Welcome Back,\nExplorer!",
                        style: blackTextFont.copyWith(fontSize: 20),
                      ),
                    ),
                    TextField(
                      onChanged: (text) {
                        setState(() {
                          isEmailValid = EmailValidator.validate(text);
                        });
                      },
                      controller: emailController,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        labelText: "Email Address",
                        hintText: "Email Adress",
                      ),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      onChanged: (text) {
                        setState(() {
                          isPasswordValid = text.length >= 6;
                        });
                      },
                      controller: passwordController,
                      textInputAction: TextInputAction.done,
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        labelText: "Password",
                        hintText: "Password",
                      ),
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Forgot Password? ",
                          style: greyTextFont.copyWith(
                              fontSize: 12, fontWeight: FontWeight.w400),
                        ),
                        GestureDetector(
                          onTap: () {
                            context.read<PageBloc>().add(GoToLoginPage());
                          },
                          child: Text(
                            "Click Here",
                            style: purpleTextFont.copyWith(fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                    Center(
                      child: Container(
                        margin: EdgeInsets.only(top: 40, bottom: 40),
                        child: isSigningIn
                            ? SpinKitRing(
                                color: mainColor,
                              )
                            : FloatingActionButton(
                                elevation: 0.0,
                                backgroundColor: isEmailValid && isPasswordValid
                                    ? mainColor
                                    : accentColor4,
                                child: Icon(
                                  Icons.arrow_forward,
                                  color: isEmailValid && isPasswordValid
                                      ? Colors.white
                                      : accentColor3,
                                ),
                                onPressed: isEmailValid && isPasswordValid
                                    ? () async {
                                        setState(() {
                                          isSigningIn = true;
                                        });

                                        SignInSignUpResult result =
                                            await AuthServices.signIn(
                                                emailController.text,
                                                passwordController.text);

                                        if (result.user == null) {
                                          setState(() {
                                            isSigningIn = false;
                                          });

                                          Flushbar(
                                            margin: EdgeInsets.all(8),
                                            borderRadius: 8,
                                            duration: Duration(seconds: 3),
                                            flushbarPosition:
                                                FlushbarPosition.TOP,
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
                                      }
                                    : null,
                              ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Start Fresh Now? ",
                          style: greyTextFont.copyWith(
                              fontSize: 14, fontWeight: FontWeight.w400),
                        ),
                        GestureDetector(
                          onTap: () {
                            context.read<PageBloc>().add(GoToLoginPage());
                          },
                          child: Text(
                            "Register",
                            style: purpleTextFont.copyWith(fontSize: 14),
                          ),
                        ),
                      ],
                    ),
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
