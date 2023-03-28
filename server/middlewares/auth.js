const jwt = require("jsonwebtoken");
// Keeps the track whether the user is authorised or not

// The middleware everytime validates the user and 

const auth = (req, res, next) => {
    try{
        const token = req.header('x-auth-token');
        if(!token) return res.status(401).json({msg: 'No auth token, Access denied'});

        const isVerified = jwt.verify(token, 'passwordKey');
        if(!isVerified) return res.status(401).json({error: "Token verificatino failed, Access denied"});

        //By adding req.user now we can access user anywhere we want using the response form the apis just like req.header.
        // New object has been added to the request.
        // The id is stored in the req.user

        req.user = isVerified.id;
        // req.token is also added as the object in the req
        req.token = token;
        next();  // Next callback function is called
        // if next() not specified then it wont go to the next api route/ next callback function
    } catch (err) {
        res.status(500).json({error : err.message});
    }
}

module.exports = auth;