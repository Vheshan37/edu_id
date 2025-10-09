const jwt = require("jsonwebtoken");

function authMiddleware(req, res, next) {
    const authHeader = req.headers["authorization"];
    const token = authHeader && authHeader.split(" ")[1]; // "Bearer TOKEN"

    if (!token) return res.status(401).json({ message: "No token provided" });

    jwt.verify(token, process.env.JWT_SECRET, (err, decoded) => {

        // check token expire time
        const currentTime = Math.floor(Date.now() / 1000);
        if (decoded.exp < currentTime) {
            return res.status(401).json({ message: "Token expired" });
        }

        if (err) return res.status(403).json({ message: "Invalid token" });

        req.user = decoded; // attach decoded payload
        next();
    });
}

module.exports = authMiddleware;