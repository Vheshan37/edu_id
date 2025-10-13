const express = require("express");
const router = express.Router();
const jwt = require("jsonwebtoken");
const { generateAccessToken, generateRefreshToken } = require("../infrastructure/authorization/jwt_helper");

router.post("/refresh_token", (req, res) => {
    const { accessToken, refreshToken } = req.body;

    if (!accessToken && !refreshToken) {
        return res.status(400).json({ message: "Access token and refresh token are required", state: "missing_tokens" });
    }

    jwt.verify(refreshToken, process.env.JWT_REFRESH_SECRET, (err, decodedRefresh) => {
        if (err) {
            console.log('Refresh token error: ' + err);
            return res.status(401).json({ message: "Refresh token expired or invalid", state: "invalid_refresh_token" });
        }

        jwt.verify(accessToken, process.env.JWT_SECRET, (err, decodedAccess) => {
            if (!err) {
                return res.status(400).json({ message: "Access token is still valid", state: "valid" });
            }

            console.log('Access token error: ' + err);
            
            if (err.name !== "TokenExpiredError") {
                return res.status(403).json({ message: "Invalid access token", state: "invalid_access_token" });
            }

            console.log("Access token expired, issuing new token...");
            

            const newAccessToken = generateAccessToken({
                id: decodedRefresh.id,
                email: decodedRefresh.email
            });

            const newRefreshToken = generateRefreshToken({
                id: decodedRefresh.id,
                email: decodedRefresh.email
            });

            return res.status(200).json({
                message: "Access token refreshed successfully",
                state: "refreshed",
                accessToken: newAccessToken,
                refreshToken: newRefreshToken
            });
        });
    });
});

module.exports = router;