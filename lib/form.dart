import 'package:flutter/material.dart';

class ShareForm extends StatefulWidget {
  @override
  _ShareFormState createState() => _ShareFormState();
}

// Define a corresponding State class.
// This class holds the data related to the Form.
class _ShareFormState extends State<ShareForm> {
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final myController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        autovalidate: true,
        child: Center(
            child: Padding(
                padding: EdgeInsets.all(18.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    TextFormField(
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
                      decoration: InputDecoration(
                          icon: Icon(
                            Icons.cloud,
                          ),
                          hintText: 'Share your hack...',
                          labelText: 'Share your hack'),
                      validator: null,
                    ),
                    FlatButton(
                      color: Colors.lightGreen,
                      textColor: Colors.white,
                      disabledColor: Colors.grey,
                      disabledTextColor: Colors.black,
                      padding: EdgeInsets.all(8.0),
                      splashColor: Colors.lightGreenAccent,
                      onPressed: () {
                        /*...*/
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
