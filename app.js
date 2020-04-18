const express  = require('express');
const app = express();
const mongoose = require('mongoose');
const bodyParser = require('body-parser');
const cors = require('cors');
require('dotenv/config');

app.use(cors());
app.use(bodyParser.json());

// import route
const postsRoute = require('./routes/posts');
const authRoute = require('./routes/auth');

app.use('/posts', postsRoute);
app.use('/auth', authRoute);

//routes
app.get('/',(req,res) => {
    res.send("hi")
});

//connect to DB
mongoose.connect(process.env.DB_CONNECTION,
    {useNewUrlParser: true},() => {
    console.log('connected to DB');
});


//listening to the server
app.listen(3000); 