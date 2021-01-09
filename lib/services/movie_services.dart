part of 'services.dart';

class MovieServices {
  static Future<List<Movie>> getMovies(int page, {http.Client client}) async {
    String url =
        "https://api.themoviedb.org/3/discover/movie?api_key=$apikey&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=$page";

    client ??= http.Client();

    var response = await client.get(url);

    if (response.statusCode != 200) {
      return [];
    }

    var data = jsonDecode(response.body);

    List result = data['results'];

    return result.map((e) => Movie.fromJson(e)).toList();
  }

  static Future<MovieDetail> getDetails(Movie movie,
      {int movieID, http.Client client}) async {
    String url =
        "https://api.themoviedb.org/3/movie/${movieID ?? movie.id}?api_key=$apikey&language=en-US";

    client ??= http.Client();

    var response = await client.get(url);

    var data = jsonDecode(response.body);

    List genres = data['genres'];
    String language;

    switch ((data as Map<String, dynamic>)['original_language'].toString()) {
      case 'en':
        language = "English";
        break;
      case 'id':
        language = "Indonesian";
        break;
      case 'ko':
        language = "Korean";
        break;
      case 'ja':
        language = "Japanese";
        break;
    }

    return movieID != null
        ? MovieDetail(Movie.fromJson(data),
            language: language,
            genres: genres
                .map((e) => (e as Map<String, dynamic>)['name'].toString())
                .toList())
        : MovieDetail(movie,
            language: language,
            genres: genres
                .map((e) => (e as Map<String, dynamic>)['name'].toString())
                .toList());
  }

  static Future<List<Credit>> getCredits(int movieID,
      {http.Client client}) async {
    String url =
        "https://api.themoviedb.org/3/movie/$movieID/credits?api_key=$apikey&language=en-US";

    client ??= http.Client();

    var response = await client.get(url);

    var data = jsonDecode(response.body);

    List cast = data['cast'];

    // return ((data as Map<String, dynamic>)['cast'] as List)
    //     .map((e) => Credit(
    //           name: (e as Map<String, dynamic>)['name'].toString(),
    //           profilePath:
    //               (e as Map<String, dynamic>)['profile_path'].toString(),
    //         ))
    //     .take(10)
    //     .toList();

    return cast.map((e) => Credit.fromJson(e)).take(10).toList();
  }
}
