import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
//import 'package:im    age_picker/image_picker.dart';
import './Add.dart';
import './details.dart';



class HomePage extends StatefulWidget {

  @override

  _HomePageState createState() => _HomePageState();

}



class _HomePageState extends State<HomePage> {

  List items = [];
  void initState() {
    super.initState();
    getItem();
  }

  getItem() async {
    final sp = await SharedPreferences.getInstance();
    var itemString = sp.getString('item');
    if (itemString == null) {
      // print("title  does not exist");
      // setState(() {
      //   items = [
      //     {"title":"Dark Phoenix", "description":2019, "img":"demo.jpg"},
      //     {"title":"dddd", "description":2039, "img":"demo.jpg"},
      //     {"title":"dd", "description":2049, "img":"demo.jpg"},

      //   ];
      // });
      // await saveItem(items);
    } else {
      setState(() {
        items = json.decode(itemString);
      });
    }
  }

  saveItem(items) async {
    final sp = await SharedPreferences.getInstance();
    await sp.setString('item', json.encode(items));
    print('saved to shared preferences');
    print(items);
  }

  removeItem(item) {
    // final sp = await SharedPreferences.getInstance();
    // SharedPreferences preferences = getSharedPreferences("Mypref", 0);
    // preferences.edit().remove("text").commit();
    // await sp.setString('item', json.encode(items));
    setState(() {
      items.remove(item);
    });
    saveItem(items);
    print('deleted from shared preferences');
    //  print(items);
  }

  add(item) async {
    setState(() {
      items.add(item);
    });
    await saveItem(items);
  }




  @override

  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        title: Text("Home"),

        backgroundColor: Colors.brown,

      ),

      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          var litem = items[index];
          return ListTile(
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (_) => ItemDetails(item: litem,delete: _delete))),
            leading: CircleAvatar(
              backgroundImage: FileImage(File(litem["img"])),
            ),
              title: Text(litem["title"]),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => _delete(litem),
            ),

            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('${litem["description"]}'),
                //  new FlatButton(onPressed: () {
                //    remove(items);
                //    saveItem(items);
                //  },
                //           child: new Text("DELETE",
                //             style: new TextStyle(color: Colors.redAccent),)),

                SizedBox(
                  height: 5,
                ),
            

              ],

            ),

          );

        },

      ),

       floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (_) => AddPage(addItem))),
        tooltip: 'add item',
        child: Icon(Icons.add),
      ),
    );

    // List <Map> items;
  }
  //(item.add(_)=>items.resource(_))
  void _delete(Map item) {
    // setState(() {
    //  items.remove(
    //    item
    //  ) ;

    // });
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Delete item"),
            content: Text("Are you sure ?"),
            actions: <Widget>[
              FlatButton(
                child: Text("cancel"),
                onPressed: () => Navigator.pop(context),
              ),
              FlatButton(
                  child: Text("Delete"),
                  onPressed: () {
                    removeItem(item);
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomePage()));
                    //Navigator.pop(context);
                  }),
            ],
          );
        });
  }

  addItem(String title, String description, File _image) {
    setState(() {
      items.add({
        "title": title,
        "description": description,
        "img": _image.path,
      });
    });
    saveItem(items);
  }

}