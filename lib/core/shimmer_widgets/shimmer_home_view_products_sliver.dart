import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerHomeViewProductsSliver extends StatelessWidget {
  const   ShimmerHomeViewProductsSliver({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5, // عدد العناصر اللي هتظهر أثناء التحميل
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                width: 250,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      height: 250,
                      color: Colors.grey[300], // صورة المنتج الوهمية
                    ),
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Container(
                              width: 80,
                              height: 15,
                              color: Colors.grey[300], // السعر الأصلي
                            ),
                            const SizedBox(height: 5),
                            Container(
                              width: 100,
                              height: 18,
                              color: Colors.grey[300], // السعر بعد الخصم
                            ),
                            const SizedBox(height: 10),
                            Container(
                              width: double.infinity,
                              height: 20,
                              color: Colors.grey[300], // اسم المنتج
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
