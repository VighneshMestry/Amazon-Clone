// IMPORTS FROM PACKAGES
const express = require("express");
const mongoose = require("mongoose");
// const adminRouter = require("./routes/admin");

// IMPORTS FROM OTHER FILES
const authRouter = require("./routes/auth");
const adminRouter = require("./routes/admin");
// const productRouter = require("./routes/product");
// const userRouter = require("./routes/user");

// const authRouter = express.Router;    -- Stores only the address of the Router in the auhtRouter
// const authRouter = express.Router();  -- Stores funcitonality of router in the authRouter and allows us to use that functionality of the Router.

//INIT
//If we initialize this express (which we did) then we also have to listen it
const app = express();
const PORT = 3000;
const DB = "mongodb+srv://vighnesh:Rotomacc%4027@cluster0.kvzn2wp.mongodb.net/?retryWrites=true&w=majority";


//middleware
// CLIENT -> middleware -> SERVER -> CLIENT
app.use(express.json());
app.use(authRouter);
app.use(adminRouter);


// Connections
// here connect is a promise or future so here we should use await keyword 
// but as this query is not in an async function we use 'then' in such cases

mongoose.set('strictQuery', false);
mongoose.connect(DB).then (() => {
  console.log("Connections successful")
}).catch((e) => {console.log(e)});


// API's have following requests
// GET, PUT, POST, DELETE, UPDATE -> CRUD
// This app.listen binds itself to the host specified and listen for any other connections 
app.listen(PORT, "0.0.0.0", () => {
  console.log(`Connected server at ${PORT}`);
});



//CREATING AN API
// http://<youripaddress>/hello-world

// app.get("/hello-world", (req, res) => {
//   res.json({hi : "Hello World"});
// });
