part of 'services.dart';

class TicketServices {
  static CollectionReference _ticketCollection =
      FirebaseFirestore.instance.collection('tickets');

  static Future<void> saveTicket(String id, Ticket ticket) async {
    await _ticketCollection.doc().set({
      'movieID': ticket.movieDetail.id ?? "",
      'userID': id ?? "",
      'theaterName': ticket.theater.name ?? 0,
      'time': ticket.time.microsecondsSinceEpoch ??
          DateTime.now().microsecondsSinceEpoch,
      'bookingCode': ticket.bookingCode,
      'seats': ticket.seatsInString,
      'name': ticket.name,
      'totalPrice': ticket.totalPrice,
    });
  }

  static Future<List<Ticket>> getTicket(String userId) async {
    QuerySnapshot snapshot = await _ticketCollection.get();

    var documents =
        snapshot.docs.where((document) => document.data()['userID'] == userId);

    List<Ticket> tickets = [];

    for (var document in documents) {
      MovieDetail movieDetail = await MovieServices.getDetails(null,
          movieID: document.data()['movieID']);
      tickets.add(Ticket(
        movieDetail,
        Theater(document.data()['theaterName']),
        DateTime.fromMicrosecondsSinceEpoch(document.data()['time']),
        document.data()['bookingCode'],
        document.data()['seats'].toString().split(','),
        document.data()['name'],
        document.data()['totalPrice'],
      ));
    }

    return tickets;
  }
}
