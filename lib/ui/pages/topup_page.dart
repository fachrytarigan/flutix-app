part of 'pages.dart';

class TopUpPage extends StatefulWidget {
  // final PageEvent pageEvent;

  // TopUpPage(this.pageEvent);

  @override
  _TopUpPageState createState() => _TopUpPageState();
}

class _TopUpPageState extends State<TopUpPage> {
  MoneyMaskedTextController amountController = MoneyMaskedTextController(
      decimalSeparator: '',
      thousandSeparator: '.',
      leftSymbol: 'IDR ',
      precision: 0);
  int selectedAmount = 0;

  @override
  Widget build(BuildContext context) {
    context
        .watch<ThemeBloc>()
        .add(ChangeTheme(ThemeData().copyWith(primaryColor: accentColor3)));

    double cardWidth =
        (MediaQuery.of(context).size.width - 2 * defaultMargin - 2 * 15) / 3;

    return WillPopScope(
      onWillPop: () async {
        getNavigation.Get.back();
        // context.read<PageBloc>().add(widget.pageEvent);
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
                          defaultMargin, 20, defaultMargin, 40),
                      child: Stack(
                        children: [
                          //note: BACK BUTTON
                          Align(
                            alignment: Alignment.centerLeft,
                            child: GestureDetector(
                              onTap: () {
                                getNavigation.Get.back();
                                // context.read<PageBloc>().add(widget.pageEvent);
                              },
                              child: Icon(
                                MdiIcons.arrowLeft,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Center(
                            child: Text(
                              "Top Up",
                              style: blackTextFont.copyWith(fontSize: 20),
                            ),
                          ),
                        ],
                      ),
                    ),

                    //note: KONTEN
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(horizontal: defaultMargin),
                      child: Column(
                        children: [
                          TextField(
                            onChanged: (text) {
                              String temp = '';

                              for (int i = 0; i < text.length; i++) {
                                temp += text.isDigit(i) ? text[i] : '';
                              }
                              setState(() {
                                selectedAmount = int.tryParse(temp) ?? 0;
                              });

                              amountController.selection =
                                  TextSelection.collapsed(
                                      offset: amountController.text.length);
                            },
                            controller: amountController,
                            keyboardType: TextInputType.number,
                            style: whiteNumberFont.copyWith(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              labelText: "Amount",
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              margin: EdgeInsets.only(
                                top: 26,
                                bottom: 12,
                              ),
                              child: Text(
                                "Choose By Template",
                                style: blackTextFont.copyWith(fontSize: 14),
                              ),
                            ),
                          ),
                          Wrap(
                            spacing: 15,
                            runSpacing: 20,
                            children: [
                              makeMoneyTopUpCard(
                                width: cardWidth,
                                amount: 20000,
                              ),
                              makeMoneyTopUpCard(
                                width: cardWidth,
                                amount: 50000,
                              ),
                              makeMoneyTopUpCard(
                                width: cardWidth,
                                amount: 100000,
                              ),
                              makeMoneyTopUpCard(
                                width: cardWidth,
                                amount: 200000,
                              ),
                              makeMoneyTopUpCard(
                                width: cardWidth,
                                amount: 250000,
                              ),
                              makeMoneyTopUpCard(
                                width: cardWidth,
                                amount: 300000,
                              ),
                              makeMoneyTopUpCard(
                                width: cardWidth,
                                amount: 500000,
                              ),
                              makeMoneyTopUpCard(
                                width: cardWidth,
                                amount: 1000000,
                              ),
                              makeMoneyTopUpCard(
                                width: cardWidth,
                                amount: 2000000,
                              ),
                            ],
                          ),
                          SizedBox(height: 60),
                          SizedBox(
                            width: 250,
                            height: 50,
                            child: BlocBuilder<UserBloc, UserState>(
                              builder: (_, userState) => RaisedButton(
                                elevation: 0,
                                disabledColor: accentColor4,
                                color: Color(0xFF40A989),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Text(
                                  "Top Up Now",
                                  style: whiteTextFont.copyWith(
                                    color: (selectedAmount > 0)
                                        ? Colors.white
                                        : accentColor3,
                                  ),
                                ),
                                onPressed: (selectedAmount > 0)
                                    ? () {
                                        getNavigation.Get.to(
                                          SuccessPage(
                                            null,
                                            FlutixTransaction(
                                              userID: (userState as UserLoaded)
                                                  .user
                                                  .id,
                                              title: "Top Up Wallet",
                                              amount: selectedAmount,
                                              subtitle:
                                                  "${DateFormat.yMd().add_Hm().format(DateTime.now())}",
                                              time: DateTime.now(),
                                            ),
                                          ),
                                        );
                                        // context
                                        //     .read<PageBloc>()
                                        //     .add(GoToSuccessPage(
                                        //         null,
                                        //         FlutixTransaction(
                                        //           userID:
                                        //               (userState as UserLoaded)
                                        //                   .user
                                        //                   .id,
                                        //           title: "Top Up Wallet",
                                        //           amount: selectedAmount,
                                        //           subtitle:
                                        //               "${DateFormat.yMd().add_Hm().format(DateTime.now())}",
                                        //           time: DateTime.now(),
                                        //         )));
                                      }
                                    : null,
                              ),
                            ),
                          ),
                          SizedBox(height: 60),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  MoneyTopUpCard makeMoneyTopUpCard({int amount, double width}) {
    return MoneyTopUpCard(
      amount: amount,
      width: width,
      isSelected: amount == selectedAmount,
      onTap: () {
        setState(() {
          if (selectedAmount != amount) {
            selectedAmount = amount;
          } else {
            selectedAmount = 0;
          }

          amountController.text = NumberFormat.currency(
                  locale: 'id_ID', decimalDigits: 0, symbol: 'IDR ')
              .format(selectedAmount);

          amountController.selection =
              TextSelection.collapsed(offset: amountController.text.length);
        });
      },
    );
  }
}
