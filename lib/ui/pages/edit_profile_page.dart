part of 'pages.dart';

class EditProfilePage extends StatefulWidget {
  final UserModel user;

  EditProfilePage(this.user);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmNewPasswordController = TextEditingController();

  String profilePath;
  bool isDataEdited = false;
  File profileImageFile;
  bool isUpdating = false;

  @override
  void initState() {
    super.initState();

    nameController.text = widget.user.name;
    emailController.text = widget.user.email;
    profilePath = widget.user.profilePicture;
  }

  @override
  Widget build(BuildContext context) {
    context
        .watch<ThemeBloc>()
        .add(ChangeTheme(ThemeData().copyWith(primaryColor: mainColor)));
    return WillPopScope(
      onWillPop: () async {
        getNavigation.Get.back();
        // context.read<PageBloc>().add(GoToProfilePage(widget.user));
        return;
      },
      child: Scaffold(
        body: Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: defaultMargin),
            child: ListView(
              children: [
                Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 20, bottom: 30),
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: GestureDetector(
                              child: GestureDetector(
                                onTap: () {
                                  getNavigation.Get.back();
                                },
                                child: Icon(
                                  MdiIcons.arrowLeft,
                                  color: Colors.black,
                                  size: 26,
                                ),
                              ),
                            ),
                          ),
                          Center(
                            child: Text(
                              "Edit Your\nProfile",
                              style: blackTextFont.copyWith(
                                  fontSize: 20, fontWeight: FontWeight.w600),
                              textAlign: TextAlign.center,
                            ),
                          ),
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
                                image: (profileImageFile != null)
                                    ? FileImage(profileImageFile)
                                    : (profilePath != "")
                                        ? NetworkImage(profilePath)
                                        : AssetImage("assets/user_pic.png"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: GestureDetector(
                              onTap: () async {
                                if (profilePath == "") {
                                  profileImageFile = await getImage();

                                  if (profileImageFile != null) {
                                    profilePath =
                                        basename(profileImageFile.path);
                                  }
                                } else {
                                  profileImageFile = null;
                                  profilePath = "";
                                }

                                setState(() {
                                  isDataEdited = (nameController.text.trim() !=
                                              widget.user.name ||
                                          profilePath !=
                                              widget.user.profilePicture)
                                      ? true
                                      : false;
                                });
                              },
                              child: Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        image: AssetImage(profilePath == ""
                                            ? "assets/btn_add_photo.png"
                                            : "assets/btn_change_photo.png"))),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 30),

                    //note: Email Address (disabled)
                    TextField(
                      enabled: false,
                      //readOnly: true,
                      style: greyTextFont,
                      controller: emailController,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: accentColor4, width: 1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        labelText: "Email Address",
                        hintText: "Email Address",
                        hintStyle: greyTextFont.copyWith(
                            color: accentColor3, fontWeight: FontWeight.w500),
                      ),
                    ),

                    SizedBox(height: 20),

                    // note: Full Name
                    TextField(
                      style: blackTextFont,
                      controller: nameController,
                      onChanged: (text) {
                        setState(() {
                          isDataEdited = (text.trim() != widget.user.name ||
                                  profilePath != widget.user.profilePicture)
                              ? true
                              : false;
                        });
                      },
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: accentColor4, width: 1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        labelText: "Full Name",
                        hintText: "Full Name",
                        hintStyle: greyTextFont.copyWith(
                            color: accentColor3, fontWeight: FontWeight.w500),
                      ),
                    ),

                    SizedBox(height: 30),
                    //note: Button Update My Profile
                    Container(
                      width: 270,
                      height: 50,
                      child: isUpdating
                          ? SpinKitRing(color: mainColor)
                          : RaisedButton(
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              disabledColor: accentColor4,
                              color: Color(0xFF40A989),
                              child: Text(
                                "Update My Profile",
                                style: whiteTextFont.copyWith(
                                    fontSize: 16,
                                    color: isDataEdited
                                        ? Colors.white
                                        : accentColor3),
                              ),
                              onPressed: isDataEdited
                                  ? () async {
                                      setState(() {
                                        isUpdating = true;
                                      });

                                      if (profileImageFile != null) {
                                        profilePath =
                                            await uploadImage(profileImageFile);
                                      }
                                      context.read<UserBloc>().add(UpdateData(
                                            name: nameController.text,
                                            profileImage: profilePath,
                                          ));

                                      getNavigation.Get.back();
                                    }
                                  : null,
                            ),
                    ),
                    SizedBox(height: 40),
                  ],
                )
              ],
            )),
      ),
    );
  }
}
