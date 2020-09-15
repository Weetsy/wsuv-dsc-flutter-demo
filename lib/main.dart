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
    // Populate our object database with items
    _objectData.recordData("apple", "A fruit.");
    for (int i = 0; i < _objectData.getEntryCount(); i++) {
      _owidgets.add(_createOEntry(_objectData.getNameAt(i)));
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          IconButton(
              icon: Icon(Icons.favorite),
              onPressed: () {
                _checkFavorites();
              })
        ],
      ),
      body: Center(
        child: Text("This is the homescreen!"),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              child: Text("Categories", style: TextStyle(fontSize: 40.0)),
              decoration: BoxDecoration(
                color: Colors.purple,
              ),
            ),
            ListTile(
              trailing: Icon(Icons.wc),
              title: Text(
                "Animals",
                style: TextStyle(fontSize: 25.0),
              ),
              onTap: () {
                // on click the animal gallery will get pushed onto the view stack
                Navigator.of(context)
                    .push(MaterialPageRoute<void>(builder: (BuildContext) {
                  return Scaffold(
                    appBar: AppBar(title: Text('Animals')),
                    body: GridView.count(
                      crossAxisCount: 4,
                      children: _awidgets,
                    ),
                  );
                }));
              },
            ),
            ListTile(
              trailing: Icon(Icons.laptop),
              title: Text(
                "Objects",
                style: TextStyle(fontSize: 25.0),
              ),
              onTap: () {
                // on click the object gallery will get pushed onto the view stack
                Navigator.of(context)
                    .push(MaterialPageRoute<void>(builder: (BuildContext) {
                  return Scaffold(
                    appBar: AppBar(title: Text('Objects')),
                    body: GridView.count(
                      crossAxisCount: 4,
                      children: _owidgets,
                    ),
                  );
                }));
              },
            ),
            ListTile(
              trailing: Icon(Icons.approval),
              title: Text(
                "Credits",
                style: TextStyle(fontSize: 25.0),
              ),
              onTap: () {
                // on click the object gallery will get pushed onto the view stack
                Navigator.of(context)
                    .push(MaterialPageRoute<void>(builder: (BuildContext) {
                  return Scaffold(
                    appBar: AppBar(title: Text('Credits')),
                    body: GridView.count(
                      crossAxisCount: 4,
                      children: [
                        Container(
                          child: Center(
                            child: Text(
                              "Apple photo by Shelley Pauls @shelleypauls on unsplash.com",
                              style: TextStyle(fontSize: 25.0),
                            ),
                          ),
                        ),
                        Image.asset("assets/images/apple.jpg"),
                        Container(
                          child: Center(
                            child: Text(
                              "Donkey photo by TS Sergey @ttsergey on unsplash.com",
                              style: TextStyle(fontSize: 25.0),
                            ),
                          ),
                        ),
                        Image.asset("assets/images/donkey.jpg"),
                        Container(
                          child: Center(
                            child: Text(
                              "Rabbit photo by Satyabrata sm @smpicturez on unsplash.com",
                              style: TextStyle(fontSize: 25.0),
                            ),
                          ),
                        ),
                        Image.asset("assets/images/rabbit.jpg"),
                        Container(
                          child: Center(
                            child: Text(
                              "Turtle photo by Wexor Tmg @wexor on unsplash.com",
                              style: TextStyle(fontSize: 25.0),
                            ),
                          ),
                        ),
                        Image.asset("assets/images/turtle.jpg"),
                        Container(
                          child: Center(
                            child: Text(
                              "Jaguar photo by Uriel Soberanes @soberanes on unsplash.com",
                              style: TextStyle(fontSize: 25.0),
                            ),
                          ),
                        ),
                        Image.asset("assets/images/jaguar.jpg"),
                      ],
                    ),
                  );
                }));
              },
            ),
          ],
        ),
      ),
    );
  }

  // Create animal widget
  Widget _createAEntry(String animalName) {
    return Material(
      child: InkWell(
        onTap: () {
          _getADescription(animalName);
        },
        child: Container(
          child: ClipRRect(
            child: Image.asset('images/' + animalName + '.jpg'),
          ),
        ),
      ),
    );
  }

  // Push new view for animal description page
  void _getADescription(String animal) {
    Navigator.of(context)
        .push(MaterialPageRoute<void>(builder: (BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Animal details'),
        ),
        body: Center(
            child: Column(
          children: [
            Text("\n\n" +
                animal.toUpperCase() +
                "\n\n" +
                _animalData.getDescription(animal) +
                "\n\n"),
            Padding(padding: EdgeInsets.all(10)),
            FavoriteButton(
              data: _animalData,
              objName: animal,
            )
          ],
        )),
      );
    }));
  }

  // Create animal widget
  Widget _createOEntry(String object) {
    return Material(
      child: InkWell(
        onTap: () {
          _getODescription(object);
        },
        child: Container(
          child: ClipRRect(
            child: Image.asset('images/' + object + '.jpg'),
          ),
        ),
      ),
    );
  }

  // Push new view for animal description page
  void _getODescription(String object) {
    Navigator.of(context)
        .push(MaterialPageRoute<void>(builder: (BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Object details'),
        ),
        body: Center(
            child: Column(
          children: [
            Text("\n\n" +
                object.toUpperCase() +
                "\n\n" +
                _objectData.getDescription(object) +
                "\n\n"),
            Padding(padding: EdgeInsets.all(10)),
            FavoriteButton(
              data: _objectData,
              objName: object,
            )
          ],
        )),
      );
    }));
  }

  // Load in a new page to view favorites
  void _checkFavorites() {
    final tempWidgets = List<Widget>();
    // Check for favorite animals
    for (int i = 0; i < _animalData.getEntryCount(); i++) {
      // To add descriptions,
      if (_animalData.isFavorite(_animalData.getNameAt(i))) {
        print(_animalData.getNameAt(i) + " is a favorite");
        tempWidgets.add(_awidgets[i]); // Add favorite into our temp array
      }
    }
    // Check for favorite objects
    for (int i = 0; i < _objectData.getEntryCount(); i++) {
      // To add descriptions,
      if (_objectData.isFavorite(_objectData.getNameAt(i))) {
        print(_objectData.getNameAt(i) + " is a favorite");
        tempWidgets.add(_owidgets[i]);
      }
    }
    Navigator.of(context)
        .push(MaterialPageRoute<void>(builder: (BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Favorites'),
        ),
        body: GridView.count(
          crossAxisCount: 4,
          // Send our tempWidgets array to new page
          children: tempWidgets,
        ),
      );
    }));
  }
}

class FavoriteButton extends StatefulWidget {
  final String objName;
  final _DataBase data;

  const FavoriteButton({Key key, this.objName, this.data}) : super(key: key);

  @override
  _FavoriteButtonState createState() => _FavoriteButtonState(objName, data);
}

class _FavoriteButtonState extends State<FavoriteButton> {
  final String objName;
  final _DataBase data;

  _FavoriteButtonState(this.objName, this.data);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
        child: Text(data.isFavorite(objName) ? "Favorited" : "Not Favorited"),
        onPressed: () {
          setState(() {
            data.setFavorite(objName);
          });
        });
  }
}
