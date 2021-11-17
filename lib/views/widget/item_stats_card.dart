import 'package:covid_example/views/utils/item_model.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ItemStatsCard extends StatelessWidget {
  final ItemModel itemModel;
  const ItemStatsCard({
    Key? key,
    required this.itemModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: itemModel.color, borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      child: itemModel.isLoading
          ? Shimmer.fromColors(
              baseColor: itemModel.color,
              highlightColor: Colors.white,
              child: _buildItemLoading())
          : _buildItem(),
    );
  }

  Column _buildItem() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        Text(
          itemModel.caption,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 24),
        Text(
          itemModel.value,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w800,
            fontSize: 18,
          ),
        ),
      ],
    );
  }

  Column _buildItemLoading() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          height: 12,
          width: 90,
          decoration: _decoration(),
        ),
        const SizedBox(height: 24),
        Container(
          height: 18,
          width: 130,
          decoration: _decoration(),
        ),
      ],
    );
  }

  BoxDecoration _decoration() {
    return BoxDecoration(
        color: Colors.white, borderRadius: BorderRadius.circular(10));
  }
}
