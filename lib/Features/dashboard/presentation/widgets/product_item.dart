import 'package:admin_dashboard_store_app/Core/utils/text_styles/text_styles.dart';
import 'package:admin_dashboard_store_app/Features/dashboard/data/models/product_model.dart';
import 'package:admin_dashboard_store_app/Features/dashboard/manager/cubit/dashboard_cubit.dart';
import 'package:admin_dashboard_store_app/configs/router/routes.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class ProductItem extends StatefulWidget {
  const ProductItem({super.key, required this.productModel});
  final ProductModel productModel;

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<DashboardCubit>(context);
    return Slidable(
      key: Key(widget.productModel.id.toString()),
      endActionPane: ActionPane(motion: const StretchMotion(), children: [
        SlidableAction(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
          onPressed: (context) {
            GoRouter.of(context)
                .push(AppRoutes.kEditProductView, extra: widget.productModel);
          },
          backgroundColor: Colors.blueGrey,
          foregroundColor: Colors.white,
          icon: Icons.edit,
          label: 'Edit',
        ),
        SlidableAction(
          borderRadius: const BorderRadius.only(
              topRight: Radius.circular(10), bottomRight: Radius.circular(10)),
          onPressed: (context) {
            showDialog(
                context: context,
                builder: (context) => AlertDialog(
                      title: const Text(
                        'Delete Product',
                        style: TextStyle(color: Colors.red),
                      ),
                      content: RichText(
                        text: TextSpan(
                          children: [
                            const TextSpan(
                              text: 'Are you sure you want to delete ',
                            ),
                            TextSpan(
                              text: '${widget.productModel.name}?',
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const TextSpan(
                              text: '\nThis will be permanently deleted.',
                            ),
                          ],
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            BlocProvider.of<DashboardCubit>(context)
                                .deleteProduct(
                              widget.productModel,
                            );

                            Navigator.of(context).pop();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.red[400]!.withOpacity(0.2),
                            ),
                            padding: const EdgeInsets.all(10),
                            child: const Text('Delete',
                                style: TextStyle(color: Colors.red)),
                          ),
                        ),
                      ],
                    ));
          },
          backgroundColor: const Color(0xFFFE4A49),
          foregroundColor: Colors.white,
          icon: Icons.delete,
          label: 'Delete',
        ),
      ]),
      child: SizedBox(
        width: double.infinity,
        child: Card(
          color: Colors.grey[900],
          child: Padding(
            padding:
                const EdgeInsets.only(top: 12, bottom: 12, left: 12, right: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [

                      SizedBox(
                        height: MediaQuery.of(context).size.width * 0.2,
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: CachedNetworkImage(
                              placeholder: (context, url) => const Center(
                                child: CircularProgressIndicator(),
                              ),
                              errorWidget: (context, url, error) =>
                                  Image.asset('assets/images/placeholder.png'),
                              imageUrl: widget.productModel.picture!,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      const Gap(15),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              child: Text(
                                widget.productModel.name!,
                                style: MyTextStyles.titleSmall
                                    .copyWith(fontSize: 23),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const Gap(10),
                            SizedBox(
                              child: Text(
                                widget.productModel.description!,
                                style: MyTextStyles.body,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const Gap(10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '\$${widget.productModel.price}',
                      style:
                          MyTextStyles.subtitle.copyWith(color: Colors.green),
                    ),
                    const Gap(10),
                    Text(
                      'Quantity: ${widget.productModel.quantity}',
                      style: MyTextStyles.body,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
