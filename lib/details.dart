import 'package:flutter/material.dart';
class ItemDetails extends StatelessWidget {
  final Map item;
  final Function delete;
  const ItemDetails({Key key, this.item,this.delete}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: Text(item["title"]),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.delete),
          onPressed: (){
            delete(item);
          },)
        ],
      ),      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            DecoratedBox(
              child: Container(
                height: 150,
                width: 150,
              ),
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: AssetImage(
                  item["img"],
                ),
              )),
            ),
            Text(
              item["title"],
              style: Theme.of(context).textTheme.display1,
            ),
            SizedBox(
              height: 30.0,
            ),
            Text(item["description"]),
            SizedBox(
              height: 40.0,
            ),
          ],
        ),
      ),
    );
  }
}