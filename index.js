const express=require("express");
const app = express();
const {open}=require("sqlite")
const Sqlite3=require("sqlite3")
const path=require("path");


const dbPath=path.join(__dirname,"data.db")

let db=null

const initializeDBAndServer=async()=>{
    try{
        db=await open({
        filename: dbPath,
        driver: Sqlite3.Database,
        })

app.listen(4000,()=>{
    console.log("server is running at http://localhost:4000")
})

    }
    catch(e){
        console.log(`DB error ${e.message}`);
        process.exit(1)
    }
}


app.get("/students/",async(resuest,response)=>{
    const query=`SELECT * FROM Students NATURAL JOIN Users ON Students.user_id = Users.id`;
const userData=await db.get(query)
response.send(userData)
})

//api2
app.get("/users/", async(request,response)=>{
   
    const user_query=`SELECT * FROM Users`;

    const data=await db.all(user_query);
    console.log(data)
    response.send(data);
})

app.get("students/:collegeId/",async(request,response)=>{
    const {collegeId}=request.params;
    const query=`SELECT * FROM Students JOIN Users ON Students.user_id = Users.id
    WHERE Users.college_id = ${collegeId}`;
const data=await db.get(query)
response.send(data)
})


app.post("/students",async(request,response)=>{
    const {username,password,role,college_id,section}=request.body
const query = `INSERT INTO Users (username, password, role, college_id, section)
VALUES (${username},${password},${role},${college_id},${section});`;

const response=await db.run(query)
response.send("row inserted");
});

app.put("/students/:id",async(request,response)=>{
    const {id}=request.params
    const query=`UPDATE Users SET username = :username, role = :role, college_id = :college_id, section = :section
    WHERE id = ${id}`

    const response=await db.run(query)
    response.send("row updated");
})


app.delete("/studnets/:id",async(request,response)=>{
    const {id}=request.params
    const query=`DELETE FROM Students WHERE user_id=${id}`;
    
    const response=await db.run(query)
    response.send("row deleted");
})

initializeDBAndServer()