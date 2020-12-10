import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore/read_product.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  save() {}
  final _idController = TextEditingController();
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  String id, name, price;
  final _fireStore = Firestore.instance;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Db Connectivity using firebase"),
      ),
      key: _scaffoldKey,
      body: Center(
        child: Container(
          padding: EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _idController,
                decoration: InputDecoration(hintText: 'ID'),
                onChanged: (value) {
                  setState(() {
                    id = value;
                  });
                },
              ),
              SizedBox(height: 15.0),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(hintText: 'Name'),
                onChanged: (value) {
                  setState(() {
                    name = value;
                  });
                },
              ),
              SizedBox(height: 15.0),
              TextField(
                controller: _priceController,
                decoration: InputDecoration(hintText: 'Price'),
                onChanged: (value) {
                  setState(() {
                    price = value;
                  });
                },
              ),
              SizedBox(height: 15.0),
              RaisedButton(
                child: Text('Save'),
                color: Colors.blue,
                textColor: Colors.white,
                elevation: 7.0,
                onPressed: () {
                  _nameController.clear();
                  _idController.clear();
                  _priceController.clear();
                  _fireStore
                      .collection("product")
                      .document(id)
                      .setData({"id": id, "name": name, "price": price});
                  final snackBar = SnackBar(
                    content: Text('Saved successfully!'),
                  );
                  _scaffoldKey.currentState.showSnackBar(snackBar);
                },
              ),
              RaisedButton(
                child: Text('Retrieve'),
                color: Colors.blue,
                textColor: Colors.white,
                elevation: 7.0,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ReadProduct()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
    ;
  }
}
