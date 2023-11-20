// ignore_for_file: file_names

import 'package:flutter/material.dart';

class EmailList extends StatelessWidget {
  const EmailList({
    Key? key,
    required this.email,
    required this.onDelete,
  }) : super(key: key);
  final String email;
  final Function(String) onDelete;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.grey[200],
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 8,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        email,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[900],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 50,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        onPressed: () {
                          onDelete(email);
                        },
                        child: Icon(
                          Icons.person_remove_outlined,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
