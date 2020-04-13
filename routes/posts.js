const express = require('express');
const router = express.Router();
const Post = require('../models/Post');

router.get('/', (req,res) => {
    res.send('selam /posts')
});

router.post('/',(req,res) => {
    const post = new Post({
        title: req.body.title,
        description: req.body.description
    });
    post.save()
    .then(data =>{
        res.json(data);
    });
});



module.exports = router;