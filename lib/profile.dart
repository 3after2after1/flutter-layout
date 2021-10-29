import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_day4/ProductDataModel.dart';
import 'package:flutter/services.dart' as rootBundle;
import 'dart:math';

class Profile extends StatelessWidget {
  Profile({Key? key}) : super(key: key);
  static final List<Color> list = [
    Colors.green.shade200,
    Colors.yellow.shade200,
    Colors.red.shade200,
    Colors.orange.shade200,
    Colors.grey.shade200,
    Colors.purple.shade200,
    Colors.pink.shade200,
    Colors.blue.shade200,
    Colors.brown.shade200,
  ];
  final Random random = new Random();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: readJsonData(),
        builder: (context, data) {
          if (data.hasError) {
            return Center(child: Text("${data.error}"));
          } else if (data.hasData) {
            var items = data.data as List<ProductDataModel>;
            return ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.all(2),
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.blueAccent)),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              flex: 18,
                              child: Container(
                                child: CircleAvatar(
                                  backgroundColor: Colors.black,
                                  radius: 65.0,
                                  child: CircleAvatar(
                                    radius: 30,
                                    backgroundImage: items[index].avatar != null
                                        ? NetworkImage(
                                            items[index].avatar.toString())
                                        : NetworkImage(
                                            "https://pic.onlinewebfonts.com/svg/img_550783.png"),
                                    // backgroundColor: Colors.yellow,
                                    backgroundColor: list[random.nextInt(8)],
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 60,
                              child: Container(
                                height: 100,
                                padding: EdgeInsets.only(left: 5),
                                margin: EdgeInsets.only(left: 10),
                                alignment: Alignment.centerLeft,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.yellow)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Text(
                                      items[index].firstName.toString() +
                                          " " +
                                          items[index].lastName.toString(),
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      items[index].username.toString(),
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    // Text(items[index].status.toString(),
                                    //     style: TextStyle(color: Colors.grey)),
                                    Text(
                                        items[index].status != null
                                            ? items[index].status.toString()
                                            : "No status",
                                        style: TextStyle(color: Colors.grey)),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 22,
                              child: Container(
                                height: 100,
                                padding: EdgeInsets.only(left: 5),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.yellow)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Text(
                                      items[index].lastSeenTime.toString(),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(height: 8),
                                    CircleAvatar(
                                      backgroundColor:
                                          items[index].messages != null
                                              ? Colors.black
                                              : Colors.grey.shade50,
                                      radius: 25,
                                      child: CircleAvatar(
                                        radius: 22,
                                        child: items[index].messages == null
                                            ? null
                                            : Text(
                                                items[index].messages.toString(),
                                                style: TextStyle(
                                                    color: Colors.black),
                                              ),
                                        backgroundColor:
                                            items[index].messages == null
                                                ? Colors.grey.shade50
                                                : list[random.nextInt(8)],

                                        // backgroundImage: NetworkImage(
                                        //     'https://via.placeholder.com/150'),

                                        // child: Text(items[index].id.toString()),
                                        // backgroundColor: list[random.nextInt(8)],
                                        // child: null,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                });
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }

  Future<List<ProductDataModel>> readJsonData() async {
    final jsondata =
        await rootBundle.rootBundle.loadString("jsonfile/sample.json");
    final list = json.decode(jsondata) as List<dynamic>;
    return list.map((e) => ProductDataModel.fromJSON(e)).toList();
  }
}
