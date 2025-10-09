const jwt = require("jsonwebtoken");

function generateAccessToken(user) {
    return jwt.sign(
        { id: user.id, email: user.email },
        process.env.JWT_SECRET,
        { expiresIn: "1h" } // short lifetime
    );
}

function generateRefreshToken(user) {
    return jwt.sign(
        { id: user.id },
        process.env.JWT_REFRESH_SECRET,
        { expiresIn: "4w" } // long lifetime
    );
}

module.exports = {
    generateAccessToken,
    generateRefreshToken
};