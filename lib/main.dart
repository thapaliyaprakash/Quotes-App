import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

// A simple Quote model with a text and favorite status.
class Quote {
  final String text;
  bool isFavorite;
  Quote(this.text, {this.isFavorite = false});
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quotes App',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: QuotesHomePage(),
    );
  }
}

class QuotesHomePage extends StatefulWidget {
  const QuotesHomePage({super.key});

  @override
  _QuotesHomePageState createState() => _QuotesHomePageState();
}

class _QuotesHomePageState extends State<QuotesHomePage> {
  // 0 for Home Page, 1 for Favorites Page.
  int _selectedPage = 0;

  // List of 15 inspirational quotes.
  List<Quote> quotes = [
    Quote("The only limit to our realization of tomorrow is our doubts of today."),
    Quote("Don't watch the clock; do what it does. Keep going."),
    Quote("The future belongs to those who believe in the beauty of their dreams."),
    Quote("Progress is impossible without change."),
    Quote("Believe you can and you're halfway there."),
    Quote("Keep your face always toward the sunshine—and shadows will fall behind you."),
    Quote("The secret of getting ahead is getting started."),
    Quote("Success is not final, failure is not fatal: It is the courage to continue that counts."),
    Quote("What you do today can improve all your tomorrows."),
    Quote("The best way to predict the future is to create it."),
    Quote("Don't wait for opportunity. Create it."),
    Quote("Dream big and dare to fail."),
    Quote("Change your thoughts and you change your world."),
    Quote("Every day may not be good... but there's something good in every day."),
    Quote("Your passion is waiting for your courage to catch up."),
  ];

  // Toggles the favorite status of a quote.
  void toggleFavorite(Quote quote) {
    setState(() {
      quote.isFavorite = !quote.isFavorite;
    });
  }

  // Builds a list view of quotes.
  Widget _buildQuotesList(List<Quote> quotesList) {
    return ListView.builder(
      itemCount: quotesList.length,
      itemBuilder: (context, index) {
        Quote quote = quotesList[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          elevation: 3,
          child: ListTile(
            title: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                quote.text,
                style: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
              ),
            ),
            trailing: IconButton(
              icon: Icon(
                quote.isFavorite ? Icons.favorite : Icons.favorite_border,
                color: quote.isFavorite ? Colors.pink : null,
              ),
              onPressed: () {
                toggleFavorite(quote);
              },
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Define pages based on the selected index.
    List<Widget> pages = [
      // Home Page: show all quotes.
      _buildQuotesList(quotes),
      // Favorites Page: show only favorited quotes.
      quotes.where((q) => q.isFavorite).toList().isNotEmpty
          ? _buildQuotesList(quotes.where((q) => q.isFavorite).toList())
          : const Center(
              child: Text(
                "No favorite quotes yet!",
                style: TextStyle(fontSize: 18),
              ),
            ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(_selectedPage == 0 ? 'Quotes App' : 'Favorite Quotes'),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.pink,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Quotes App',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'App Developed by: Prakash Thapaliya',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.format_quote),
              title: const Text('Home'),
              selected: _selectedPage == 0,
              onTap: () {
                setState(() {
                  _selectedPage = 0;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.favorite),
              title: const Text('Favorites'),
              selected: _selectedPage == 1,
              onTap: () {
                setState(() {
                  _selectedPage = 1;
                });
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: pages[_selectedPage],
    );
  }
}
