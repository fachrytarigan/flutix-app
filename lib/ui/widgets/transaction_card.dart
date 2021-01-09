part of 'widgets.dart';

class TransactionCard extends StatelessWidget {
  final FlutixTransaction transaction;
  final double width;

  TransactionCard(this.transaction, this.width);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(left: defaultMargin, right: defaultMargin),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(right: 16),
            width: 70,
            height: 90,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: (transaction.picture != null)
                    ? NetworkImage(imageBaseURL + "w500" + transaction.picture)
                    : AssetImage("assets/bg_top_up.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            children: [
              SizedBox(
                width: width - 70 - 16,
                child: Text(
                  transaction.title,
                  style: blackTextFont.copyWith(fontSize: 16),
                  maxLines: 2,
                  overflow: TextOverflow.clip,
                ),
              ),
              SizedBox(
                height: 6,
              ),
              SizedBox(
                width: width - 70 - 16,
                child: Text(
                  NumberFormat.currency(
                    locale: 'id_ID',
                    symbol: 'IDR ',
                    decimalDigits: 0,
                  ).format(transaction.amount < 0
                      ? -transaction.amount
                      : transaction.amount),
                  style: whiteNumberFont.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: transaction.amount < 0
                        ? Color(0xFFFF5B5B)
                        : Color(0xFF40A989),
                  ),
                ),
              ),
              SizedBox(
                height: 6,
              ),
              SizedBox(
                width: width - 70 - 16,
                child: Text(
                  transaction.subtitle,
                  style: greyTextFont.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
