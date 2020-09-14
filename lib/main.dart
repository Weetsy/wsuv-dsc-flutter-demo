import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class _DataBase {
  var data; // This will contain our 2D array of data
  var head; // This will keep track of how many items are in the structure
  var favorites; // Holds favorites in a set
  _DataBase() {
    // Initialize our instance variables
    favorites = Set<String>();
    data = List<List<String>>();
    head = 0;
  }

  // Creates the data
  void recordData(String item, String description) {
    data.add(List<String>());
    data[head].add(item);
    data[head].add(description);
    head++;
  }

  // searches the structure for the string and returns the description
  String getDescription(String item) {
    for (int i = 0; i < head; i++) {
      if (data[i][0] == item) {
        return data[i][1];
      }
    }
    print("Could not find an entry for '" + item + "' in the database.");
    return null;
  }

  // Returns the name of entry at index i
  String getNameAt(int i) {
    return data[i][0];
  }

  void setFavorite(String item) {
    for (int i = 0; i < head; i++) {
      if (data[i][0] == item) {
        // If the item is already a favorite
        if (favorites.contains(data[i][0])) {
          favorites.remove(item);
        } else {
          favorites.add(item);
        }
      }
    }
  }

  // Check if the item is a favorite
  bool isFavorite(String item) {
    for (int i = 0; i < head; i++) {
      if (favorites.contains(item)) {
        return true;
      }
    }
    return false;
  }

  // Returns the number of entries in the data structure
  int getEntryCount() {
    return data.length;
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
