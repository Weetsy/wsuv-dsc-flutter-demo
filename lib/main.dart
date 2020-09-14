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
      title: 'Item Library',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MainView(),
    );
  }
}

class MainView extends StatefulWidget {
  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  // Our DataBase instances
  final _animalData = _DataBase(); // Create the animal-specific database
  final _objectData = _DataBase(); // Create the object-specific database

  // Lists containing our current widgets
  final _awidgets = List<Widget>(); // Animal specific widgets
  final _owidgets = List<Widget>(); // Object specific widgets

  @override
  Widget build(BuildContext context) {
    // Populate our animal database with items
    _animalData.recordData("jaguar", "A jaguar.");
    _animalData.recordData("turtle", "A turtle.");
    _animalData.recordData("rabbit", "A rabbit.");
    _animalData.recordData("donkey", "A donkey.");
    // Create our image widgets
    for (int i = 0; i < _animalData.getEntryCount(); i++) {
      _awidgets.add(_createAEntry(_animalData.getNameAt(i)));
    }
    _objectData.recordData("apple", "A fruit.");
    for (int i = 0; i < _objectData.getEntryCount(); i++) {
      print(i);
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          IconButton(
              icon: Icon(Icons.favorite),
              onPressed: () {
                print("Pushed the heart icon!");
              })
        ],
      ),
      body: GridView.count(
        crossAxisCount: 4, // How many elements per row
        children: _awidgets,
      ),
    );
  }

  // Create animal widget
  Widget _createAEntry(String animalName) {
    return Material(
      child: InkWell(
        onTap: () {
          print("Clicking on " + animalName + "!!");
        },
        child: Container(
          child: ClipRRect(
            child: Image.asset('images/' + animalName + '.jpg'),
          ),
        ),
      ),
    );
  }
}
