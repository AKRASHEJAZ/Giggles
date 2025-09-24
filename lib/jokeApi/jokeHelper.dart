import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'joke.dart';

Future<List<Joke>> getJokes() async {
  var url = Uri.parse('https://official-joke-api.appspot.com/random_joke');
  var client = HttpClient();
  List<Joke> jokes = [];

  try {
    var request = await client.getUrl(url).timeout(const Duration(seconds: 15));
    var response = await request.close().timeout(const Duration(seconds: 15));

    if (response.statusCode == 200) {
      var responseBody = await response.transform(utf8.decoder).join();
      var jsonMap = jsonDecode(responseBody);
      var joke = Joke.fromJson(jsonMap);
      jokes.add(joke);
    }
  } on TimeoutException {
    jokes.add(
      Joke(
        setup: "Your internet is slower than a snail 🐌",
        punchline: "Even I timed out waiting!",
      ),
    );
  } catch (e) {
    jokes.add(
      Joke(
        setup: "Your internet is slower than a snail 🐌",
        punchline: "Maybe Your Provider Is A Better Joke",
      ),
    );
  } finally {
    client.close();
  }

  return jokes;
}
