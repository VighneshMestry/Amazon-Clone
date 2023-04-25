const mongoose = require("mongoose");

// Schema = Structure of the application or the user model
// This is just the structure of how the user is going to look and not the model of the user
const productSchema = mongoose.Schema({
  name: {
    required: true,
    type: String,
    trim: true,
  },
  description: {
    required: true,
    type: String,
    trim: true,
  },
  images: [
    {
      required: true,
      type: String,
    },
  ],
  quantity: {
    type: Number,
    required: true,
  },
  price: {
    type: Number,
    required: true,
  },
  category: {
    type: Number,
    required: true,
  },
});

const Product = mongoose.model("Product", productSchema);
module.exports = Product;
