import 'package:flutter/material.dart';
import '../miscs/colorScheme.dart';
import 'package:demo/jokeApi/jokeHelper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _joke = "Loading a lame joke... 🤔";

  @override
  void initState() {
    super.initState();
    _fetchJoke();
  }

  Future<void> _fetchJoke() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          backgroundColor: MyColors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(MyColors.secondary),
                ),
                const SizedBox(height: 16),
                Text(
                  _getFunnyLoadingText(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: MyColors.secondary,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
    var jokes = await getJokes();

    if (mounted) Navigator.of(context).pop();

    if (jokes.isNotEmpty) {
      setState(() {
        _joke = "${jokes[0].setup}\n\n${jokes[0].punchline}";
      });
    } else {
      setState(() {
        _joke = "Looks like your Network went on a coffee break ☕😂";
      });
    }
  }

  String _getFunnyLoadingText() {
    final messages = [
      "Polishing the punchline... 🛠️😂",
      "Tickling the servers for a joke... 🤖",
      "Knocking on humor’s door... 🚪🤣",
      "Cooking up some comedy stew... 🍲😅",
      "Shaking the joke tree... 🌳😂",
    ];
    messages.shuffle();
    return messages.first;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.primary,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(200),
        child: AppBar(
          backgroundColor: MyColors.secondary,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(48)),
          ),
          flexibleSpace: Center(
            child: Text(
              "Giggles",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 48,
                fontWeight: FontWeight.w500,
                letterSpacing: 2,
              ),
            ),
          ),
        ),
      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(24),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: MyColors.primary,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: MyColors.secondary.withOpacity(0.5),
                blurRadius: 32,
                offset: const Offset(2, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.emoji_emotions, size: 96, color: MyColors.accent),
              const SizedBox(height: 16),
              Text(
                _joke,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: MyColors.secondary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: SizedBox(
        width: 80,
        height: 80,
        child: RawMaterialButton(
          shape: const CircleBorder(),
          fillColor: MyColors.secondary,
          elevation: 6,
          onPressed: _fetchJoke,
          child: const Icon(
            Icons.refresh_rounded,
            color: Colors.white,
            size: 36,
          ),
        ),
      ),
    );
  }
}
