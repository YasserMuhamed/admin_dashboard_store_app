import 'package:admin_dashboard_store_app/Features/dashboard/data/models/product_model.dart';
import 'package:admin_dashboard_store_app/configs/theme/my_colors.dart';
import 'package:admin_dashboard_store_app/Core/utils/text_styles/text_styles.dart';
import 'package:admin_dashboard_store_app/Features/brand/manager/cubit/brand_cubit.dart';
import 'package:admin_dashboard_store_app/Features/categories/manager/categories/categories_cubit.dart';
import 'package:admin_dashboard_store_app/Features/dashboard/manager/cubit/dashboard_cubit.dart';
import 'package:admin_dashboard_store_app/Features/dashboard/presentation/widgets/titled_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class EditProductView extends StatefulWidget {
  const EditProductView({super.key, required this.product});

  final ProductModel product;

  @override
  State<EditProductView> createState() => _EditProductViewState();
}

class _EditProductViewState extends State<EditProductView> {
  // controllers
  TextEditingController nameController = TextEditingController();
  TextEditingController imageController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  ScrollController scrollController = ScrollController();

  // form key
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  // variables
  String? selectedBrand;
  String? selectedCategory;
  int? selectedBrandId;
  int? selectedCategoryId;

  @override
  void initState() {
    nameController.text = widget.product.name.toString();
    priceController.text = widget.product.price.toString();
    quantityController.text = widget.product.quantity.toString();
    imageController.text = widget.product.picture.toString();
    descriptionController.text = widget.product.description.toString();
    BlocProvider.of<BrandCubit>(context).getBrandsNames();
    BlocProvider.of<CategoriesCubit>(context).getCategoriesNames();
    BlocProvider.of<DashboardCubit>(context)
        .getProductDetails(widget.product.id.toString());
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    imageController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    quantityController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      autovalidateMode: autovalidateMode,
      child: Scaffold(
        appBar: _appBar(),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: ListView(
            children: [
              _editProductTextFields(),
              const Gap(12),
              _brandSection(context),
              const Gap(14),
              _categorySection(context),
              const Gap(30),
              _createButton(),
              const Gap(20),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: Text(
        'Edit Product',
        style: MyTextStyles.titleSmall,
      ),
      centerTitle: true,
    );
  }

  Column _editProductTextFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitledTextField(
          controller: nameController,
          title: 'Product Name',
          hintText: 'Product Name',
          validator: (value) {
            if (value.isEmpty) {
              return "One parameter must be filled at least";
            }
            return null;
          },
        ),
        TitledTextField(
          controller: priceController,
          keyType: TextInputType.number,
          title: 'Price',
          hintText: 'Price (EGP)',
          validator: (value) {
            if (value.isEmpty) {
              return "One parameter must be filled at least";
            }
            return null;
          },
        ),
        TitledTextField(
            controller: quantityController,
            keyType: TextInputType.number,
            title: 'Quantity',
            hintText: "Quantity Number",
            validator: (value) {
              if (value.isEmpty) {
                return "One parameter must be filled at least";
              }
              return null;
            }),
        TitledTextField(
            controller: imageController,
            title: "Image",
            hintText: "Image URL",
            validator: (value) {
              if (value.isEmpty) {
                return "One parameter must be filled at least";
              } else if (!imageController.text.contains("http")) {
                return "use valid image url";
              }
              return null;
            }),
        TitledTextField(
          controller: descriptionController,
          title: "Description",
          hintText: "Description of Product",
          validator: (value) {
            if (value.isEmpty || value.length < 20) {
              return "Description is required and must be at least 20 characters";
            }
            return null;
          },
          maxLines: 3,
        ),
      ],
    );
  }

  BlocBuilder _categorySection(BuildContext context) {
    return BlocBuilder<DashboardCubit, DashboardState>(
      builder: (context, state) {
        var data = BlocProvider.of<DashboardCubit>(context).data;
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Category",
              style: MyTextStyles.titleSmall.copyWith(fontSize: 20),
            ),
            SizedBox(
              width: MediaQuery.sizeOf(context).width * .5,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey.shade900),
                  onPressed: () {
                    showCategoryBottomSheet(context);
                  },
                  child: selectedCategory != null
                      ? Text(
                          selectedCategory!,
                          style: MyTextStyles.subtitleSmall,
                        )
                      : Text(data.category!.name!)),
            ),
          ],
        );
      },
    );
  }

  Future<dynamic> showCategoryBottomSheet(BuildContext context) {
    return showModalBottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8), topRight: Radius.circular(8))),
        backgroundColor: MyColors.darkGrey,
        context: context,
        builder: (context) {
          return DraggableScrollableSheet(
              initialChildSize: 1,
              minChildSize: .8,
              builder: (BuildContext context,
                      ScrollController scrollController) =>
                  ListView.builder(
                    controller: scrollController,
                    itemCount: BlocProvider.of<CategoriesCubit>(context)
                        .categoriesNames
                        .length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          // const Gap(14),
                          ListTile(
                            title: Text(
                              '${BlocProvider.of<CategoriesCubit>(context).categoriesNames[index].name}',
                              textAlign: TextAlign.center,
                              style: MyTextStyles.subtitleSmall
                                  .copyWith(fontSize: 20),
                            ),
                            onTap: () {
                              setState(() {
                                selectedCategory =
                                    BlocProvider.of<CategoriesCubit>(context)
                                        .categoriesNames[index]
                                        .name;
                                selectedCategoryId =
                                    BlocProvider.of<CategoriesCubit>(context)
                                        .categoriesNames[index]
                                        .id;
                              });
                              Navigator.pop(context);
                            },
                          ),
                          const Divider(
                            indent: 35,
                            endIndent: 35,
                            color: MyColors.grey,
                          )
                        ],
                      );
                    },
                  ));
        });
  }

  BlocBuilder _brandSection(BuildContext context) {
    return BlocBuilder<DashboardCubit, DashboardState>(
      builder: (context, state) {
        var data = BlocProvider.of<DashboardCubit>(context).data;
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Brand",
              style: MyTextStyles.titleSmall.copyWith(fontSize: 20),
            ),
            SizedBox(
              width: MediaQuery.sizeOf(context).width * .5,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey.shade900),
                  onPressed: () {
                    showBrandBottomSheet(context);
                  },
                  child: selectedBrand != null
                      ? Text(
                          selectedBrand!,
                          style: MyTextStyles.subtitleSmall,
                        )
                      : Text(data.brand!.name!)),
            ),
          ],
        );
      },
    );
  }

  Future<dynamic> showBrandBottomSheet(BuildContext context) {
    return showModalBottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8), topRight: Radius.circular(8))),
        backgroundColor: MyColors.darkGrey,
        context: context,
        builder: (context) {
          return DraggableScrollableSheet(
              initialChildSize: 1,
              minChildSize: .8,
              builder: (BuildContext context,
                      ScrollController scrollController) =>
                  ListView.builder(
                    physics: const ClampingScrollPhysics(),
                    controller: scrollController,
                    itemCount:
                        BlocProvider.of<BrandCubit>(context).brandsNames.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          // const Gap(14),
                          ListTile(
                            title: Text(
                              '${BlocProvider.of<BrandCubit>(context).brandsNames[index].name}',
                              textAlign: TextAlign.center,
                              style: MyTextStyles.subtitleSmall
                                  .copyWith(fontSize: 20),
                            ),
                            onTap: () {
                              setState(() {
                                selectedBrand =
                                    BlocProvider.of<BrandCubit>(context)
                                        .brandsNames[index]
                                        .name;
                                selectedBrandId =
                                    BlocProvider.of<BrandCubit>(context)
                                        .brandsNames[index]
                                        .id;
                              });
                              Navigator.pop(context);
                            },
                          ),
                          const Divider(
                            indent: 35,
                            endIndent: 35,
                            color: MyColors.grey,
                          )
                        ],
                      );
                    },
                  ));
        });
  }

  Center _createButton() {
    return Center(
      child: BlocConsumer<DashboardCubit, DashboardState>(
        listener: (context, state) => {
          if (state is ProductSuccessCreating)
            {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(color: Colors.greenAccent, width: 1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  content: const Text('Product Created Successfully',
                      style: TextStyle(color: Colors.white)),
                  backgroundColor: Colors.green.shade800,
                ),
              ),
              BlocProvider.of<DashboardCubit>(context)
                  .getProducts(isPaginationLoading: false),
              GoRouter.of(context).pop(),
            }
          else if (state is ProductFailureCreating)
            {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.red.shade800, width: 1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  content: Text(state.error,
                      style: const TextStyle(color: Colors.white)),
                  backgroundColor: Colors.red.shade800,
                ),
              ),
            }
        },
        builder: (context, state) {
          return SizedBox(
            width: double.infinity,
            height: 60,
            child: ElevatedButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  BlocProvider.of<DashboardCubit>(context).editProduct(
                      id: widget.product.id!,
                      name: nameController.text,
                      imageUrl: imageController.text,
                      price: int.parse(priceController.text),
                      quantity: int.parse(quantityController.text),
                      description: descriptionController.text,
                      categoryId:
                          selectedCategoryId ?? widget.product.categoryId!,
                      brandId: selectedBrandId ?? widget.product.brandId!);
                } else {
                  setState(() {
                    autovalidateMode = AutovalidateMode.onUserInteraction;
                  });
                }
              },
              child: state is ProductLoadingCreating
                  ? const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Edit",
                          style: TextStyle(fontSize: 18),
                        ),
                        Gap(10),
                        SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      ],
                    )
                  : const Text(
                      "Edit",
                      style: TextStyle(fontSize: 18),
                    ),
            ),
          );
        },
      ),
    );
  }
}
