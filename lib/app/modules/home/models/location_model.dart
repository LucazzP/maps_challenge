class LocationModel {
  final String city;
  final String state;
  final String country;
  final String neighborhood;

  LocationModel(this.city, this.state, this.country, this.neighborhood);

  @override
  String toString() {
    String string = '';
    if(neighborhood != null) string += neighborhood;
    if(city != null && country != null){
      if(neighborhood != null) string += ', ';
      string += city + ' - ' + country;
    }
    return string;
  }
}