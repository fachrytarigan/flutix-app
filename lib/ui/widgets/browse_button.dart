part of 'widgets.dart';

class BrowseButton extends StatelessWidget {
  final String genre;

  BrowseButton(this.genre);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      child: Column(
        children: [
          Container(
            //width: 70,
            height: 55,
            padding: EdgeInsets.all(7),
            decoration: ShapeDecoration(
              color: Color(0xFFEAEAEA),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: SizedBox(
              child: Image.asset((genre == "Action")
                  ? "assets/ic_action.png"
                  : (genre == "Music")
                      ? "assets/ic_music.png"
                      : (genre == "Horror")
                          ? "assets/ic_horror.png"
                          : (genre == "Drama")
                              ? "assets/ic_horror.png"
                              : (genre == "War")
                                  ? "assets/ic_war.png"
                                  : (genre == "Crime")
                                      ? "assets/ic_war.png"
                                      : ""),
            ),
          ),
          SizedBox(
            height: 4,
          ),
          Text(
            genre,
            style: blackTextFont.copyWith(
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
