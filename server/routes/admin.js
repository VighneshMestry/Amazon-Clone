const express = require("express");
const adminRouter = express.Router();
const admin = require("../middlewares/admin");
const { Product } = require("../models/product");

adminRouter.post("/admin/add-product", admin, async (req, res) =>  {
  try {
    const { name, description, images, quantity, price, category } = req.body;

    let product = new Product({
      name,
      description,
      images,
      quantity,
      price,
      category,
    });
    product = await product.save();
    res.json(product);
  } catch (e) {
    return res.status(500).json({ msg: e.message });
  }
});

// get all products
// The admin middleware makes sure that only admin can access the functionalities
adminRouter.get('/admin/get-product', admin, async (req, res) => {
  try{
    const products = await Product.find({});
    res.json(products);
  } catch (e) {
    res.status(500).json({error: e.message});
  }
});

module.exports = adminRouter;