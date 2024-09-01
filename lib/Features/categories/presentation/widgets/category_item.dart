import 'package:admin_dashboard_store_app/Core/utils/text_styles/text_styles.dart';
import 'package:admin_dashboard_store_app/Features/categories/manager/categories/categories_cubit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({
    super.key,
    required this.index,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.width * 0.21,
            child: AspectRatio(
              aspectRatio: 1,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: CachedNetworkImage(
                  errorWidget: (context, url, error) =>
                      Image.asset('assets/images/placeholder.png'),
                  imageUrl: context
                      .read<CategoriesCubit>()
                      .categoriesList[index]
                      .icon!,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Column(
            children: [
              FittedBox(
                child: Text(
                  context.read<CategoriesCubit>().categoriesList[index].name!,
                  style: MyTextStyles.subtitle,
                ),
              ),
              FittedBox(
                child: Text(
                  'Quantity: ${context.read<CategoriesCubit>().categoriesList[index].count!.products!}',
                  style: MyTextStyles.bodySmall,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
