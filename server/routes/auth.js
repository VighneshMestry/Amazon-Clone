const express = require("express");
const User = require("../models/user");
const bcryptjs = require("bcryptjs");
const authRouter = express.Router();
const jwt = require("jsonwebtoken");
// const auth = require("../middlewares/auth");

// authRouter.get("/user", (req, res) => {
//   res.json({ msg: "Vighnesh" });
// });

//API
// SIGN UP ROUTE
authRouter.post("/api/signup", async (req, res) => {
  try {
    const { name, email, password } = req.body;

    const existingUser = await User.findOne({ email });
    if (existingUser) {
      return res
        .status(400)
        .json({ msg: "User with same email already exists!" });
    }

    const hashedPassword = await bcryptjs.hash(password, 8);

    let user = new User({
      email,
      password: hashedPassword,
      name,
    });
    user = await user.save();
    res.json(user);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

//API
//SignIn route
authRouter.post("/api/signin", async (req, res) => {
  try {
    const { email, password } = req.body;

    const user = await User.findOne({ email });
    if (!user) {
      return res
        .status(400)
        .json({ msg: "User with this email does not exist!" });
    }

    const isMatch = await bcryptjs.compare(password, user.password);
    if (!isMatch) {
      return res.status(400).json({ msg: "Incorrect password." });
    }

    //This helps to verify whether the user is really the one who he claims to be
    const token = jwt.sign({ id: user._id }, "passwordKey");
    res.json({ token, ...user._doc });
    // ...user helps us to access each property('token', 'name', 'email') of the json individually
    // {
    //   'token' : 'SomeOutput',
    //   'name' : 'Vighnesh',
    //   'email' : 'mestryvighnesh27@gmail.com',
    // }
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});



  
module.exports = authRouter;
