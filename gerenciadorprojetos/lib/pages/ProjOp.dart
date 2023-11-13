import 'package:flutter/material.dart';

import '../models/projeto.dart';

class ProjOp extends StatefulWidget {
  const ProjOp({required this.parametros});

  final Projeto parametros;

  @override
  State<ProjOp> createState() => _ProjOpState();
}

class _ProjOpState extends State<ProjOp> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
