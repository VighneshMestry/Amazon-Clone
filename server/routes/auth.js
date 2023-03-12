const express = require("express");
const User = require("../models/user");
const bcryptjs = require("bcryptjs");
const jwt = require("jsonwebtoken");

const authRouter = express.Router();

// authRouter.get("/user", (req, res) => {
//   res.json({ msg: "Vighnesh" });
// });

//API
// SIGN UP ROUTE
authRouter.post("/api/signup", async (req, res) => {
  try {
    // Example - signup

    // get the data from client
    const { name, email, password } = req.body;

    const exisitingUser = await User.findOne({ email });

    if (exisitingUser) {
      return res
        .status(400)
        .json({ msg: "User with same email already exists!" });
    }

    const hashedPassword = await bcryptjs.hash(password, 8);

    let user = User({
      email,
      password: hashedPassword,
      name,
    });

    user = await user.save();
    res.json(user);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }

  // post that data in the database
  // return that data to the user
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
