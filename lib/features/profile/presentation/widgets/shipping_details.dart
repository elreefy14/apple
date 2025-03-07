import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:masalriyadh/core/models/customer_details_model.dart';
import 'package:masalriyadh/core/widgets/custom_button.dart';
import 'package:masalriyadh/core/widgets/custom_text_form_field.dart';
import 'package:masalriyadh/features/profile/manager/shipping_and_billing_cubit/shipping_and_billing_cubit.dart';
import 'package:masalriyadh/features/profile/presentation/widgets/billing_details.dart';

import '../../../../core/models/country_model.dart';
import '../../../../core/services/data/local/shared_helper.dart';
import '../../../../core/services/data/local/shared_keys.dart';
import '../../../../core/services/data/remote/dio_services.dart';
import '../../../../core/services/register_services.dart';
import '../../../../core/widgets/custom_show_toast.dart';

class ShippingDetails extends StatefulWidget {
  const ShippingDetails({super.key, required this.customerDetailsModel,required this.cities});
  final Country cities;

  final CustomerDetailsModel customerDetailsModel;

  @override
  State<ShippingDetails> createState() => _ShippingDetailsState();
}

TextEditingController firstNameController = TextEditingController();
TextEditingController lastNameController = TextEditingController();
TextEditingController emailController = TextEditingController();
TextEditingController address1Controller = TextEditingController();
TextEditingController address2Controller = TextEditingController();
TextEditingController cityController = TextEditingController();
TextEditingController stateController = TextEditingController();
TextEditingController cuntaryController = TextEditingController();
TextEditingController postcodeController = TextEditingController();

Future<bool> updateShipping({
  required Shipping shipping,
}) async {
  final DioHelper dio = getIt.get<DioHelper>();
  String? customerId = SharedHelper.get(key: SharedKeys.customerId);
  print(customerId);
  final String url =
      'https://masalriyadh.com/wp-json/wc/v3/customers/$customerId';

  try {
    final response = await dio.put(
      url: url,
      body: {
        'shipping': shipping.toJson(),
      },
    );
    if (response.statusCode == 200) {
      print('تم تحديث بيانات الشحن بنجاح');
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

bool isLoading = false;

class _ShippingDetailsState extends State<ShippingDetails> {
  @override
  void initState() {
    setState(() {
      cuntaryController.text = 'Saudi Arabia';
      firstNameController.text =
          widget.customerDetailsModel.shipping?.firstName ?? '';
      lastNameController.text =
          widget.customerDetailsModel.shipping?.lastName ?? '';
      emailController.text = widget.customerDetailsModel.email ?? '';
      address1Controller.text =
          widget.customerDetailsModel.shipping?.address1 ?? '';
      address2Controller.text =
          widget.customerDetailsModel.shipping?.address2 ?? '';
      cityController.text = widget.customerDetailsModel.shipping?.city ?? '';
      stateController.text = widget.customerDetailsModel.shipping?.state ?? '';
      postcodeController.text =
          widget.customerDetailsModel.shipping?.postcode ?? '';
    });
    super.initState();
  }

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShippingAndBillingCubit, ShippingAndBillingState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('تفاصيل الشحن'),
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
                        label: 'frist name',
                        controller: firstNameController,
                        border: _buildOutlineInputBorder(),
                      ),
                      const SizedBox(height: 20),
                      CustomTextFormField(
                        label: 'last name',
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
                      const SizedBox(height: 22),
                      _buildDashLine(context),
                      const SizedBox(height: 22),
                      CustomTextFormField(
                        label: 'بريد الالكتروني',
                        controller: emailController,
                        border: _buildOutlineInputBorder(),
                        isReadOnly: true,
                      ),

                      const SizedBox(height: 22),
                      _buildDashLine(context),
                      const SizedBox(height: 20),
                      CustomTextFormField(
                        label: 'الدولة',
                        controller: cuntaryController,
                        border: _buildOutlineInputBorder(),
                        noValidator: true,
                      ),
                      const SizedBox(height: 20),
                      DropdownButtonFormField(

                        decoration:  InputDecoration(
                          labelText: 'المدينة',

                          border: _buildOutlineInputBorder(),
                          enabledBorder: _buildOutlineInputBorder(),
                          focusedBorder: _buildOutlineInputBorder(),
                        ),
                        value:
                        cityController.text == '' ? null : cityController.text,
                        items: List.generate(
                          widget.cities.states.length,
                              (index) {
                            return DropdownMenuItem(
                              value: widget.cities.states[index].name,
                              child: Text(
                                widget.cities.states[index].name,
                              ),
                              onTap: () {
                                cityController.text =
                                    widget.cities.states[index].name;
                              },
                            );
                          },
                        ),
                        validator:  (value) {
                          if (value == null) {
                            return 'يرجي اختيار المدينة';
                          }
                          return null;
                        },
                        onChanged: (value) {},
                      ),

                      const SizedBox(height: 22),
                      CustomTextFormField(
                        label: 'سطر العنوان 1',
                        controller: address1Controller,
                        border: _buildOutlineInputBorder(),
                      ),
                      const SizedBox(height: 20),
                      CustomTextFormField(
                        label: 'سطر العنوان 2',
                        controller: address2Controller,
                        border: _buildOutlineInputBorder(),
                        noValidator: true,
                      ),

                      const SizedBox(height: 20),
                      CustomTextFormField(
                        label: 'ولاية / مقاطعه',
                        controller: stateController,
                        border: _buildOutlineInputBorder(),
                      ),
                      const SizedBox(height: 20),
                      CustomTextFormField(
                        label: 'الرمز البريدي',
                        controller: postcodeController,
                        border: _buildOutlineInputBorder(),
                        noValidator: true,
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
                            await updateShipping(
                              shipping: Shipping(
                                firstName: firstNameController.text,
                                lastName: lastNameController.text,
                                company: companyController.text,
                                address1: address1Controller.text,
                                address2: address2Controller.text,
                                city: cityController.text,
                                state: stateController.text,
                                postcode: postcodeController.text,
                                country: countryController.text,
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
                          }
                        },
                      ),
                    ],
                  ),
                ),
              )
            ]),
          ),
        );
      },
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
