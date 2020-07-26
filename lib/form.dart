import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:location/location.dart';

class ShareForm extends StatefulWidget {
  @override
  _ShareFormState createState() => _ShareFormState();
}

// Define a corresponding State class.
// This class holds the data related to the Form.
class _ShareFormState extends State<ShareForm> {
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final titleController = TextEditingController();
  final postController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        autovalidate: true,
        child: Center(
            child: Padding(
                padding: EdgeInsets.all(18.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    TextFormField(
                      controller: titleController,
                      decoration: InputDecoration(
                          icon: Icon(Icons.title),
                          hintText: 'Enter the title here',
                          labelText: 'Title'),
                      validator: (value) {
                        return value.isEmpty ? 'Please enter a title' : null;
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          icon: Icon(Icons.link),
                          hintText: 'Share a link (optional)',
                          labelText: 'Link'),
                      validator: null,
                    ),
                    TextFormField(
                      minLines: 1,
                      maxLines: 10,
                      controller: postController,
                      decoration: InputDecoration(
                          icon: Icon(
                            Icons.cloud,
                          ),
                          hintText: 'Share your hack...',
                          labelText: 'Share your hack'),
                      validator: (value) {
                        return value.isEmpty ? 'Enter your hack!' : null;
                      },
                    ),
                    FlatButton(
                      color: Colors.lightGreen,
                      textColor: Colors.white,
                      disabledColor: Colors.grey,
                      disabledTextColor: Colors.black,
                      padding: EdgeInsets.all(8.0),
                      splashColor: Colors.lightGreenAccent,
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          Scaffold.of(context).showSnackBar(
                              SnackBar(content: Text('Processing Data')));
                          print("hiya");
                          Location location = new Location();
                          LocationData loc = await location.getLocation();

                          await Firestore.instance.collection('hacks').add({
                            "title": titleController.text,
                            "post": postController.text,
                            "Lat": loc.latitude,
                            "Lon": loc.longitude
                          });

                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return CupertinoAlertDialog(
                                  title: Text('Success!'),
                                  content:
                                      Text('Your hack has been submitted!'),
                                  actions: [
                                    CupertinoDialogAction(
                                        child: Text("Okay"),
                                        onPressed: () {
                                          Navigator.of(context).popUntil(
                                              (route) => route.isFirst);
                                        }),
                                  ],
                                );
                              });
                        }
                      },
                      child: Text(
                        "Submit",
                        style: TextStyle(fontSize: 20.0),
                      ),
                    )
                  ],
                ))));
  }
}
