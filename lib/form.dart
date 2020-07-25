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
        child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Title',
          style: TextStyle(fontSize: 19),
          textAlign: TextAlign.left,
        ),
        TextField(
          decoration: InputDecoration(
              border: OutlineInputBorder(), hintText: 'Enter the title here'),
        ),
        Text(
          'Description',
          style: TextStyle(fontSize: 19),
          textAlign: TextAlign.left,
        ),
        TextField(
          minLines: 5,
          maxLines: 10,
          decoration: InputDecoration(
              border: OutlineInputBorder(), hintText: 'Share your hack...'),
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
    ));
  }
}
