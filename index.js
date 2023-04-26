const app = require('./app');
const db = require ('./BackEnd/config/db');
const UserModel =require('./BackEnd/model/user_model')

const port = 3000;

app.get('/',(req,res)=>{
    res.send("Hello world")
});

app.listen(port,()=>{
    console.log(`Server Listening on port http://localhost:${port}`);});
