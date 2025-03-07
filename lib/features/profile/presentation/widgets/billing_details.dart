import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:masalriyadh/core/models/country_model.dart';
import 'package:masalriyadh/core/models/customer_details_model.dart';
import 'package:masalriyadh/core/services/data/remote/dio_services.dart';
import 'package:masalriyadh/core/widgets/custom_button.dart';
import 'package:masalriyadh/core/widgets/custom_show_toast.dart';
import 'package:masalriyadh/core/widgets/custom_text_form_field.dart';
import 'package:masalriyadh/features/profile/presentation/widgets/shipping_details.dart';
import '../../../../core/services/data/local/shared_helper.dart';
import '../../../../core/services/data/local/shared_keys.dart';
import '../../../../core/services/register_services.dart';
import '../../manager/shipping_and_billing_cubit/shipping_and_billing_cubit.dart';

class BillingDetails extends StatefulWidget {
  const BillingDetails(
      {super.key, required this.customerDetailsModel, required this.cities});

  final CustomerDetailsModel customerDetailsModel;
  final Country cities;

  @override
  State<BillingDetails> createState() => _BillingDetailsState();
}

TextEditingController firstNameController = TextEditingController();
TextEditingController lastNameController = TextEditingController();
TextEditingController companyController = TextEditingController();
TextEditingController countryController = TextEditingController();
TextEditingController address1Controller = TextEditingController();
TextEditingController phoneController = TextEditingController();

TextEditingController editingController = TextEditingController();
TextEditingController address2Controller = TextEditingController();
TextEditingController cityController = TextEditingController();
TextEditingController stateController = TextEditingController();
TextEditingController postcodeController = TextEditingController();

class _BillingDetailsState extends State<BillingDetails> {
  @override
  void initState() {
    setState(() {
      editingController.text = widget.customerDetailsModel.email ?? '';
      firstNameController.text =
          widget.customerDetailsModel.billing?.firstName ?? '';
      lastNameController.text =
          widget.customerDetailsModel.billing?.lastName ?? '';
      companyController.text =
          widget.customerDetailsModel.billing?.company ?? '';
      countryController.text = 'Saudi Arabia';
      phoneController.text = widget.customerDetailsModel.billing?.phone ?? '';
      address1Controller.text =
          widget.customerDetailsModel.billing?.address1 ?? '';
      address2Controller.text =
          widget.customerDetailsModel.billing?.address2 ?? '';
      cityController.text = widget.customerDetailsModel.billing?.city ?? '';
      stateController.text = widget.customerDetailsModel.billing?.state ?? '';
      postcodeController.text =
          widget.customerDetailsModel.billing?.postcode ?? '';
    });
    super.initState();
  }

  bool isLoading = false;

  Future<bool> updateBilling({
    required Billing billing,
  }) async {
    final DioHelper dio = getIt.get<DioHelper>();
    String? customerId = SharedHelper.get(key: SharedKeys.customerId);
    final String url =
        'https://masalriyadh.com/wp-json/wc/v3/customers/$customerId';

    try {
      final response = await dio.put(
        url: url,
        body: {
          'billing': billing.toJson(),
        },
      ).catchError((error) {
        if (error is DioException) {
          print('=======================================');
          print('=======================================');
          print(error.response?.data);
          print('=======================================');
          print('=======================================');
        }
      });
      if (response.statusCode == 200) {
        print('تم تحديث بيانات الفوترة بنجاح');
        return true;
      } else {
        print('فشل التحديث: ${response.data}');
        return false;
      }
    } catch (e) {
      print('حدث خطأ أثناء التحديث: $e');
      return false;
    }
  }

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تفاصيل الفتورة'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: CustomScrollView(slivers: [
          SliverToBoxAdapter(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  CustomTextFormField(
                    label: 'الاسم الاول',
                    controller: firstNameController,
                    border: _buildOutlineInputBorder(),
                  ),
                  const SizedBox(height: 20),
                  CustomTextFormField(
                    label: 'الاسم الاخير',
                    controller: lastNameController,
                    border: _buildOutlineInputBorder(),
                  ),
                  const SizedBox(height: 20),
                  CustomTextFormField(
                    label: 'شركة',
                    controller: companyController,
                    border: _buildOutlineInputBorder(),
                    noValidator: true,
                  ),
                  const SizedBox(height: 20),
                  CustomTextFormField(
                    label: 'رقم الجوال',
                    controller: phoneController,
                    border: _buildOutlineInputBorder(),
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'من فضلك أدخل رقم الجوال';
                      } else if (!RegExp(r'^05\d{8}$').hasMatch(value)) {
                        return 'يجب أن يبدأ رقم الجوال بـ 05 ويكون مكونًا من 10 أرقام';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  CustomTextFormField(
                    label: 'البريد الالكتروني',
                    controller: emailController,
                    border: _buildOutlineInputBorder(),
                    noValidator: true,
                    isReadOnly: true,
                  ),
                  const SizedBox(height: 22),
                  _buildDashLine(context),
                  const SizedBox(height: 22),
                  CustomTextFormField(
                    label: 'الدولة',
                    controller: countryController,
                    border: _buildOutlineInputBorder(),
                    isReadOnly: true,
                  ),
                  // const SizedBox(height: 20),
                  // DropdownButtonFormField(
                  //   decoration: InputDecoration(
                  //     labelText: 'المدينة',
                  //     border: _buildOutlineInputBorder(),
                  //     enabledBorder: _buildOutlineInputBorder(),
                  //     focusedBorder: _buildOutlineInputBorder(),
                  //   ),
                  //   value:
                  //       cityController.text == '' ? null : cityController.text,
                  //   items: List.generate(
                  //     widget.cities.states.length,
                  //     (index) {
                  //       return DropdownMenuItem(
                  //         value: widget.cities.states[index].name,
                  //         child: Text(
                  //           widget.cities.states[index].name,
                  //         ),
                  //         onTap: () {
                  //           cityController.text =
                  //               widget.cities.states[index].name;
                  //         },
                  //       );
                  //     },
                  //   ),
                  //   validator: (value) {
                  //     if (value == null) {
                  //       return 'يرجي اختيار المدينة';
                  //     }
                  //     return null;
                  //   },
                  //   onChanged: (value) {},
                  // ),
                  const SizedBox(height: 20),
                  CustomTextFormField(
                    label: 'الرقم الضريبى ان وجد',
                    controller: postcodeController,
                    border: _buildOutlineInputBorder(),
                    validator: (value) {
                      if (value != null && value.isNotEmpty) {
                        if (!RegExp(r'^3\d{14}$').hasMatch(value)) {
                          return 'يجب أن يبدأ الرقم الضريبي بـ 3 ويكون مكونًا من 15 رقمًا';
                        }
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  CustomButton(
                    title: 'حفظ',
                    isLoading: isLoading,
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        setState(() {
                          isLoading = true;
                        });
                        await updateBilling(
                          billing: Billing(
                            firstName: firstNameController.text,
                            lastName: lastNameController.text,
                            company: companyController.text,
                            address1: address1Controller.text,
                            address2: address2Controller.text,
                            city: cityController.text,
                            state: stateController.text,
                            postcode: postcodeController.text,
                            country: countryController.text,
                            email: emailController.text,
                            phone: phoneController.text,
                          ),
                        ).then(
                          (value) {
                            setState(() {
                              isLoading = false;
                            });
                            if (value) {
                              customShowToast(
                                  message: 'تم التحديث',
                                  toastColor: ToastColor.success);
                            }
                            context
                                .read<ShippingAndBillingCubit>()
                                .getCustomerDetails()
                                .then(
                              (value) {
                                Navigator.pop(context);
                              },
                            );
                          },
                        ).catchError((error) {
                          setState(() {
                            isLoading = false;
                          });
                          print(error);
                        });
                      } else {}
                    },
                  ),
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }

  OutlineInputBorder _buildOutlineInputBorder() => const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(color: Colors.black54, width: 1),
      );

  Dash _buildDashLine(context) => Dash(
        length: MediaQuery.of(context).size.width - 100,
        dashColor: Colors.grey[350]!,
        dashLength: 5,
        dashGap: 5,
        dashThickness: 2,
      );
}
