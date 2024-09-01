import 'package:admin_dashboard_store_app/Core/helpers/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class LoadingEffect extends StatelessWidget {
  const LoadingEffect({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: ShimmerEffect(
        width: double.infinity,
        child: Container(
          height: 110,
          padding: const EdgeInsets.only(left: 10, bottom: 10, top: 10),
          decoration: BoxDecoration(
            color: Colors.grey[800]!.withOpacity(.1),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  height: 70,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey.withOpacity(.1),
                  ),
                ),
              ),
              const Gap(30),
              Expanded(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        ShimmerEffect(
                            width: MediaQuery.of(context).size.width * .46,
                            child: Container(
                              height: 24,
                              color: Colors.grey.withOpacity(.1),
                            )),
                        const Gap(20),
                        ShimmerEffect(
                            width: MediaQuery.of(context).size.width * .15,
                            child: Container(
                              height: 24,
                              color: Colors.grey.withOpacity(.1),
                            )),
                      ],
                    ),
                    const Gap(15),
                    Row(
                      children: [
                        ShimmerEffect(
                            width: MediaQuery.of(context).size.width * .46,
                            child: Container(
                              height: 10,
                              color: Colors.grey.withOpacity(.1),
                            )),
                        const Gap(15),
                        ShimmerEffect(
                            width: MediaQuery.of(context).size.width * .18,
                            child: Container(
                              height: 10,
                              color: Colors.grey.withOpacity(.1),
                            )),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
