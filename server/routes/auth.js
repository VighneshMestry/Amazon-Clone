const express = require("express");
const User = require("../models/user");
const bcryptjs = require("bcryptjs");

const authRouter = express.Router();

// authRouter.get("/user", (req, res) => {
//   res.json({ msg: "Vighnesh" });
// });


// SIGN UP ROUTE
authRouter.post("/api/signup", async (req, res) => {
  try{
    // Example - signup

  // get the data from client
  const { name, email, password } = req.body;

  const exisitingUser = await User.findOne({ email });

  if (exisitingUser) {
    return res.status().json({ msg: "User with same email already exists!" });
  }

  const hashedPassword = await bcryptjs.hash(password, 8);

  let user = User({
    email,
    password: hashedPassword,
    name,
  })
  
  user = await user.save();
  res.json(user);
  } catch(e) {
    res.status(500).json({error: e.message});
  }

  // post that data in the database
  // return that data to the user
});

module.exports = authRouter;
