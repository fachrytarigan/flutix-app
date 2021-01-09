part of 'pages.dart';

class WalletPage extends StatelessWidget {
  final Widget pageEvent;

  WalletPage(this.pageEvent);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        getNavigation.Get.off(
          pageEvent,
          transition: getNavigation.Transition.leftToRight,
        );
        // context.read<PageBloc>().add(pageEvent);
        return;
      },
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              color: mainColor,
            ),
            SafeArea(
              child: Container(
                color: Colors.white,
                child: ListView(
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(
                          defaultMargin, 20, defaultMargin, 30),
                      child: Stack(
                        children: [
                          //note: BACK BUTTON
                          Align(
                            alignment: Alignment.centerLeft,
                            child: GestureDetector(
                              onTap: () {
                                getNavigation.Get.off(
                                  pageEvent,
                                  transition:
                                      getNavigation.Transition.leftToRight,
                                );
                                // context.read<PageBloc>().add(pageEvent);
                              },
                              child: Icon(
                                MdiIcons.arrowLeft,
                                color: Colors.black,
                                size: 26,
                              ),
                            ),
                          ),
                          Center(
                            child: Text(
                              "My Wallet",
                              style: blackTextFont.copyWith(fontSize: 20),
                            ),
                          ),
                        ],
                      ),
                    ),

                    //note: WALLET CARD
                    Container(
                      margin: EdgeInsets.only(
                        left: defaultMargin,
                        right: defaultMargin,
                        bottom: 20,
                      ),
                      width: double.infinity,
                      height: 190,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomLeft,
                          end: Alignment.topRight,
                          colors: [
                            Color(0xFF342574).withOpacity(1),
                            mainColor.withOpacity(1),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xFF503E9D).withOpacity(0.40),
                            offset: Offset(0, 4),
                            blurRadius: 15,
                            spreadRadius: 0,
                          )
                        ],
                      ),
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(16),
                              ),
                              child: SizedBox(
                                height: 130,
                                child: Image.asset(
                                    "assets/wallet_ellipse_reflection_left.png"),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(16),
                                bottomRight: Radius.circular(16),
                              ),
                              child: SizedBox(
                                height: 190,
                                child: Image.asset(
                                    "assets/wallet_ellipse_reflection_right.png"),
                              ),
                            ),
                          ),
                          BlocBuilder<UserBloc, UserState>(
                            builder: (_, userState) {
                              UserModel user = (userState as UserLoaded).user;
                              return Container(
                                margin: EdgeInsets.all(20),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    //note: BALANCE
                                    Text(
                                      NumberFormat.currency(
                                              locale: 'id_ID',
                                              symbol: 'IDR ',
                                              decimalDigits: 0)
                                          .format(user.balance),
                                      style: yellowNumberFont.copyWith(
                                          fontSize: 30,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    Row(
                                      children: [
                                        //note: CARD HOLDER
                                        Flexible(
                                          flex: 4,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Card Holder",
                                                style: whiteTextFont.copyWith(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w300,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 4,
                                              ),
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Flexible(
                                                    flex: 6,
                                                    child: RichText(
                                                      text: TextSpan(
                                                        text: "${user.name}",
                                                        style: whiteTextFont
                                                            .copyWith(
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.clip,
                                                    ),
                                                  ),
                                                  SizedBox(width: 4),
                                                  Flexible(
                                                    flex: 1,
                                                    child: SizedBox(
                                                      width: 16,
                                                      height: 16,
                                                      child: Image.asset(
                                                          "assets/ic_check.png"),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),

                                        //note: ID CARD
                                        Flexible(
                                          flex: 3,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "ID Card",
                                                style: whiteTextFont.copyWith(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w300,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 4,
                                              ),
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "HDKABHFB",
                                                    style:
                                                        whiteTextFont.copyWith(
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 4,
                                                  ),
                                                  SizedBox(
                                                    width: 16,
                                                    height: 16,
                                                    child: Image.asset(
                                                        "assets/ic_check.png"),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),

                    //note:  RECENT TRANSACTION
                    Padding(
                      padding: EdgeInsets.only(left: defaultMargin, bottom: 16),
                      child: Text(
                        "Recent Transaction",
                        style: blackTextFont.copyWith(fontSize: 14),
                      ),
                    ),
                    BlocBuilder<UserBloc, UserState>(
                      builder: (_, userState) {
                        UserModel user = (userState as UserLoaded).user;
                        return FutureBuilder(
                          future:
                              FlutixTransactionServices.getTransaction(user.id),
                          builder: (_, snapshot) {
                            if (snapshot.hasData) {
                              return generateTransactionList(
                                  snapshot.data,
                                  MediaQuery.of(context).size.width -
                                      2 * defaultMargin);
                            } else {
                              return SpinKitRing(
                                color: mainColor,
                                size: 50,
                              );
                            }
                          },
                        );
                      },
                    ),

                    
                  ],
                ),
              ),
            ),
            //note: TOP UP BUTTON
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: 250,
                height: 50,
                margin: EdgeInsets.only(
                  bottom: 30,
                ),
                child: RaisedButton(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  color: mainColor,
                  child: Text(
                    "Top Up My Wallet",
                    style: whiteTextFont,
                  ),
                  onPressed: () {
                    getNavigation.Get.to(
                      TopUpPage(),
                      transition: getNavigation.Transition.downToUp,
                    );
                    // context
                    //     .read<PageBloc>()
                    //     .add(GoToTopUpPage(GoToWalletPage(pageEvent)));
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Column generateTransactionList(
      List<FlutixTransaction> transactions, double width) {
    transactions.sort((transaction1, transaction2) =>
        transaction2.time.compareTo(transaction1.time));
    return Column(
      children: transactions
          .map((transaction) => Padding(
                padding: EdgeInsets.only(bottom: 6),
                child: Column(
                  children: [
                    TransactionCard(transaction, width),
                    Container(
                      margin: EdgeInsets.only(
                        top: 6,
                        left: defaultMargin,
                        //right: defaultMargin,
                      ),
                      child: Divider(
                        color: accentColor4,
                        thickness: 1,
                      ),
                    ),
                  ],
                ),
              ))
          .toList(),
    );
  }
}
