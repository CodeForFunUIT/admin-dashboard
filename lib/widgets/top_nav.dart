import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:flutter_web_dashbard/constants/controllers.dart';
import 'package:flutter_web_dashbard/constants/style.dart';
import 'package:flutter_web_dashbard/helpers/responsiveness.dart';
import 'package:flutter_web_dashbard/models/product.dart';
import 'package:flutter_web_dashbard/pages/orders/order_table.dart';
import 'package:flutter_web_dashbard/widgets/custom_text.dart';
import 'package:flutter_web_dashbard/widgets/dialog_form.dart';
import 'package:flutter_web_dashbard/widgets/loading.dart';
import 'package:flutter_web_dashbard/widgets/snack_bar.dart';
import 'package:get/get.dart';

AppBar topNavigationBar(
  BuildContext context,
  GlobalKey<ScaffoldState> key,
) =>
    AppBar(
      leading: ResponsiveWidget.isSmallScreen(context)
          ? IconButton(
              onPressed: () {
                key.currentState!.openDrawer();
              },
              icon: const Icon(
                Icons.menu,
              ),
            )
          : Row(
              children: [
                Container(
                  padding: const EdgeInsets.only(
                    left: 14,
                  ),
                  child: Image.asset(
                    "assets/icons/logo.png",
                    width: 28,
                  ),
                )
              ],
            ),
      elevation: 0,
      title: Row(
        children: [
          Visibility(
            child: CustomText(
              text: "Dash",
              color: lightGrey,
              size: 20,
              weight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 224),
          // menuController
          Obx(
            () => menuController.activeItem.value == 'Products'
                ? Expanded(
                    child: ColoredBox(
                      color: Colors.white,
                      child: TypeAheadField<Product>(
                        hideSuggestionsOnKeyboardHide: true,
                        keepSuggestionsOnLoading: false,
                        textFieldConfiguration: const TextFieldConfiguration(
                          decoration: InputDecoration(
                            suffixIcon: Icon(Icons.search),
                            border: OutlineInputBorder(),
                            hintText: 'Search Products...',
                          ),
                        ),
                        suggestionsCallback: (string) async {
                          List<Product> products = productController.products
                              .where(
                                (e) => e.name!.toLowerCase().contains(string),
                              )
                              .toList();
                          return products;
                        },
                        itemBuilder: (context, product) {
                          return ListTile(
                            title: Text(product.name ?? ''),
                            subtitle: Text(
                              int.parse(product.price!).toVND(),
                            ),
                          );
                        },
                        onSuggestionSelected: (product) async {
                          Loading.startLoading(context);
                          await productController.getProductDetail(
                            product.id ?? '0',
                          );
                          Loading.stopLoading();
                          Get.dialog(
                            Dialog(
                              child: DialogForm(
                                idProduct: product.id!,
                                model: productController.detail,
                                idProductType: int.parse(
                                  product.idProductType ?? '0',
                                ),
                                idTradeMark: int.parse(
                                  product.idTradeMark ?? '0',
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  )
                : const Spacer(),
          ),
          const SizedBox(width: 24),
          IconButton(
            onPressed: () {
              CustomSnackBar.showCustomSnackBar(
                text: "This feature haven't finished yet",
                color: Colors.red,
              );
            },
            icon: Icon(
              Icons.settings,
              color: dark.withOpacity(.7),
            ),
          ),
          Stack(
            children: [
              IconButton(
                onPressed: () {
                  CustomSnackBar.showCustomSnackBar(
                    text: "This feature haven't finished yet",
                    color: Colors.red,
                  );
                },
                icon: Icon(
                  Icons.notifications,
                  color: dark.withOpacity(.7),
                ),
              ),
              Positioned(
                top: 7,
                right: 7,
                child: Container(
                  width: 12,
                  height: 12,
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: active,
                    border: Border.all(
                      color: light,
                      width: 2,
                    ),
                  ),
                ),
              )
            ],
          ),
          Container(
            width: 1,
            height: 22,
            color: lightGrey,
          ),
          const SizedBox(width: 24),
          CustomText(
            text: authController.admin!.username,
            color: lightGrey,
          ),
          const SizedBox(width: 16),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Container(
              padding: const EdgeInsets.all(2),
              margin: const EdgeInsets.all(2),
              child: CircleAvatar(
                backgroundColor: light,
                child: Icon(Icons.person_outline, color: dark),
              ),
            ),
          ),
        ],
      ),
      iconTheme: IconThemeData(color: dark),
      backgroundColor: Colors.transparent,
    );
