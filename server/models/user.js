const mongoose = require("mongoose");

// Schema = Structure of the application or the user model
// This is just the structure of how the user is going to look and not the model of the user
const userSchema = mongoose.Schema({
  name: {
    required: true,
    type: String,
    trim: true,
  },
  email: {
    required: true,
    type: String,
    trim: true,
    validate: {
      // val is the returned out of the callback function
      validator: (val) => {
        const re =
        /^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i;
        return val.match(re);
      },
      message: "Please enter valid email address",
    },
  },
  password: {
    required: true,
    type: String,
  },
  address: {
    type: String,
    defualt: "",
  },
  type: {
    type: String,
    defualt: "user",
  },
});

// The model of the user

const User = mongoose.model("User", userSchema);
module.exports = User;
