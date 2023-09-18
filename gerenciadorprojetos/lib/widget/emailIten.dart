import 'package:flutter/material.dart';

class EmailList extends StatelessWidget {
  EmailList({
    Key? key,
    required this.Email,
    required this.onDelete,
  }) : super(key: key);
  final String Email;
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
                  borderRadius: BorderRadius.circular(4),
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
                        Email,
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.grey[900],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 50,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          onDelete(Email);
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
