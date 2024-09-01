import 'package:admin_dashboard_store_app/Core/utils/text_styles/text_styles.dart';
import 'package:admin_dashboard_store_app/Features/brand/manager/cubit/brand_cubit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BrandItem extends StatelessWidget {
  const BrandItem(
      {super.key,
      required this.index,
      required this.edit,
      required this.delete});
  final int index;
  final VoidCallback edit;
  final VoidCallback delete;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey.shade900, borderRadius: BorderRadius.circular(8)),
      padding: const EdgeInsets.all(8),
      child: Stack(
        children: [
          Positioned(
              top: 0,
              right: 0,
              child: PopupMenuButton(
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6)),
                color: Colors.grey.shade800,
                itemBuilder: (context) => [
                  PopupMenuItem(
                    child: ListTile(
                      title: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text('Edit'),
                          Icon(
                            Icons.edit,
                            color: Colors.white,
                            size: 16,
                          ),
                        ],
                      ),
                      onTap: edit,
                    ),
                  ),
                  PopupMenuItem(
                    child: ListTile(
                      title: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            'Delete',
                            style: TextStyle(color: Colors.red),
                          ),
                          Icon(
                            Icons.delete,
                            color: Colors.red,
                            size: 16,
                          ),
                        ],
                      ),
                      onTap: delete,
                    ),
                  ),
                ],
                child: const Icon(Icons.more_vert),
              )),
          Positioned(
              child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.35,
            child: Text(
              context.read<BrandCubit>().brandsList[index].name!,
              style: MyTextStyles.subtitle,
              overflow: TextOverflow.ellipsis,
            ),
          )),
          Positioned(
            top: 35,
            bottom: 35,
            left: 15,
            right: 15,
            child: AspectRatio(
              aspectRatio: 1.3,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: CachedNetworkImage(
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) =>
                      Image.asset('assets/images/placeholder.png'),
                  errorListener: (value) {
                    debugPrint("Error: $value");
                  },
                  imageUrl: context.read<BrandCubit>().brandsList[index].logo!,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: Text(
                "Quantity : ${context.read<BrandCubit>().brandsList[index].count!.products.toString()}"),
          ),
        ],
      ),
    );
  }
}
