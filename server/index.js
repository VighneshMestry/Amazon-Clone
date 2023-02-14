//IMPORT FROM PACKAGES
const express = require("express");

// const authRouter = express.Router;    -- Stores only the address of the Router in the auhtRouter
// const authRouter = express.Router();  -- Stores funcitonality of router in the authRouter and allows us to use that functionality of the Router.

// IMPORT FROM OTHER FILES
const authRouter = require("./routes/auth");

//INIT
//If we initialize this express (which we did) then we also have to listen it
const app = express();
const PORT = 3000;

//CREATING AN API
// http://<youripaddress>/hello-world

// app.get("/hello-world", (req, res) => {
//   res.json({hi : "Hello World"});
// });

// GET, PUT, POST, DELETE, UPDATE -> CRUD
app.listen(PORT, () => {
  console.log(`Connected server at ${PORT}`);
});
