import 'package:http/http.dart' as http;
import 'package:recip_app/models/reciepemodel.dart';
// ignore_for_file: avoid_print


recipesItems() async {
  Uri url = Uri.parse("https://dummyjson.com/recipes");
  var response = await http.get(url);
  try {
    if (response.statusCode == 200) {
      var data = recipeModelFromJson(response.body);
      return data.recipes;
    } else {
      print("Error Occured");
    }
  } catch (e) {
    print(e.toString());
  }
}
