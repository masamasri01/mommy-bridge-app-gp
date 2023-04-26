const router = require('express').Router();
const userController = require("../controller/user_controller");

router.post('/registeration',userController.register);
router.post('/login',userController.login);

module.exports = router; 