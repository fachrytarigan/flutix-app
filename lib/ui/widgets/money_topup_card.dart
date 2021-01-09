part of 'widgets.dart';

class MoneyTopUpCard extends StatelessWidget {
  final double width;
  final bool isSelected;
  final int amount;
  final Function onTap;

  MoneyTopUpCard({
    this.width = 94,
    this.isSelected = false,
    this.amount = 0,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onTap != null) {
          onTap();
        }
      },
      child: Container(
        width: width,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: isSelected ? Colors.transparent : accentColor4,
          ),
          color: isSelected ? accentColor2 : Colors.transparent,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "IDR",
              style: whiteNumberFont.copyWith(
                color: accentColor3,
                fontSize: 15,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              NumberFormat.currency(
                locale: "id_ID",
                decimalDigits: 0,
                symbol: '',
              ).format(amount),
              style: whiteNumberFont.copyWith(
                color: Colors.black,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
