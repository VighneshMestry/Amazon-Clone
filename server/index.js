const express = require('express');

const app = express();
const PORT = 3000;

//CREATING AN API
// GET, PUT, POST, DELETE, UPDATE -> CRUD
app.listen(PORT, "0.0.0.0", () => {
    console.log(`Connected server at ${PORT}`);
})