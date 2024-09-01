import 'package:admin_dashboard_store_app/Features/brand/manager/cubit/brand_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomLoadingPaginate extends StatelessWidget {
  const BottomLoadingPaginate({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<BrandCubit, BrandState>(
        buildWhen: (previous, current) =>
            current is BrandLoadingPagination ||
            current is BrandSuccess ||
            current is BrandFailurePagination,
        builder: (context, state) {
          if (state is BrandLoadingPagination) {
            return const LinearProgressIndicator(
              color: Colors.white,
            );
          } else if (state is BrandFailurePagination) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                state.error,
                textAlign: TextAlign.center,
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
