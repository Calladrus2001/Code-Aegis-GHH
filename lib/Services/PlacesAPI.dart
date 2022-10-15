import 'package:code_margerita/Models/PlaceModel.dart';
import 'package:code_margerita/secrets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class NearYouAPI {
  Future<PlaceModel> getResult(Position pos) async {
    final Uri url = Uri.parse(
        "https://maps.googleapis.com/maps/api/place/textsearch/json?key=${Places_API_KEY}&location=${pos.latitude},${pos.longitude}&query=therapist&type=health&radius=2000");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return placeModelFromJson(response.body);
    } else {
      return placeModelFromJson(response.body);
    }
  }
}
