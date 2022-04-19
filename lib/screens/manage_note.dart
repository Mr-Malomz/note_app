import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:note_app/screens/home.dart';
import 'package:note_app/utils/color.dart';
import 'package:note_app/utils/note_service.dart';

class ManageNote extends StatefulWidget {
  const ManageNote({
    Key? key,
    required this.title,
    required this.isEdit,
    this.isView = false,
  }) : super(key: key);
  final String title;
  final bool isEdit;
  final bool isView;

  @override
  State<ManageNote> createState() => _ManageNoteState();
}

class _ManageNoteState extends State<ManageNote> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _title = new TextEditingController();
  TextEditingController _note = new TextEditingController();
  bool _isLoading = false;
  bool _isError = false;

  @override
  void initState() {
    if (widget.isEdit) {
      //todo
    }
    super.initState();
  }

  _createNote() {
    _isLoading = true;
    NoteService().createNote(_title.text, _note.text).then((value) {
      setState(() {
        _isLoading = false;
      });
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Home()),
      );
    }).catchError((_) {
      setState(() {
        _isLoading = false;
        _isError = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: AppColor.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 30.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //title
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Title',
                        style: TextStyle(
                          color: AppColor.grey,
                          fontSize: 14.0,
                        ),
                      ),
                      const SizedBox(height: 5.0),
                      TextFormField(
                        controller: _title,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please input title';
                          }
                          return null;
                        },
                        readOnly: widget.isView,
                        inputFormatters: [LengthLimitingTextInputFormatter(25)],
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          hintText: "enter title",
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: AppColor.grey),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: AppColor.grey),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.red),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 30.0),

                  //Note
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Note',
                        style: TextStyle(
                          color: AppColor.grey,
                          fontSize: 14.0,
                        ),
                      ),
                      const SizedBox(height: 5.0),
                      TextFormField(
                        controller: _note,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please input note';
                          }
                          return null;
                        },
                        readOnly: widget.isView,
                        inputFormatters: [LengthLimitingTextInputFormatter(70)],
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          hintText: "enter note",
                          fillColor: Colors.white,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: AppColor.grey),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: AppColor.grey),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.red),
                          ),
                        ),
                        minLines: 6,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 30.0),
              SizedBox(
                height: 45,
                width: double.infinity,
                child: widget.isView
                    ? const SizedBox()
                    : TextButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _createNote();
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Note Created successfully!')),
                            );
                          }
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              AppColor.primary),
                        ),
                        child: const Text(
                          'Save',
                          style: TextStyle(
                            color: AppColor.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14.0,
                          ),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
