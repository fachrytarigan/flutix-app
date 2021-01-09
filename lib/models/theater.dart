part of 'models.dart';

class Theater extends Equatable {
  final String name;

  Theater(this.name);

  @override
  List<Object> get props => [name];
}

List<Theater> dummytheaters = [
  Theater("XXI Ringroad City Walk"),
  Theater("XXI Plaza Millenium"),
  Theater("XXI Hermes Mall"),
  Theater("XXI Thamrin Plaza"),
  Theater("CGV Focal Point"),
  Theater("Cinepolis Lippo Plaza"),
];
