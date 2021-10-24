import 'places.dart';

class ListPages {
  final List<Places> suggest;
  final List<Places> favorites;

  ListPages(this.suggest, this.favorites);
}

// final List<String> entries = <String>[
//   'Jardin Botanico',
//   'Marbella',
//   'Los Tres Ojos'
// ];
//
// final List<String> km = <String>['1.5km', '2.5km', '1km'];
//
// final List<String> precios = <String>['DOP 95', 'DOP 120', 'DOP 75'];
//
// final List<String> imagesSRC = <String>[
//   "https://images.visitarepublicadominicana.org/jardin-botanico-santo-domingo.jpg",
//   "https://www.marbella-hills-homes.com/cms/wp-content/uploads/2020/12/1.jpg",
//   "https://images.visitarepublicadominicana.org/los-tres-ojos-santo-domingo.jpg"
// ];