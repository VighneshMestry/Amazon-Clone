const mongoose = require("mongoose");
const { productSchema } = require("./product");

const orderSchema = mongoose.Schema({
  products: [
    // The product in the cart
    {
      product: productSchema,
      quantity: {
        type: Number,
        required: true,
      },
    },
  ],
  totalAmount: {
    type: Number,
    required: true,
  },
  address: {
    type: String,
    required: true,
  },
  userId : {
    type: String,
    required: true,
  },
  orderedAt: {
    type: Number, 
    required: true,
  },
  status:{
    type: Number,
    default: 0,
  }
});

const Order = mongoose.model("Order", orderSchema);
module.exports = Order;
