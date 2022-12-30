import 'package:http/http.dart' as http;
import 'package:intro/utils/post.dart';

class RemoteService{
  Future <List<Post>?> getPost() async {
    var client = http.Client();

    var uri = Uri.parse('https://fakestoreapi.com/products');
    var response = await client.get(uri);
    if(response.statusCode == 200){
      var json = response.body;
      return postFromJson(json);
    }
  }
}