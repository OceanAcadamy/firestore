import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ReadProduct extends StatefulWidget {
  @override
  _ReadProductState createState() => _ReadProductState();
}

final _fireStore = Firestore.instance;
getProduct() async {
  final products = await _fireStore.collection("product").getDocuments();
  for (var product in products.documents) {
    print(product.data);
  }
}

productStreams() async {
  await for (var snapshot in _fireStore.collection("product").snapshots()) {
    for (var product in snapshot.documents) {
      print(product.data);
    }
  }
}

class _ReadProductState extends State<ReadProduct> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    productStreams();
  }

  deleteProduct(id) async {
    await _fireStore.collection("product").document(id).delete();
    print(id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Retrieve"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StreamBuilder<QuerySnapshot>(
              stream: _fireStore.collection("product").snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final products = snapshot.data.documents;
                  List<Card> productWidget = [];
                  for (var product in products) {
                    final id = product.data["id"];
                    final name = product.data['name'];
                    final price = product.data['price'];

                    productWidget.add(
                      Card(
                        child: ListTile(
                            leading: Column(
                              children: [
                                Text(id),
                                Text(name),
                                Text(price),
                              ],
                            ),
                            trailing: Column(
                              children: [
                                RaisedButton(
                                    color: Colors.lightBlueAccent,
                                    child: Text("Delete"),
                                    onPressed: () {
                                      deleteProduct(id);
                                    })
                              ],
                            )),
                      ),
                    );
                  }
                  return SingleChildScrollView(
                    child: Column(
                      children: productWidget,
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
