import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class SettingBuilder extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Language',
            ),
            Row(
              children: <Widget>[
                SizedBox(width: 40.0),
                RaisedButton(
                  child: Text("Eng"),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return Dialog(
                          child: Container(
                            height: 60.0,
                            width: 200.0,
                            child: ListView(
                              children: <Widget>[
                                SizedBox(height: 20),
                                Center(
                                  child: Text(
                                    "Changed language to English.",
                                  ),
                                ),
                                SizedBox(height: 20),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
                SizedBox(width: 20.0),
                RaisedButton(
                  child: Text("中"),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return Dialog(
                          child: Container(
                            height: 60.0,
                            width: 200.0,
                            child: ListView(
                              children: <Widget>[
                                SizedBox(height: 20),
                                Center(
                                  child: Text(
                                    "已更變語言為 中文",
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
                SizedBox(height: 20,),

              ],
            ),
            SizedBox(height: 20.0),
            RaisedButton(
              child: Text("About Team Orange"),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return Dialog(
                      child: Container(
                        height: 200.0,
                        width: 200.0,
                        child: ListView(
                          children: <Widget>[
                            SizedBox(height: 40),
                            Center(
                              child: Text(
                                "About Team Orange",
                              ),
                            ),
                            SizedBox(height: 20),
                            Center(
                              child: Text(
                                "Application Created by:",
                              ),
                            ),
                            Center(
                              child: Text(
                                "KWOK CHUN KAN",
                              ),
                            ),
                            Center(
                              child: Text(
                                "HO HON LUNG",
                              ),
                            ),
                            Center(
                              child: Text(
                                "CHAN CHUN FUNG",
                              ),
                            ),
                            Center(
                              child: Text(
                                "KWAN YIN SAN",
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
            RaisedButton(
              child: Text("Agreement"),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return Dialog(
                      child: Container(
                        height: 170.0,
                        width: 200.0,
                        child: ListView(
                          children: <Widget>[
                            SizedBox(height: 20),
                            Center(
                              child: Text(
                                "Agreement",
                              ),
                            ),
                            SizedBox(height: 20),
                            Center(
                              child: Text(
                                "If you downloaded the application, you are accepting our Terms of Services. If you violate the rules of the application, "
                                    "your account or usership will be terminated. Please be wise.", textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
            Divider(
              color: Colors.grey[600],
              height: 60.0,
            ),
          ],

        ),

      ),

    );

  }
}