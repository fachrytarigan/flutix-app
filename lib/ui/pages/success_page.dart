part of 'pages.dart';

class SuccessPage extends StatelessWidget {
  final Ticket ticket;
  final FlutixTransaction transaction;

  SuccessPage(this.ticket, this.transaction);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return;
      },
      child: Scaffold(
        body: FutureBuilder(
          future: ticket != null
              ? processingTicketOrder(context)
              : processingTopUp(context),
          builder: (_, snapshot) => (snapshot.connectionState ==
                  ConnectionState.done)
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 150,
                      height: 150,
                      margin: EdgeInsets.only(bottom: 55),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(ticket == null
                              ? "assets/ill_top_up.png"
                              : "assets/ill_tickets.png"),
                        ),
                      ),
                    ),
                    Text(
                      (ticket == null) ? "Yeayy Finally!" : "Happy Watching!",
                      style: blackTextFont.copyWith(
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      (ticket == null)
                          ? "You have successfully\ntop up your wallet"
                          : "You have successfully\nbought the ticket",
                      style: greyTextFont.copyWith(
                          fontSize: 16, fontWeight: FontWeight.w400),
                      textAlign: TextAlign.center,
                    ),
                    Container(
                      width: 250,
                      height: 45,
                      margin: EdgeInsets.only(top: 70, bottom: 20),
                      child: RaisedButton(
                        child: Text(
                          (ticket == null) ? "My Wallet" : "My Tickets",
                          style: whiteTextFont.copyWith(fontSize: 16),
                        ),
                        color: mainColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        onPressed: () {
                          (ticket == null)
                              ? getNavigation.Get.offAll(WalletPage(MainPage()))
                              // ? context
                              //     .read<PageBloc>()
                              //     .add(GoToWalletPage(GoToMainPage()))
                              : getNavigation.Get.off(
                                  MainPage(
                                    bottomNavbarIndex: 1,
                                  ),
                                  transition: getNavigation.Transition.fadeIn,
                                );
                          // context.read<PageBloc>()
                          // .add(GoToMainPage(bottomNavigationIndex: 1));
                        },
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Discover new movie? ",
                          style: greyTextFont.copyWith(
                              fontSize: 14, fontWeight: FontWeight.w400),
                        ),
                        GestureDetector(
                          onTap: () {
                            getNavigation.Get.offAll(
                              MainPage(),
                              transition: getNavigation.Transition.fadeIn,
                            );
                            // context.read<PageBloc>().add(GoToMainPage());
                          },
                          child: Text(
                            "Back to Home",
                            style: purpleTextFont.copyWith(fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              : Center(
                  child: SpinKitRing(
                    color: mainColor,
                    size: 50,
                  ),
                ),
        ),
      ),
    );
  }

  Future<void> processingTicketOrder(BuildContext context) async {
    BlocProvider.of<UserBloc>(context).add(Purchase(ticket.totalPrice));
    //context.read<UserBloc>().add(Purchase(ticket.totalPrice));

    BlocProvider.of<TicketBloc>(context)
        .add(BuyTicket(ticket, transaction.userID));
    //context.read<TicketBloc>().add(BuyTicket(ticket, transaction.userID));

    await FlutixTransactionServices.saveTransaction(transaction);
  }

  Future<void> processingTopUp(BuildContext context) async {
    BlocProvider.of<UserBloc>(context).add(TopUp(transaction.amount));

    await FlutixTransactionServices.saveTransaction(transaction);
  }
}
