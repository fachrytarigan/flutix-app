part of 'widgets.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;
  final Function onTap;

  MovieCard(this.movie, {this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onTap != null) {
          onTap();
        }
      },
      child: Container(
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          shadows: [
            BoxShadow(
              color: Colors.black.withOpacity(0.8),
              blurRadius: 4,
            )
          ],
        ),
        child: Container(
          height: 130,
          width: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              image: NetworkImage(imageBaseURL + "w780" + movie.backdropPath),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            height: 130,
            width: 200,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.black.withOpacity(0.70),
                  Colors.black.withOpacity(0),
                ],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  movie.title,
                  style: whiteTextFont.copyWith(
                      fontSize: 14, fontWeight: FontWeight.w500),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(
                  height: 3,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    RatingStars(
                      voteAverage: movie.voteAverage,
                      fontSize: 12,
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
