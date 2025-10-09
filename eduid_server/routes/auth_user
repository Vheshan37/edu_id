const { generateAccessToken, generateRefreshToken } = require('../infrastructure/authorization/jwt_helper');
const { pool } = require('../infrastructure/db');
const router = require('express').Router();

router.post('/login', (req, res) => {
    const { email, password } = req.body;

    pool.query(
        `SELECT 
            json_build_object(
                'id', users.id,
                'name', users.name,
                'email', users.email,
                'role', json_build_object(
                    'id', user_role.id,
                    'role', user_role.role
                )
            ) AS user
        FROM users 
        JOIN user_role ON user_role.id=users.user_role 
        WHERE email = $1 AND password = $2`
        , [email, password], (err, dbres) => {
            // Handle database errors
            if (err) {
                console.error('Error executing query', err.stack);
                return res.status(500).json({ message: 'Internal server error' });
            }

            // Check if user exists
            if (dbres.rowCount === 0) {
                return res.status(401).json({ message: 'Authentication failed' });
            }

            const user = dbres.rows[0].user;

            const token = generateAccessToken(user);
            const refreshToken = generateRefreshToken(user);
            
            // Authentication successful
            return res.status(200).json({
                message: 'Authentication successful',
                user,
                token,
                refreshToken
            });
        });
});

module.exports = router;