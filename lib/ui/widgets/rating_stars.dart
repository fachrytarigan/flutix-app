part of 'widgets.dart';

class RatingStars extends StatelessWidget {
  final double voteAverage;
  final double starSize;
  final double fontSize;
  final Color fontColor;
  final MainAxisAlignment mainAxisAlignment;

  RatingStars({
    this.voteAverage = 0,
    this.starSize = 17,
    this.fontSize = 11,
    this.fontColor,
    this.mainAxisAlignment,
  });

  @override
  Widget build(BuildContext context) {
    int n = (voteAverage / 2).round();

    List<Widget> widgets = List.generate(
        5,
        (index) => Icon(
              MdiIcons.star,
              color: (index < n) ? accentColor2 : Colors.grey.withOpacity(0.5),
              size: starSize,
            ));

    widgets.add(SizedBox(
      width: 5,
    ));

    widgets.add(
      Text(
        "$voteAverage/10",
        style: whiteNumberFont.copyWith(
            color: fontColor, fontSize: fontSize, fontWeight: FontWeight.w300),
      ),
    );
    return Row(
      mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.center,
      children: widgets,
    );
  }
}
