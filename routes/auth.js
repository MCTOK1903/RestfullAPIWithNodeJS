const router = require('express').Router();
const User = require('../models/User');
const {registerValidation, loginValidation} = require('../validation/validation.js');
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');

var sess;

router.post('/register', async (req,res) => {
    //validation
    const {error} = registerValidation(req.body);
    if(error) return res.status(400).send(error.details[0].message);

    //checking if the email already exixt in the db
    const emailExist = await User.findOne({
        email: req.body.email
    });
    if(emailExist) return res.status(400).send('Email already exist!');

    //hash the pass
    const salt = await bcrypt.genSalt(10);
    const hashPass = await bcrypt.hash(req.body.password,salt);

    //create new user 
    const user = new User({
        name: req.body.name,
        email: req.body.email,
        password: hashPass
    });

    try {
        const savedUser = await user.save();
        res.send(savedUser);
    } catch (error) {
        res.status(400).send(error);
    }
    

});

router.post('/login', async (req,res) =>{

    //login validation
    const {error} = loginValidation(req.body);
    if (error) return res.status(400).send(error.details[0].message);

    //checking if the email exist
    const user = await User.findOne({
        email:req.body.email
    });
    if(!user) return res.status(400).send('invalid Email');
    //checking pash is correct
    const validPass = await bcrypt.compare(req.body.password,user.password)
    if(!validPass) return res.status(400).send('password is not match');

    sess = req.session;
    sess.email = req.body.email;
    console.log(sess);
    //create and assing a token
    const token = jwt.sign({_id:user._id},process.env.SECRET_TOKEN);
    res.header('auth-token',token).send(token);

    
});

router.post('/logout', async (req,res) => {
   req.session.destroy((err)=> {
        if(err) return res.send('error');
   });
   console.log(req.session);
});



module.exports = router;