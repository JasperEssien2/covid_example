import 'package:flutter/material.dart';

class ItemModel {
  final String caption;
  final String value;
  final bool isLoading;
  final Color color;

 const ItemModel(
      {required this.caption,
      required this.value,
      required this.isLoading,
      required this.color});

  ItemModel copyWith({
    String? caption,
    String? value,
    bool? isLoading,
    Color? color,
  }) {
    return ItemModel(
      caption: caption ?? this.caption,
      value: value ?? this.value,
      isLoading: isLoading ?? this.isLoading,
      color: color ?? this.color,
    );
  }
}
