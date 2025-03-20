import 'package:flutter/material.dart';

final InputDecoration inputFormTitle = InputDecoration(
  contentPadding: const EdgeInsets.all(10),
  label: const Text('Title'),
  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
);

final InputDecoration inputFormAmount = InputDecoration(
  icon: Icon(Icons.monetization_on),
  label: const Text('Custo'),
  contentPadding: const EdgeInsets.all(10),

  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
);
