import 'dart:convert';

OrderListResponseModel orderListResponseModelFromJson(String str) =>
    OrderListResponseModel.fromJson(json.decode(str));

String orderListResponseModelToJson(OrderListResponseModel data) =>
    json.encode(data.toJson());

class OrderListResponseModel {
  OrderListResponseModel({
    this.id,
    this.orderNumber,
    this.orderKey,
    this.createdAt,
    this.updatedAt,
    this.completedAt,
    this.status,
    this.currency,
    this.total,
    this.subtotal,
    this.totalLineItemsQuantity,
    this.totalTax,
    this.totalShipping,
    this.cartTax,
    this.shippingTax,
    this.totalDiscount,
    this.shippingMethods,
    this.paymentDetails,
    this.billingAddress,
    this.shippingAddress,
    this.note,
    this.customerIp,
    this.customerUserAgent,
    this.customerId,
    this.viewOrderUrl,
    this.lineItems,
    this.shippingLines,
    this.taxLines,
    this.feeLines,
    this.couponLines,
    this.customer,
  });

  int id;
  String orderNumber;
  String orderKey;
  DateTime createdAt;
  DateTime updatedAt;
  DateTime completedAt;
  String status;
  String currency;
  String total;
  String subtotal;
  int totalLineItemsQuantity;
  String totalTax;
  String totalShipping;
  String cartTax;
  String shippingTax;
  String totalDiscount;
  String shippingMethods;
  PaymentDetails paymentDetails;
  IngAddress billingAddress;
  IngAddress shippingAddress;
  String note;
  String customerIp;
  String customerUserAgent;
  int customerId;
  String viewOrderUrl;
  List<LineItem> lineItems;
  List<ShippingLine> shippingLines;
  List<dynamic> taxLines;
  List<dynamic> feeLines;
  List<dynamic> couponLines;
  Customer customer;

  factory OrderListResponseModel.fromJson(Map<String, dynamic> json) =>
      OrderListResponseModel(
        id: json["id"],
        orderNumber: json["order_number"],
        orderKey: json["order_key"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        completedAt: DateTime.parse(json["completed_at"]),
        status: json["status"],
        currency: json["currency"],
        total: json["total"],
        subtotal: json["subtotal"],
        totalLineItemsQuantity: json["total_line_items_quantity"],
        totalTax: json["total_tax"],
        totalShipping: json["total_shipping"],
        cartTax: json["cart_tax"],
        shippingTax: json["shipping_tax"],
        totalDiscount: json["total_discount"],
        shippingMethods: json["shipping_methods"],
        paymentDetails: PaymentDetails.fromJson(json["payment_details"]),
        billingAddress: IngAddress.fromJson(json["billing_address"]),
        shippingAddress: IngAddress.fromJson(json["shipping_address"]),
        note: json["note"],
        customerIp: json["customer_ip"],
        customerUserAgent: json["customer_user_agent"],
        customerId: json["customer_id"],
        viewOrderUrl: json["view_order_url"],
        lineItems: List<LineItem>.from(
            json["line_items"].map((x) => LineItem.fromJson(x))),
        shippingLines: List<ShippingLine>.from(
            json["shipping_lines"].map((x) => ShippingLine.fromJson(x))),
        taxLines: List<dynamic>.from(json["tax_lines"].map((x) => x)),
        feeLines: List<dynamic>.from(json["fee_lines"].map((x) => x)),
        couponLines: List<dynamic>.from(json["coupon_lines"].map((x) => x)),
        customer: Customer.fromJson(json["customer"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "order_number": orderNumber,
        "order_key": orderKey,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "completed_at": completedAt.toIso8601String(),
        "status": status,
        "currency": currency,
        "total": total,
        "subtotal": subtotal,
        "total_line_items_quantity": totalLineItemsQuantity,
        "total_tax": totalTax,
        "total_shipping": totalShipping,
        "cart_tax": cartTax,
        "shipping_tax": shippingTax,
        "total_discount": totalDiscount,
        "shipping_methods": shippingMethods,
        "payment_details": paymentDetails.toJson(),
        "billing_address": billingAddress.toJson(),
        "shipping_address": shippingAddress.toJson(),
        "note": note,
        "customer_ip": customerIp,
        "customer_user_agent": customerUserAgent,
        "customer_id": customerId,
        "view_order_url": viewOrderUrl,
        "line_items": List<dynamic>.from(lineItems.map((x) => x.toJson())),
        "shipping_lines":
            List<dynamic>.from(shippingLines.map((x) => x.toJson())),
        "tax_lines": List<dynamic>.from(taxLines.map((x) => x)),
        "fee_lines": List<dynamic>.from(feeLines.map((x) => x)),
        "coupon_lines": List<dynamic>.from(couponLines.map((x) => x)),
        "customer": customer.toJson(),
      };
}

class IngAddress {
  IngAddress({
    this.firstName,
    this.lastName,
    this.company,
    this.address1,
    this.address2,
    this.city,
    this.state,
    this.postcode,
    this.country,
    this.email,
    this.phone,
  });

  String firstName;
  String lastName;
  String company;
  String address1;
  String address2;
  String city;
  String state;
  String postcode;
  String country;
  String email;
  String phone;

  factory IngAddress.fromJson(Map<String, dynamic> json) => IngAddress(
        firstName: json["first_name"],
        lastName: json["last_name"],
        company: json["company"],
        address1: json["address_1"],
        address2: json["address_2"],
        city: json["city"],
        state: json["state"],
        postcode: json["postcode"],
        country: json["country"],
        email: json["email"] == null ? null : json["email"],
        phone: json["phone"] == null ? null : json["phone"],
      );

  Map<String, dynamic> toJson() => {
        "first_name": firstName,
        "last_name": lastName,
        "company": company,
        "address_1": address1,
        "address_2": address2,
        "city": city,
        "state": state,
        "postcode": postcode,
        "country": country,
        "email": email == null ? null : email,
        "phone": phone == null ? null : phone,
      };
}

class Customer {
  Customer({
    this.id,
    this.createdAt,
    this.lastUpdate,
    this.email,
    this.firstName,
    this.lastName,
    this.username,
    this.role,
    this.lastOrderId,
    this.lastOrderDate,
    this.ordersCount,
    this.totalSpent,
    this.avatarUrl,
    this.billingAddress,
    this.shippingAddress,
  });

  int id;
  DateTime createdAt;
  DateTime lastUpdate;
  String email;
  String firstName;
  String lastName;
  String username;
  String role;
  int lastOrderId;
  DateTime lastOrderDate;
  int ordersCount;
  String totalSpent;
  String avatarUrl;
  IngAddress billingAddress;
  IngAddress shippingAddress;

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        id: json["id"],
        createdAt: DateTime.parse(json["created_at"]),
        lastUpdate: DateTime.parse(json["last_update"]),
        email: json["email"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        username: json["username"],
        role: json["role"],
        lastOrderId: json["last_order_id"],
        lastOrderDate: DateTime.parse(json["last_order_date"]),
        ordersCount: json["orders_count"],
        totalSpent: json["total_spent"],
        avatarUrl: json["avatar_url"],
        billingAddress: IngAddress.fromJson(json["billing_address"]),
        shippingAddress: IngAddress.fromJson(json["shipping_address"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt.toIso8601String(),
        "last_update": lastUpdate.toIso8601String(),
        "email": email,
        "first_name": firstName,
        "last_name": lastName,
        "username": username,
        "role": role,
        "last_order_id": lastOrderId,
        "last_order_date": lastOrderDate.toIso8601String(),
        "orders_count": ordersCount,
        "total_spent": totalSpent,
        "avatar_url": avatarUrl,
        "billing_address": billingAddress.toJson(),
        "shipping_address": shippingAddress.toJson(),
      };
}

class LineItem {
  LineItem({
    this.id,
    this.subtotal,
    this.subtotalTax,
    this.total,
    this.totalTax,
    this.price,
    this.quantity,
    this.taxClass,
    this.name,
    this.productId,
    this.sku,
    this.meta,
  });

  int id;
  String subtotal;
  String subtotalTax;
  String total;
  String totalTax;
  String price;
  int quantity;
  String taxClass;
  String name;
  int productId;
  String sku;
  List<dynamic> meta;

  factory LineItem.fromJson(Map<String, dynamic> json) => LineItem(
        id: json["id"],
        subtotal: json["subtotal"],
        subtotalTax: json["subtotal_tax"],
        total: json["total"],
        totalTax: json["total_tax"],
        price: json["price"],
        quantity: json["quantity"],
        taxClass: json["tax_class"],
        name: json["name"],
        productId: json["product_id"],
        sku: json["sku"],
        meta: List<dynamic>.from(json["meta"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "subtotal": subtotal,
        "subtotal_tax": subtotalTax,
        "total": total,
        "total_tax": totalTax,
        "price": price,
        "quantity": quantity,
        "tax_class": taxClass,
        "name": name,
        "product_id": productId,
        "sku": sku,
        "meta": List<dynamic>.from(meta.map((x) => x)),
      };
}

class PaymentDetails {
  PaymentDetails({
    this.methodId,
    this.methodTitle,
    this.paid,
  });

  String methodId;
  String methodTitle;
  bool paid;

  factory PaymentDetails.fromJson(Map<String, dynamic> json) => PaymentDetails(
        methodId: json["method_id"],
        methodTitle: json["method_title"],
        paid: json["paid"],
      );

  Map<String, dynamic> toJson() => {
        "method_id": methodId,
        "method_title": methodTitle,
        "paid": paid,
      };
}

class ShippingLine {
  ShippingLine({
    this.id,
    this.methodId,
    this.methodTitle,
    this.total,
  });

  int id;
  String methodId;
  String methodTitle;
  String total;

  factory ShippingLine.fromJson(Map<String, dynamic> json) => ShippingLine(
        id: json["id"],
        methodId: json["method_id"],
        methodTitle: json["method_title"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "method_id": methodId,
        "method_title": methodTitle,
        "total": total,
      };
}
