const express = require("express");

const authRouter = express.Router();

// authRouter.get("/user", (req, res) => {
//   res.json({ msg: "Vighnesh" });
// });

authRouter.post("/api/signup", (req, res) => {

  // Example - signup
  
  // get the data from client
  const {name, email, password} = req.body;
  // post that data in the database
  // return that data to the user
});

module.exports = authRouter;
