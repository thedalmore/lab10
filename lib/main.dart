import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF8F0FE),
      ),
      home: const FirstScreen(),
    );
  }
}

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  final TextEditingController _controller = TextEditingController();
  double _fontSize = 20.0;

  void _showResultDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFFFDF7FF),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.network(
              'https://emojiisland.com/cdn/shop/products/Robot_Emoji_Icon_abe1111a-1293-4668-bdf9-9ceb05cff58e_large.png?v=1571606090',
              height: 60,
            ),
            const SizedBox(height: 20),
            Text(
              message,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK', style: TextStyle(color: Color(0xFF5D4E7B), fontSize: 18)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFC7B1F7),
        title: const Text('Text previewer', style: TextStyle(fontSize: 20)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Text',
                helperText: 'Enter some text',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 30),

            Row(
              children: [
                Text('Font size: ${_fontSize.toInt()}', style: const TextStyle(fontSize: 16)),
                Expanded(
                  child: Slider(
                    value: _fontSize,
                    min: 10,
                    max: 100,
                    activeColor: const Color(0xFF5D4E7B),
                    onChanged: (value) => setState(() => _fontSize = value),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),

            ElevatedButton(
              onPressed: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SecondScreen(
                      text: _controller.text,
                      fontSize: _fontSize,
                    ),
                  ),
                );

                if (result == 'ok') {
                  _showResultDialog('Cool!');
                } else if (result == 'cancel') {
                  _showResultDialog('Let’s try something else');
                } else {
                  _showResultDialog("Don't know what to say");
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF534674),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                shape: const StadiumBorder(),
              ),
              child: const Text('Preview', style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  final String text;
  final double fontSize;

  const SecondScreen({super.key, required this.text, required this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFC7B1F7),
        title: const Text('Preview'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Text(
                  text.isEmpty ? "No text" : text,
                  style: TextStyle(fontSize: fontSize),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 40.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context, 'ok'),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.green.shade100),
                    child: const Text('Ok', style: TextStyle(color: Colors.black)),
                  ),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context, 'cancel'),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red.shade100),
                    child: const Text('Cancel', style: TextStyle(color: Colors.black)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}