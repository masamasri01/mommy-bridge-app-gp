const express = require('express');
const bodyParser = require('body-parser');
const mongoose = require('mongoose');
const app = express();

// connect to MongoDB database
mongoose.connect('mongodb://127.0.0.1:27017', {
  useNewUrlParser: true,
  useUnifiedTopology: true,
});

// create user schema
const userSchema = new mongoose.Schema({
  username: String,
  email: String,
  password: String,
});

// create user model
const User = mongoose.model('User', userSchema);

// parse incoming requests
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));

// handle registration form submission
app.post('/register', async (req, res) => {
  try {
    const user = new User(req.body);
    await user.save();
    res.status(200).send('User successfully registered');
  } catch (error) {
    console.error(error);
    res.status(500).send('Error registering user');
  }
});

// start server
app.listen(3001, () => {
  console.log('Server started on port 3001');
});
