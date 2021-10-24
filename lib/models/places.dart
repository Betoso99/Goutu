class Places {
  final String entries;
  final String km;
  final String price;
  final String image;
  final int transferNum;

  Places(this.entries, this.km, this.price, this.image, this.transferNum);

  @override
  String toString() {
    return 'entries: $entries, km: $km, price: $price, image: $image, '
        'transferNum: $transferNum';
  }
}


