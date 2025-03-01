import 'dart:convert';
import 'package:masalriyadh/core/models/customer_details_model.dart';

List<OrderModel> ordersFromJson(List<dynamic>? list) =>
    list == null ? [] : list.map((x) => OrderModel.fromJson(x)).toList();

String orderToJson(List<OrderModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OrderModel {
  final int? orderId;
  final String status;
  final String total;
  final List<ShippingLine> shippingLines;
  final String discountTotal;
  final String totalTax;
  final int customerId;
  final Billing? billing;
  final Shipping? shipping;
  final String paymentMethod;
  final String paymentMethodTitle;
  final bool setPaid;
  final List<LineItem> lineItems;
  final List<CouponLine>? couponLines;
  final List<MetaData>? metaData;

  OrderModel({
    this.orderId,
    required this.customerId,
    required this.status,
    required this.total,
    required this.shippingLines,
    this.discountTotal = "0.00",
    this.totalTax = "0.00",
    this.billing,
    this.shipping,
    required this.paymentMethod,
    required this.paymentMethodTitle,
    this.setPaid = false,
    required this.lineItems,
    this.couponLines,
    this.metaData,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        orderId: json["id"] ?? 0,
        customerId: json["customer_id"] ?? 0,
        status: json["status"] ?? "pending",
        total: json["total"].toString(),
        shippingLines: (json["shipping_lines"] as List<dynamic>?)
                ?.map((x) => ShippingLine.fromJson(x))
                .toList() ??
            [],
        discountTotal: json["discount_total"].toString(),
        totalTax: json["total_tax"].toString(),
        billing:
            json["billing"] != null ? Billing.fromJson(json["billing"]) : null,
        shipping: json["shipping"] != null
            ? Shipping.fromJson(json["shipping"])
            : null,
        paymentMethod: json["payment_method"] ?? "",
        paymentMethodTitle: json["payment_method_title"] ?? "",
        setPaid: json["set_paid"] ?? false,
        lineItems: (json["line_items"] as List<dynamic>?)
                ?.map((x) => LineItem.fromJson(x))
                .toList() ??
            [],
        couponLines: (json["coupon_lines"] as List<dynamic>?)
                ?.map((x) => CouponLine.fromJson(x))
                .toList() ??
            [],
        metaData: (json["meta_data"] as List<dynamic>?)
                ?.map((x) => MetaData.fromJson(x))
                .toList() ??
            [],
      );

  Map<String, dynamic> toJson() => {
        "id": orderId,
        "customer_id": customerId,
        "status": status,
        "total": total,
        "shipping_lines": shippingLines.map((x) => x.toJson()).toList(),
        "discount_total": discountTotal,
        "total_tax": totalTax,
        "billing": billing?.toJson(),
        "shipping": shipping?.toJson(),
        "payment_method": paymentMethod,
        "payment_method_title": paymentMethodTitle,
        "set_paid": setPaid,
        "line_items": lineItems.map((x) => x.toJson()).toList(),
        if (couponLines != null)
          "coupon_lines": couponLines!.map((x) => x.toJson()).toList(),
        if (metaData != null)
          "meta_data": metaData!.map((x) => x.toJson()).toList(),
      };
}

class ShippingLine {
  final String methodId;
  final String methodTitle;
  final String total;

  ShippingLine({
    required this.methodId,
    required this.methodTitle,
    required this.total,
  });

  factory ShippingLine.fromJson(Map<String, dynamic> json) => ShippingLine(
        methodId: json["method_id"] ?? "",
        methodTitle: json["method_title"] ?? "",
        total: json["total"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "method_id": methodId,
        "method_title": methodTitle,
        "total": total,
      };
}

class LineItem {
  final int productId;
  final String? name;
  final int? variationId;
  final int quantity;
  final String total;
  final String price;
  final String subtotal;
  final String subtotalTax;
  final String totalTax;
  final List<Tax>? taxes;
  final String? sku;
  final ImageData? image;
  final List<MetaData>? metaData;
  final String? orderThumbnail;

  LineItem({
    this.name,
    required this.productId,
    this.variationId,
    required this.quantity,
    required this.total,
    this.price = "0.00",
    this.subtotal = "0.00",
    this.subtotalTax = "0.00",
    this.totalTax = "0.00",
    this.taxes,
    this.sku,
    this.image,
    this.metaData,
    this.orderThumbnail,
  });

  factory LineItem.fromJson(Map<String, dynamic> json) => LineItem(
        productId: json["product_id"] ?? 0,
        variationId: json["variation_id"],
        quantity: json["quantity"] ?? 1,
        total: json["total"].toString(),
        price: json["price"].toString(),
        subtotal: json["subtotal"].toString(),
        subtotalTax: json["subtotal_tax"].toString(),
        totalTax: json["total_tax"].toString(),
        taxes: (json["taxes"] as List<dynamic>?)
            ?.map((x) => Tax.fromJson(x))
            .toList(),
        sku: json["sku"],
        image: json["image"] != null ? ImageData.fromJson(json["image"]) : null,
        metaData: (json["meta_data"] as List<dynamic>?)
            ?.map((x) => MetaData.fromJson(x))
            .toList(),
        orderThumbnail: json["ams_order_thumbnail"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "product_id": productId,
        "variation_id": variationId ?? 0,
        "quantity": quantity,
        "total": total,
        "price": price,
        "subtotal": subtotal,
        "subtotal_tax": subtotalTax,
        "total_tax": totalTax,
        if (taxes != null) "taxes": taxes!.map((x) => x.toJson()).toList(),
        if (sku != null) "sku": sku,
        if (image != null) "image": image!.toJson(),
        if (metaData != null)
          "meta_data": metaData!.map((x) => x.toJson()).toList(),
        if (orderThumbnail != null) "ams_order_thumbnail": orderThumbnail,
        if (name != null) "name": name,
      };
}

class Tax {
  final int id;
  final String total;
  final String subtotal;

  Tax({
    required this.id,
    required this.total,
    required this.subtotal,
  });

  factory Tax.fromJson(Map<String, dynamic> json) => Tax(
        id: json["id"] ?? 0,
        total: json["total"].toString(),
        subtotal: json["subtotal"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "total": total,
        "subtotal": subtotal,
      };
}

class ImageData {
  final String id;
  final String src;

  ImageData({
    required this.id,
    required this.src,
  });

  factory ImageData.fromJson(Map<String, dynamic> json) => ImageData(
        id: json["id"].toString(),
        src: json["src"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "src": src,
      };
}

class CouponLine {
  final String code;

  CouponLine({
    required this.code,
  });

  factory CouponLine.fromJson(Map<String, dynamic> json) => CouponLine(
        code: json["code"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "code": code,
      };
}

class MetaData {
  final String key;
  final dynamic value;

  MetaData({
    required this.key,
    required this.value,
  });

  factory MetaData.fromJson(Map<String, dynamic> json) => MetaData(
        key: json["key"] ?? "",
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "key": key,
        "value": value,
      };
}
