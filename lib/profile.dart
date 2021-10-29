import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_day4/ProductDataModel.dart';
import 'package:flutter/services.dart' as rootBundle;

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);
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
                                flex: 15,
                                child: Container(
                                  child: CircleAvatar(
                                    radius: 45,
                                    backgroundImage: items[index].avatar == null
                                        ? NetworkImage(
                                            items[index].avatar.toString())
                                        : NetworkImage(
                                            "https://pic.onlinewebfonts.com/svg/img_550783.png"),
                                    backgroundColor: Colors.yellow,
                                  ),
                                )),
                            Expanded(
                              flex: 63,
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
                                        items[index].status == null
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
                                alignment: Alignment.centerLeft,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.yellow)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Text(items[index].lastSeenTime.toString(),
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.w600)),
                                    SizedBox(height: 8),
                                    CircleAvatar(
                                      radius: 22,
                                      backgroundImage: NetworkImage(
                                          'https://via.placeholder.com/150'),
                                      backgroundColor: Colors.transparent,
                                    )
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
