const Joi = require('@hapi/joi');

const registerValidation = (requestBody) => {

    const  registerSchema = {
        name: Joi.string().min(6).required().max(255),
        email: Joi.string().min(6).required().max(255).email(),
        password: Joi.string().min(6).required().max(1024),
    };

    return Joi.validate(requestBody,registerSchema);

};

const loginValidation = (requestBody) => {

    const  loginSchema = {
        email: Joi.string().min(6).required().max(255).email(),
        password: Joi.string().min(6).required().max(1024),
    };

    return Joi.validate(requestBody,loginSchema);

};


module.exports.registerValidation = registerValidation;
module.exports.loginValidation = loginValidation;