part of 'models.dart';

class Promo extends Equatable {
  final String title;
  final String subtitle;
  final int discount;

  Promo({
    @required this.title,
    @required this.subtitle,
    @required this.discount,
  });

  @override
  List<Object> get props => [title, subtitle, discount];
}

List<Promo> dummyPromo = [
  Promo(
    title: "Promo Libur Sekolah",
    subtitle: "Maks. untuk dua orang",
    discount: 50,
  ),
  Promo(
    title: "Geng Keluarga",
    subtitle: "Min. dua orang anggota keluarga",
    discount: 60,
  ),
  Promo(
    title: "Langsung Setahun",
    subtitle: "Khusus pembayaran dengan LinkAja",
    discount: 75,
  ),
];
