part of 'widgets.dart';

class PromoCard extends StatelessWidget {
  final Promo promo;

  PromoCard(this.promo);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: mainColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8), bottomLeft: Radius.circular(8)),
              child: SizedBox(
                  height: 80,
                  child: Image.asset("assets/rectangle_reflection_1.png")),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(8),
                  bottomRight: Radius.circular(8)),
              child: SizedBox(
                  height: 75,
                  child: Image.asset("assets/ellipse_reflection_1.png")),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(8),
                  bottomRight: Radius.circular(8)),
              child: SizedBox(
                  height: 65,
                  child: Image.asset("assets/ellipse_reflection_2.png")),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        promo.title,
                        style: whiteTextFont.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        promo.subtitle,
                        style: whiteTextFont.copyWith(
                          fontSize: 11,
                          color: Color(0xFFA698E2),
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "DISCOUNT ",
                      style: yellowNumberFont.copyWith(
                        fontSize: 14,
                        color: accentColor2,
                        fontWeight: FontWeight.w100,
                      ),
                    ),
                    Text(
                      "${promo.discount}%",
                      style: yellowNumberFont.copyWith(
                        fontSize: 14,
                        color: accentColor2,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
