part of 'shared.dart';

const double defaultMargin = 24;

Color mainColor = Color(0xFF503E9D);
Color accentColor1 = Color(0xFF2C2157);
Color accentColor2 = Color(0xFFFFD439);
Color accentColor3 = Color(0xFFADADAD);
Color accentColor4 = Color(0xFFE4E4E4);

TextStyle blackTextFont = GoogleFonts.raleway()
    .copyWith(color: Colors.black, fontWeight: FontWeight.w600);
TextStyle whiteTextFont = GoogleFonts.raleway()
    .copyWith(color: Colors.white, fontWeight: FontWeight.w600);
TextStyle purpleTextFont = GoogleFonts.raleway()
    .copyWith(color: mainColor, fontWeight: FontWeight.w600);
TextStyle greyTextFont = GoogleFonts.raleway()
    .copyWith(color: accentColor3, fontWeight: FontWeight.w600);

TextStyle whiteNumberFont = GoogleFonts.roboto().copyWith(color: Colors.white);
TextStyle yellowNumberFont = GoogleFonts.roboto().copyWith(color: accentColor2);

BorderSide greyBorderInput = BorderSide(color: accentColor4, width: 1.0);
