part of 'widgets.dart';

class CreditCard extends StatelessWidget {
  final Credit credits;

  CreditCard(this.credits);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.grey[400],
            image: (credits.profilePath == null)
                ? null
                : DecorationImage(
                    image: NetworkImage(
                        imageBaseURL + "w185" + credits.profilePath),
                    fit: BoxFit.cover,
                  ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 6),
          width: 60,
          child: Text(
            credits.name,
            style: blackTextFont.copyWith(
                fontSize: 10, fontWeight: FontWeight.w400),
            maxLines: 2,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        )
      ],
    );
  }
}
