const express = require('express');
const app = express();
const port = 3000;

// routes
const auth_userRouter = require('./routes/auth_user');
const { pool } = require('./infrastructure/db');

// Middleware to parse JSON bodies
app.use(express.json());

app.use('/auth_user', auth_userRouter);

app.get('/', (req, res) => {
    pool.query(`
        SELECT json_build_object(
            'id', users.id,
            'name', users.name,
            'email', users.email,
            'role', json_build_object(
                'id', user_role.id,
                'role', user_role.role
            )
        ) AS user_data
        FROM users
        JOIN user_role ON user_role.id = users.user_role;
        `, (err, dbres) => {
        if (err) {
            console.error('Error executing query', err.stack);
            res.json({
                message: 'Error executing query',
                error: err.stack
            });
        } else {
            if (dbres.rowCount > 0) {
                console.log('Query result:', dbres.rows);
                res.json({
                    message: 'Query executed successfully',
                    data: dbres.rows
                });
            } else {
                console.log('No users found');
                res.json({
                    message: 'No users found'
                });
            }
        }
    });
});

app.use((req, res, next) => {
    res.status(404).json({
        message: 'Route not found',
        path: req.method + ' ' + req.originalUrl
    });
});

// Start the server
app.listen(port, () => {
    console.log(`Server is running at http://localhost:${port}`);
});