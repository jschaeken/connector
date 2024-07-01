class CustomerDataProperties {
  static const String id = 'id';
  static const String email = 'email';
  static const String createdAt = 'created_at';
  static const String updatedAt = 'updated_at';
  static const String firstName = 'first_name';
  static const String lastName = 'last_name';
  static const String ordersCount = 'orders_count';
  static const String state = 'state';
  static const String totalSpent = 'total_spent';
  static const String lastOrderId = 'last_order_id';
  static const String note = 'note';
  static const String verifiedEmail = 'verified_email';
  static const String taxExempt = 'tax_exempt';
  static const String tags = 'tags';
  static const String lastOrderName = 'last_order_name';
  static const String currency = 'currency';
  static const String phone = 'phone';

  static List<String> get properties => [
        id,
        email,
        createdAt,
        updatedAt,
        firstName,
        lastName,
        ordersCount,
        state,
        totalSpent,
        lastOrderId,
        note,
        verifiedEmail,
        taxExempt,
        tags,
        lastOrderName,
        currency,
        phone,
      ];
}
