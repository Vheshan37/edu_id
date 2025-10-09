const jwt = require("jsonwebtoken");

function generateAccessToken(user) {
    return jwt.sign(
        { id: user.id, email: user.email },
        process.env.JWT_SECRET,
        { expiresIn: "1h" }
    );
}

function generateRefreshToken(user) {
    return jwt.sign(
        { id: user.id, email: user.email },
        process.env.JWT_REFRESH_SECRET,
        { expiresIn: "2w" }
    );
}

module.exports = {
    generateAccessToken,
    generateRefreshToken
};