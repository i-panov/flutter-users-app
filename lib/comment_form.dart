import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:my_app/api.dart';

class CommentForm extends StatefulWidget {
  final int postId;

  CommentForm({Key? key, required this.postId}) : super(key: key);

  @override
  createState() => _CommentFormState();
}

class _CommentFormState extends State<CommentForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  final _bodyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: _emailController,
            cursorColor: Colors.black,
            keyboardType: TextInputType.emailAddress,
            decoration: new InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                contentPadding:
                EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                hintText: "Email"
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Enter your email';
              }

              if (!EmailValidator.validate(value)) {
                return 'Invalid email address';
              }

              return null;
            },
          ),
          TextFormField(
            controller: _nameController,
            cursorColor: Colors.black,
            keyboardType: TextInputType.text,
            decoration: new InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                contentPadding:
                EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                hintText: "Name"
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Enter comment name';
              }

              return null;
            },
          ),
          TextFormField(
            controller: _bodyController,
            cursorColor: Colors.black,
            keyboardType: TextInputType.text,
            decoration: new InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                contentPadding:
                EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                hintText: "Body"
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Enter comment body';
              }

              return null;
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () async {
                // Validate returns true if the form is valid, or false otherwise.
                if (_formKey.currentState!.validate()) {
                  final comment = await addComment(
                      widget.postId,
                      _emailController.text,
                      _nameController.text,
                      _bodyController.text,
                  );

                  Navigator.pop(context, comment);
                }
              },
              child: Text('Submit'),
            ),
          )
        ],
      ),
    );
  }
}
