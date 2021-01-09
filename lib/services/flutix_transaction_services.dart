part of 'services.dart';

class FlutixTransactionServices {
  static CollectionReference _transactionCollection =
      FirebaseFirestore.instance.collection('transactions');

  static Future<void> saveTransaction(
      FlutixTransaction flutixTransaction) async {
    await _transactionCollection.doc().set({
      'userID': flutixTransaction.userID,
      'title': flutixTransaction.title,
      'subtitle': flutixTransaction.subtitle,
      'amount': flutixTransaction.amount,
      'time': flutixTransaction.time.microsecondsSinceEpoch,
      'picture': flutixTransaction.picture,
    });
  }

  static Future<List<FlutixTransaction>> getTransaction(String userId) async {
    QuerySnapshot snapshot = await _transactionCollection.get();

    var documents =
        snapshot.docs.where((document) => document.data()['userID'] == userId);

    return documents
        .map((e) => FlutixTransaction(
              userID: e.data()['userID'],
              title: e.data()['title'],
              subtitle: e.data()['subtitle'],
              time: DateTime.fromMicrosecondsSinceEpoch(e.data()['time']),
              amount: e.data()['amount'],
              picture: e.data()['picture'],
            ))
        .toList();
  }
}
