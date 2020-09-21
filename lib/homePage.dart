import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:filterListApplicationDemo/components.dart';
import 'package:google_fonts/google_fonts.dart';
import 'components.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HomePageWidget(title: 'Filtering List Application Demo');
  }
}

class HomePageWidget extends StatefulWidget {
  HomePageWidget({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePageWidget> {
  List<Components> initialList = Components.components;
  List<Components> currentList = [];

  @override
  void initState() {
    super.initState();
    controller.addListener(onChange1);
    filterList();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    controller.dispose();
    super.dispose();
  }

  AutoSizeText text(String a, bool isbold) {
    if (isbold) {
      return AutoSizeText(
        a,
        minFontSize: 10,
        maxLines: 1,
        overflow: TextOverflow.fade,
        style: GoogleFonts.sourceSansPro(
          fontSize: 20,
          color: Colors.black87,
          fontWeight: FontWeight.bold,
        ),
      );
    } else {
      return AutoSizeText(
        a,
        minFontSize: 10,
        maxLines: 2,
        overflow: TextOverflow.fade,
        style: GoogleFonts.sourceSansPro(
          fontSize: 16,
          color: Colors.black87,
          fontWeight: FontWeight.normal,
        ),
      );
    }
  }

  bool inStock = false;
  String name;
  double maxPrice = 3000;
  String categoryTemp = "All";

  final controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    filterList();
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 174, 212, 213),
        appBar: AppBar(
          centerTitle: true,
          elevation: 10,
          backgroundColor: Color.fromRGBO(173, 193, 200, 0.75),
          title: text(widget.title, true),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(
                    filled: true,
                    contentPadding: EdgeInsets.all(20),
                    suffixIcon: Icon(
                      Icons.search_rounded,
                      size: 32,
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(18))),
                    hintText: 'Enter a search term',
                  ),
                  controller: controller,
                ),
                SwitchListTile(
                  title: text("Only Show In Stock Items", false),
                  value: inStock,
                  onChanged: (val) {
                    setState(() => inStock = val);
                  },
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Slider(
                        label: "${maxPrice.round()} \u{20B9}",
                        activeColor: Colors.indigoAccent,
                        min: 0.0,
                        max: 3000,
                        divisions: 20,
                        value: maxPrice,
                        onChanged: (newPrice) {
                          setState(() => maxPrice = newPrice);
                        },
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: AutoSizeText(
                        "Max: " + maxPrice.toString() + " \u{20B9}",
                        minFontSize: 10,
                        maxLines: 1,
                        overflow: TextOverflow.fade,
                        style: GoogleFonts.sourceSansPro(
                          fontSize: 22,
                          color: Color.fromRGBO(59, 88, 151, 0.7),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                ListTile(
                  title: text("Category", true),
                  trailing: DropdownButton(
                    elevation: 5,
                    dropdownColor: Color.fromARGB(255, 255, 227, 194),
                    isDense: true,
                    onChanged: (item) {
                      setState(() {
                        categoryTemp = item;
                        print(categoryTemp);
                      });
                    },
                    hint: text(categoryTemp, false),
                    items: [
                      DropdownMenuItem<String>(
                        child: text(
                          "All",
                          false,
                        ),
                        value: "All",
                      ),
                      DropdownMenuItem<String>(
                        child: text(
                          "Battery",
                          false,
                        ),
                        value: "Battery",
                      ),
                      DropdownMenuItem<String>(
                        child: text(
                          "Board",
                          false,
                        ),
                        value: "Board",
                      ),
                      DropdownMenuItem<String>(
                        child: text(
                          "Sensors",
                          false,
                        ),
                        value: "Sensors",
                      ),
                      DropdownMenuItem<String>(
                        child: text(
                          "Tools",
                          false,
                        ),
                        value: "Tools",
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: currentList.length,
                      itemBuilder: (BuildContext context, int index) {
                        Components current = currentList.elementAt(index);
                        return Card(
                          elevation: 6,
                          child: ListTile(
                            title: text(current.name, false),
                            tileColor: Color.fromRGBO(208, 245, 245, 0.5),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        );
                      }),
                ),
              ],
            ),
          ),
        ));
  }

  onChange1() {
    print("HI");
    setState(() {});
  }

  filterList() {
    List<Components> tmp = [];
    currentList.clear();

    String name = controller.text;
    print("Filter Component Based on Text" + name);

    if (name.isEmpty) {
      tmp.addAll(initialList);
    } else {
      for (Components t in initialList) {
        if (t.name.toLowerCase().startsWith(name.toLowerCase())) {
          tmp.add(t);
        }
      }
    }
    currentList = tmp;

    if (inStock) {
      tmp = [];
      print("Filtering Based in Stock");
      for (Components c in currentList) {
        if (c.inStock == inStock) {
          tmp.add(c);
        }
      }
      currentList = tmp;
    }

    print("Filtering Based on max Price");
    tmp = [];
    for (Components c in currentList) {
      if (c.price < maxPrice) {
        tmp.add(c);
      }
    }

    currentList = tmp;
    if (categoryTemp.toLowerCase() != "all") {
      print("Filtering Based on Category");
      tmp = [];
      for (Components c in currentList) {
        print(c.category + "    " + categoryTemp);
        if (c.category.toLowerCase().startsWith(categoryTemp.toLowerCase())) {
          tmp.add(c);
        }
      }
      currentList = tmp;
    }
  }
}
