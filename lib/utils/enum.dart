enum Pages {
  deliveryTime,
  addAddress,
  summary,
}

enum Delivery {
  StandardDelivery,
  NextDayDelivery,
  NominatedDelivery,
}

enum OrderStatus {
  pending,
  processing,
  shipped,
  delivered,
  cancelled,
}

enum PaymentMethods {
  paypal,
  googlePay,
  applePay,
  visa,
  masterCard,
  creditCard,
  payStack,
  razorpay,
  paytm
}

enum AppRole {
  user,
  admin,
}
