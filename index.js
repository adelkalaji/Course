const express = require("express");
const mysql = require("mysql");
const bodyParser = require("body-parser");
const multer  = require('multer');
const cors=require('cors');
var cookieParser = require('cookie-parser');
const app = express();

const allowedIPs = ['http://localhost:3001', 'http://localhost:3002']; 
app.use(cors({
  origin: function (origin, callback) {
    if (!origin || allowedIPs.includes(origin)) {
      callback(null, true);
    } else {
      callback(new Error('Not allowed by CORS'));
    }
  },
  exposedHeaders: ['Content-Range', 'X-Total-Count'],
  allowedHeaders: ['Content-Type', 'Authorization', 'Access-Control-Expose-Headers'],
}));
app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());
app.use(cookieParser());

const connection = mysql.createConnection({
  host: "localhost",
  user: "root",
  password: "",
  database: "train_db",
});

connection.connect();

const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, 'uploads/');
  },
  filename: (req, file, cb) => {
    cb(null, file.originalname);
  }
});

const upload = multer({ storage:storage });

app.use('/uploads', express.static('uploads'));
// Add the IP addresses you want to allow here

// Custom CORS configuration to allow requests from specific IP addresses


//////FOR USER TABLE //////////

// Get all records from the user table
app.get("/user", (req, res) => {
  connection.query(`SELECT User_id as id, User_name,
  User_pass, User_Role FROM user`, (error, results) => {
    if (error) throw error;
    else{
      res.set('X-Total-Count',2);
      res.send(results);
    }
  });
});
// Get information from the user table for login
app.post("/userlogin", (req, res) => {
  const { User_name, User_pass } = req.body;


  connection.query(
    `SELECT * FROM USER WHERE user_name = ? AND user_pass = ?`,
    [User_name.toLowerCase(), User_pass],
    (error, results) => {
      if (error) {
        res.status(500).send("An error occurred while querying the database.");
        throw error;
      } else {
        if (results.length > 0) {
          const userRole = results[0].user_role;
          const userId = results[0].user_id;

          
          if (userRole === 1) {
            // Query to check teacher_status if user is a teacher
            connection.query(
              `SELECT teacher_status FROM TEACHER WHERE user_id = ?`,
              [results[0].user_id],
              (error, teacherResults) => {
                if (error) {
                  res.status(500).send("An error occurred while querying the teacher status.");
                  throw error;
                } else {
                  console.log(teacherResults)
                  if (teacherResults.length > 0) {
                    const teacherStatus = teacherResults[0].teacher_status;
                    if (teacherStatus === 1) {
                      
                      res.json({message:"الدخول متاح. أستاذ",userRole,userId});
                     
                    } else if(teacherStatus==0) {
                      console.log("تاكد من كلمة المرور واسم المستخدم")
                      res.json({message:"الدخول غير متاح. حالة الأستاذ غير مفعلة"});
                    }
                  } else {
                   
                    res.json({message:"تاكد من كلمة المرور واسم المستخدم"});
                  }
                }
              }
            );
          } else if (userRole === 0) {
            console.log("student");
            res.json({message:"الدخول متاح. طالب",userRole,userId});
           
          } 
        } else {
          res.json({message:"تاكد من كلمة المرور واسم المستخدم"});
        }
      }
    }
  );
});
// Get information from the user table for login
app.post("/usersignup", (req, res) => {
  
  const {User_name,User_pass,User_Role,User_email,User_mobile,Speciality,User_desc,User_link}=req.body;
  let newId=0;
  console.log(req.body)
  
  connection.query(`SELECT * FROM USER
  WHERE user_name=?`,
  [User_name.toLowerCase()],
  (error, results) => {
    if (error){
      res.json({message:"Error In Server"});
      throw error;
     
    }
    else{
      if(results.length>0){
        res.json({message:"هنالك حساب سابق بهذا الاسم الرجاء تغييره"})
         
        
      }
      
      else{
        //////////////ادراج المسخدم في جدول USER/////////////
        connection.query(`INSERT INTO user ( user_name, user_pass, user_role) 
        VALUES ( ?,?, ?);`,
     [User_name.toLowerCase(),User_pass,User_Role],
     (error, results) => {
     if (error){
      res.json({message:"Error In Server"});
      throw error;
     
    }
     else{
      console.log(results.insertId);
      newId=results.insertId;
    
      if(User_Role==0){
        ///اذ كان المستخدم طالب///
                connection.query(`INSERT INTO student( student_name,student_email,user_id)
                   VALUES ( ?, ?, ?)`,
                [User_name.toLowerCase(),User_email,newId],
                (error, results) => {
                if (error) {
                  res.json({message:"Error In Server"});
                  throw error;
                 
                }
                else{

                res.set('X-Total-Count',2);
                res.json({message:"تم التسجيل بنجاح"});
                

                }
                });
      }
    if(User_Role==1){

                ///اذ كان المستخدم أستاذ///
                connection.query(`INSERT INTO teacher ( teacher_name, teacher_email, teacher_mob , teacher_desc, speciality_id, user_id, teacher_whatsapp)
                 VALUES ( ?, ?, ?, ?, ?, ?, ?);`,
             [User_name.toLowerCase(),User_email,User_mobile,User_desc,Speciality,newId,User_link],
             (error, results) => {
             if (error) throw res.json({message:"Error In Server"});
             else{

             res.set('X-Total-Count',2);
             res.json({message:"تم التسجيل بنجاح"});
              console.log("Done teacher")

             }
             });

    }

     }
     });




        
        
        
      }
    }
  });
});

// Get a specific record by ID
app.get("/user/:id", (req, res) => {

  connection.query(
    "SELECT User_id as id , User_name ,User_role FROM user WHERE User_id = ?",
    [req.params.id],
    (error, results) => {
      if (error) throw error;
      res.send(results[0]);
    }
  );
});

// Insert a new record into the user table
app.post("/user", (req, res) => {
  console.log(req.body);
  const { User_name, User_pass, User_Role } = req.body;
  connection.query(
    "INSERT INTO user (user_id,User_name, User_pass, User_Role) VALUES (null,?, ?, ?)",
    [User_name, User_pass, User_Role],
    (error, results) => {
      if (error) throw error;
      console.log(results.insertId)
      res.json({id:results.insertId})
    }
  );
});

// Update a record in the user tables
app.put("/user/:id", (req, res) => {
  const { User_name, User_pass, User_Role } = req.body;
  connection.query(
    "UPDATE user SET User_name = ?, User_pass = ?, User_Role = ? WHERE User_id = ?",
    [User_name, User_pass, User_Role, req.params.id],
    (error, results) => {
      if (error) throw error;
      res.send("Record updated successfully");
    }
  );
});

// Delete a record from the user table
app.delete("/user/:id", (req, res) => {
  connection.query(
    "DELETE FROM user WHERE User_id = ?",
    [req.params.id],
    (error, results) => {
      if (error) throw res.status(402).json("Connot delete This User");
      res.send("Record deleted successfully");
    }
  );
});

/***************************/
///////FOR QUS TABLE////////

// Get all questions
app.get("/qus", (req, res) => {
  connection.query("SELECT qus_id as id , question ,qus_date, user_id FROM qus ", (error, results) => {
    if (error) throw error;
    else{
      res.set('X-Total-Count',2);
      res.send(results);
    }
    
  });
});

// Get a specific question by ID
app.get("/qus/:id", (req, res) => {
  connection.query(
    `SELECT qus.*,student.student_name,student.student_email,student.student_image
    FROM qus,student
    WHERE student.user_id=qus.user_id
    and qus_id = ?`,
    [req.params.id],
    (error, results) => {
      if (error) throw error;
      res.send(results);
    }
  );
});


// Create a new question
app.post("/qus", (req, res) => {
  const { question, user_id } = req.body;
  connection.query(
    "INSERT INTO qus (question, user_id) VALUES (?, ?)",
    [question, user_id],
    (error, result) => {
      if (error) {
        res.json({message:"Error in Server"})
        throw error;
      };
      res.json({ message: "question added successfully" });
    }
  );
});

// Update a question by ID
app.put("/qus/:id", (req, res) => {
  const { question } = req.body;
  connection.query(
    "UPDATE qus SET question = ? WHERE qus_id = ?",
    [question,  req.params.id],
    (error, result) => {
      if (error){
        res.json({ message:"Error in Server" });
        throw error
      } ;
      res.json({ message: "Question updated successfully" });
    }
  );
});

// Delete a question by ID
app.delete("/qus/:id", (req, res) => {


  connection.query(
    "DELETE FROM answer WHERE qus_id = ?",
    [req.params.id],
    (error, result) => {
      if (error){
     
        throw error;
      }else{
        connection.query(
          "DELETE FROM qus WHERE qus_id = ?",
          [req.params.id],
          (error, result) => {
            if (error) {
             
              throw error;
            }
            res.set('X-Total-Count',2);
            res.json({ message: "تم حذف السؤال بنجاح" });
      
          }
        );
      }
   
    }
  );

 
});

/***************************/
////FOR ANSWER TABLE/////

// Get all answers
app.get("/answer/", (req, res) => {
  connection.query(
   ` SELECT ans_id as id, answer, qus_id, user_id FROM answer`,
    [req.params.qus_id],
    (error, results) => {
      if (error) throw error;
      else{
      res.set('X-Total-Count',2);
      res.send(results);
    }}
  );
});

// Get all answers for a specific question
app.get("/answer/qus/:qus_id", (req, res) => {
  connection.query(
    "SELECT * FROM answer WHERE qus_id = ?",
    [req.params.qus_id],
    (error, results) => {
      if (error) throw error;
      res.send(results);
    }
  );
});

// Get a specific answer by ID
app.get("/answer/ans/:ans_id", (req, res) => {
  connection.query(
    "SELECT * FROM answer WHERE ans_id = ?",
    [req.params.ans_id],
    (error, results) => {
      if (error) throw error;
      res.send(results[0]);
    }
  );
});

// Create a new answer
app.post("/answer", (req, res) => {
  console.log(req.body)
  const { answer, User_id ,qus_id} = req.body;
  console.log(req.body);
  connection.query(
    `INSERT INTO answer (answer, user_id,qus_id) VALUES (?, ?,?)`,
    [answer, User_id,qus_id],
    (error, result) => {
      if (error) {
        res.json({message:"Error in Server"})
        throw error;
      };
      res.json({id:result.insertId,message:"answer insert successfuly"});
     
    }
  );
});

// Create a new answer
app.post("/newanswer", (req, res) => {
  const { answer, user_id ,qus_id} = req.body;
  console.log(req.body);
  connection.query(
    `INSERT INTO answer (answer.answer, user_id,qus_id) VALUES (?, ?,?)`,
    [answer, user_id,qus_id],
    (error, result) => {
      if (error) throw error;
     
    }
  );
  res.status(201).send("wefewfewfewfew");
});

// Update an answer by ID
app.put("/answer/:ans_id", (req, res) => {

  const { answer} = req.body;

  connection.query(
    `UPDATE answer SET answer = ?
     WHERE ans_id = ?`,
    [answer, req.params.ans_id],
    (error, result) => {
      if (error){
        console.log("errro")
        res.json({message:"Error in Server"});
        throw error
      }
     
      if(result.changedRows!=0){
        res.json({message:"Answer updated successfully"});
      }
      else{
        res.json({message:"Error in Server"})
      }
      
    }
  );
});

// Delete an answer by ID
app.delete("/answer/:ans_id", (req, res) => {
  connection.query(
    "DELETE FROM answer WHERE ans_id = ?",
    [req.params.ans_id],
    (error, result) => {
      if (error) {
        console.log("errro")
        res.json({message:"Error in Server"});
        throw error
      }
      res.json({message:"تم حذف الجواب بنجاح"});
      console.log("Done")
     
    }
  );
});

/***************************/
/////For Teacher Table///////
// Get a specific teacher by Teacher_id
app.get("/teacher/:teacher_id", (req, res) => {
  console.log("1111111")

  connection.query(
    `SELECT  Teacher_id as id , Teacher_name, Teacher_email, Teacher_mob, Teacher_image,
    Teacher_status, Teacher_desc, speciality_id, Teacher_join,teacher_status, User_id
    FROM teacher
    WHERE
    Teacher_id = ?`,
    [req.params.teacher_id],
    (error, results) => {
      if (error) {
        res.status(500).json({ error: error });
      } else {
        res.json(results[0]);
      }
    }
  );
});

// Get all teachers
app.get("/teacher", (req, res) => {
  console.log("2222222")
  connection.query("SELECT  Teacher_id as id , Teacher_name, Teacher_email, Teacher_mob, Teacher_image,Teacher_status, Teacher_desc, speciality_id, Teacher_join, User_id FROM teacher", (error, results) => {
    if (error) throw error;
    else{
      
        res.set('X-Total-Count',2)
        res.json(results);
        
        }
  });
});

// Get a specific teacher by USER_ID
app.get("/teacher-info/:user_id", (req, res) => {
 
  connection.query(
    `SELECT  user.User_id as Id, teacher.*,speciality.*,user.*
    FROM teacher,speciality,user
    WHERE teacher.speciality_id=speciality.speciality_id
    and teacher.user_id=user.user_id
    and user.user_id = ?`,
    [req.params.user_id],
    (error, results) => {
      if (error) {
        res.status(500).json({ error: error });
      } else {
        res.json(results);
      }
    }
  );
});


// Create a new teacher
app.post("/teacher", (req, res) => {
  console.log(req.body)
  const {
    Teacher_name,
    Teacher_email,
    Teacher_mob,
    Teacher_image,
    Teacher_desc,
    User_id,
    speciality_id,
  } = req.body;
  console.log(Teacher_image.src)
  connection.query(
    "INSERT INTO teacher (Teacher_name, Teacher_email, Teacher_mob, Teacher_image, Teacher_desc, speciality_id, User_id) VALUES (?, ?, ?, ?, ?, ?, ?)",
    [
      Teacher_name,
      Teacher_email,
      Teacher_mob,
      Teacher_image.src,
      Teacher_desc,
      User_id,
      speciality_id,
    ],
    (error, result) => {
      if (error) throw error;
      console.log(result.insertId)
      res.json({id:result.insertId});

      res.status(200).send();
    }
  );
});

// Update a teacher by ID
app.put("/teacher/:teacher_id", (req, res) => {
  console.log(req.body);
  const {
    Teacher_name,
    Teacher_email,
    Teacher_mob,
    Teacher_image,
    Teacher_status,
    Teacher_desc,
    Teacher_join,
    User_id,
    speciality_id,
  } = req.body;
  connection.query(
    `UPDATE teacher SET Teacher_name = ?, Teacher_email = ?,Teacher_status=?
     ,Teacher_mob = ?, Teacher_image = ?, Teacher_desc = ?, speciality_id = ?
     , Teacher_join = ?, User_id = ? WHERE Teacher_id = ?`,
    [
      Teacher_name,
      Teacher_email,
      Teacher_status,
      Teacher_mob,
      Teacher_image,
      Teacher_desc,
      speciality_id,
      Teacher_join,
      User_id,
      req.params.teacher_id,
    ],
    (error, result) => {
      if (error) throw error;
      res.send("Teacher updated successfully");
      console.log(result[0]);
    }
  );
});

// Delete a teacher by ID
app.delete("/teacher/:teacher_id", (req, res) => {
  connection.query(
    "DELETE FROM teacher WHERE Teacher_id = ?",
    [req.params.teacher_id],
    (error, result) => {
      if (error) throw error;
      res.send("Teacher deleted successfully");
    }
  );
});

/*************************************/
/////// FOR Speciality Table /////////

// Get all specialties
app.get("/speciality", (req, res) => {
  connection.query(`SELECT speciality_id as id, speciality_name,speciality_img FROM speciality`,(error,results)=>{
    if (error) throw error;
    else{
      
        res.set('X-Total-Count',2)
        res.json(results);
        
        }
});
});

// Create a new specialty
app.post("/speciality", (req, res) => {
  console.log(req.body)
  const { speciality_name , speciality_img} = req.body;
  connection.query("INSERT INTO speciality (speciality_name , speciality_img) VALUES (?,?)" ,
  [speciality_name,speciality_img],
  (error, result) => {
    if (error) throw error;
    res.status(200).send();
  }
)
  }
);


// Update a Specialty
app.put("/specality/:id", (req, res) => {
  const {speciality_name ,speciality_img} = req.body;
  connection.query(
    "UPDATE speciality SET speciality_name=?,speciality_img=?  WHERE speciality_id=?",
    [speciality_name,speciality_img,req.params.id],
    (error, result) => {
      if (error) throw error;
      res.status(200).send();
    }
  )
    }
  );

// Delete a Speciality by ID
app.delete("/specality/:id", (req, res) => {
  connection.query(
    "DELETE FROM speciality WHERE speciality_id = ?",
    [req.params.id],
    (error, result) => {
      if (error) throw error;
      res.status(200).send();
    }
  );
});

/*************************************/
/////// FOR student Table /////////

// Get all records from the table
app.get("/students", (req, res) => {
  connection.query("SELECT student_id as id, student_name, student_email, student_join, student_image, user_id FROM student", (error, results, fields) => {
    if (error) {
      res.status(500).json({ error: error });
    } else {
      res.set('X-Total-Count',2);
      res.json(results);
    }
  });
});

// Get a specific record by ID
app.get("/students/:id", (req, res) => {
  const id = req.params.id;
  console.log(id)
  connection.query(
    `SELECT * 
    FROM student,user
    WHERE user.user_id =student.user_id
    and user.user_id=?`,
    [id],
    (error, results, fields) => {
      if (error) {
        res.status(500).json({ error: error });
      } else {
        res.json(results);
      }
    }
  );
});

// Add a new record to the table
app.post("/students", (req, res) => {
  console.log(req.body)
  const { student_name, student_email, student_image, User_id } =
    req.body;
  connection.query(
    "INSERT INTO student (student_name, student_email, student_image, user_id) VALUES (?, ?, ?, ?)",
    [student_name, student_email, student_image.src, User_id],
    (error, results, fields) => {
      if (error) {
        res.status(500).json({ error: error });
      } else {
        res.json({ message: "Record added successfully" });
      }
    }
  );
});

// Update a record in the table
app.put("/students/:id", (req, res) => {
  const id = req.params.id;
  const { student_name, student_email, student_join, student_image, User_id } =
    req.body;
  connection.query(
    "UPDATE student SET student_name = ?, student_email = ?, student_join = ?, student_image = ?, User_id = ? WHERE student_id = ?",
    [student_name, student_email, student_join, student_image, User_id, id],
    (error, results, fields) => {
      if (error) {
        res.status(500).json({ error: error });
      } else {
        res.json({ message: "Record updated successfully" });
      }
    }
  );
});

// Delete a record from the table
app.delete("/students/:id", (req, res) => {
  const id = req.params.id;
  connection.query(
    "DELETE FROM student WHERE student_id = ?",
    [id],
    (error, results, fields) => {
      if (error) {
        res.status(500).json({ error: error });
      } else {
        res.json({ message: "Record deleted successfully" });
      }
    }
  );
});
/*************************************/
/////// FOR course Table /////////
// Get all courses
app.get('/courses', (req, res) => {
  const sql =` SELECT course_id as id,Course_id as id , Course_name , course_desc ,
  course_create_at ,  course_hours ,  course_status ,
   course_image ,speciality_id, Teacher_id FROM course `;
  connection.query(sql, (err, result) => {
    if (err) throw err;
    else{
    res.set('X-Total-Count',2);
    res.send(result);
    }
  });
});

// Get a course by ID
app.get('/courses/:id', (req, res) => {
  const sql =` SELECT * FROM course WHERE course_id=${req.params.id}`;
  connection.query(sql, (err, result) => {
    if (err) throw err;
    res.send(result[0]);
  });
});

// Create a new course
app.post('/courses', upload.single('file'), (req, res,next) => {
  console.log(req.body);
  console.log(req.file);
  const { Course_name, Course_desc, Course_hours,Course_status, Course_image,Speciality_id, Teacher_id } = req.body;
 

 ///////////////////////////////////////////////

connection.query(` SELECT * FROM course WHERE course_name='${Course_name}'
and teacher_id=${Teacher_id}`
,
 (err, result) => {
  if (err) {   res.status(500).json({ err: err });}
  console.log(result.length)
  if(result.length>0){
    res.json({message:"يوجد مادة سابقة بنفس الاسم"});
   
  }
  else{
    connection.query(`INSERT INTO course (Course_name, Course_desc, Course_hours, Course_status,Course_image,Speciality_id,Teacher_id)
    VALUES (?, ?, ?, ?,?,?,?);`
    ,[ Course_name, Course_desc, Course_hours,Course_status, Course_image,Speciality_id, Teacher_id ],
    (error, result) => {
    if (error) throw error;
    res.json({id:result.insertId ,message:"تم إضافة مادة بنجاح"});
    
                 });
  }
});


});

  //////////////////////////////////////////
  


// Update a course by ID
app.put('/courses/:id',upload.single('file'), (req, res,next) => {
  const { course_name, course_desc,  course_hours,course_status, speciality_id, Teacher_id } = req.body;
  const course_image=req.file.originalname;
  console.log(req.file);
  console.log("11111111111111111111111111");

  connection.query( ` UPDATE course SET course_name='${course_name}', course_desc='${course_desc}',
   course_hours=${course_hours},course_status='${course_status}', course_image='${course_image}',
   speciality_id='${speciality_id}', Teacher_id=${Teacher_id}
    WHERE course_id=${req.params.id}`,
     (err, result) => {
    if (err) {
      res.json({message:"Error in Server"})
    }else{
      res.json({message:"تم تعديل المادة بنجاح"});
    }
    
  });
});

// Delete a course by ID
app.delete('/courses/:id', (req, res) => {
  const sql = "DELETE FROM course WHERE course_id=${req.params.id}";
  connection.query(sql, (err, result) => {
    if (err) throw err;
    res.send('course deleted');
  });
});




/*************************************/
/////// FOR Video Table /////////

// Get all records from the video table
app.get("/video", (req, res) => {
  connection.query(`SELECT video_id as id,video_pic ,video_name,video_path,video.Course_id,course_name
  FROM video,Course
  WHERE course.course_id=video.course_id`, (error, results, fields) => {
    if (error) {
      res.status(500).json({ error: error });
    } else {
      res.set('X-Total-Count',2);
      res.json(results);
    }
  });
});

// Get a specific record by video_id
app.get("/video/:video_id", (req, res) => {
  connection.query(
    "SELECT * FROM video WHERE video_id = ?",
    [req.params.video_id],
    (error, results, fields) => {
      if (error) throw error;
      res.json(results[0]);
    }
  );
});

// Add a new record to the video table
app.post("/video", upload.fields([ { name: 'VideoImage', maxCount: 1 },
 { name: 'Videofile', maxCount: 1 } ]),
  (req, res,next) => {    
const {Video_name,Course_id}=req.body;
const  Video_pic=req.files['VideoImage'][0].originalname;
const  Video_path=req.files['Videofile'][0].originalname;
   

connection.query(`SELECT video.* 
FROM video
WHERE video_name='${Video_name}'
and course_id=${Course_id}`,
 (error, results, fields) => {
  if (error) {
    res.status(500).json({ error: error });
  } else {
    if(results.length>0){
      res.json({message:"يوجد فيديو لهذا الكورس بنفس الاسم"})
    }
    else{
      connection.query(
        "INSERT INTO video (Video_name, Video_pic, Video_path, course_id) VALUES (?, ?, ?, ?)",
        [Video_name, Video_pic, Video_path, Course_id],
        (error, results, fields) => {
          if (error) throw error;
          res.json({ message: "تم إضافة فيديو بنجاح" });
          console.log("1222222222222222")
        }
      );
    }
  }
});











});

// Update a record in the video table
app.put("/video/:video_id", (req, res) => {
  const { Video_name, Video_pic, Video_path, course_id } = req.body;
  connection.query(
    "UPDATE video SET Video_name = ?, Video_pic = ?, Video_path = ?, course_id = ? WHERE video_id = ?",
    [Video_name, Video_pic, Video_path, course_id, req.params.video_id],
    (error, results, fields) => {
      if (error) throw error;
      res.json({ message: "Record updated successfully" });
    }
  );
});

// Delete a record from the video table
app.delete("/video/:video_id", (req, res) => {
  connection.query(
    "DELETE FROM video WHERE video_id = ?",
    [req.params.video_id],
    (error, results, fields) => {
      if (error) throw error;
      res.json({ message: "Record deleted successfully" });
    }
  );
});

/*************************************/
/////////// FOR student_course_Rel Table ///////////

// Get all records from the student_course_rel table
app.get("/student_course_rel", (req, res) => {
  connection.query(
    "SELECT * FROM student_course_rel",
    (error, results, fields) => {
      if (error) throw error;
      res.json(results);
    }
  );
});

// Get a specific record by student_id
app.get("/student_course_rel/:student_id", (req, res) => {
  connection.query(
    "SELECT * FROM student_course_rel WHERE student_id = ?",
    [req.params.student_id],
    (error, results, fields) => {
      if (error) throw error;
      res.json(results[0]);
    }
  );
});

// Add a new record to the student_course_rel table
app.post("/student_course_rel", (req, res) => {
  const {
    course_id,
    student_course_join,
    student_course_evaluation,
    student_course_type,
  } = req.body;
  connection.query(
    "INSERT INTO student_course_rel (course_id, student_course_join, student_course_evaluation, student_course_type) VALUES (?, ?, ?, ?)",
    [
      course_id,
      student_course_join,
      student_course_evaluation,
      student_course_type,
    ],
    (error, results, fields) => {
      if (error) throw error;
      res.json({ message: "Record added successfully" });
    }
  );
});

// Update a record in the student_course_rel table
app.put("/student_course_rel/:student_id", (req, res) => {
  const {
    course_id,
    student_course_join,
    student_course_evaluation,
    student_course_type,
  } = req.body;
  connection.query(
    "UPDATE student_course_rel SET course_id = ?, student_course_join = ?, student_course_evaluation = ?, student_course_type = ? WHERE student_id = ?",
    [
      course_id,
      student_course_join,
      student_course_evaluation,
      student_course_type,
      req.params.student_id,
    ],
    (error, results, fields) => {
      if (error) throw error;
      res.json({ message: "Record updated successfully" });
    }
  );
});

// Delete a record from the student_course_rel table
app.delete("/student_course_rel/:student_id", (req, res) => {
  connection.query(
    "DELETE FROM student_course_rel WHERE student_id = ?",
    [req.params.student_id],
    (error, results, fields) => {
      if (error) throw error;
      res.json({ message: "Record deleted successfully" });
    }
  );
});
/***********************************/
//////// For student_Video_Rel Table ///////

// Get all records from the student_video_rel table
app.get("/student_video_rel", (req, res) => {
  connection.query(
    "SELECT * FROM student_video_rel",
    (error, results, fields) => {
      if (error) throw error;
      res.json(results);
    }
  );
});

// Get a specific record by SV_id
app.get("/student_video_rel/:SV_id", (req, res) => {
  connection.query(
    "SELECT * FROM student_video_rel WHERE SV_id = ?",
    [req.params.SV_id],
    (error, results, fields) => {
      if (error) throw error;
      res.json(results[0]);
    }
  );
});

// Add a new record to the student_video_rel table
app.post("/student_video_rel", (req, res) => {
  const { student_id, Video_id, Comment } = req.body;
  connection.query(
    "INSERT INTO student_video_rel (student_id, Video_id, Comment) VALUES (?, ?, ?)",
    [student_id, Video_id, Comment],
    (error, results, fields) => {
      if (error){ 
        res.json({message:"Error in Server"});
        throw error};
      res.json({ message: "تمت إضافة التعليق بنجاح" });
    }
  );
});

// Update a record in the student_video_rel table
app.put("/student_video_rel/:SV_id", (req, res) => {
  const { Comment } = req.body;
  connection.query(
    `UPDATE student_video_rel SET  Comment = ?
     WHERE SV_id = ?`,
    [ Comment, req.params.SV_id],
    (error, results, fields) => {
      if (error) {
        res.json({message:"Error in Server"})
        throw error;
      };
      res.json({ message: "تم تعديل التعليق بنجاح" });
      
    }
    
  );
});

// Delete a record from the student_video_rel table
app.delete("/student_video_rel/:SV_id", (req, res) => {
  connection.query(
    "DELETE FROM student_video_rel WHERE SV_id = ?",
    [req.params.SV_id],
    (error, results, fields) => {
      if (error){
        res.json({message:"Error in Server"});
        throw error;
      };
      res.json({ message: "تم حذف التعليق بنجاح" });
    }
  );
});

/***********************************/
//////// For Advertisments Table ///////
// Define routes for the RESTful API
app.get('/advertisments', (req, res) => {
  // Retrieve all advertisements from the Advertisments table
  const sql = 'SELECT img_id as id, img_path FROM advertisments ';
  connection.query(sql, (err, results) => {
    if (err) throw err;
    else{
      res.set('X-Total-Count',2);
      res.send(results);
    }
    });
});

app.get('/advertisments/:id', (req, res) => {
  // Retrieve an advertisement by ID from the Advertisments table
  const sql =` SELECT * FROM advertisments WHERE img_id = ${req.params.id}`;
  connection.query(sql, (err, result) => {
    if (err) throw err;
    res.send(result[0]);
  });
});

app.post('/advertisments', (req, res) => {
  // Insert a new advertisement into the Advertisments table
  console.log(req.body.img_path[0].src)
  const img_path = req.body.img_path[0].src;
 
  const sql =` INSERT INTO Advertisments ( img_path) VALUES ( '${img_path}')`;
  connection.query(sql, (err, result) => {
    if (err) throw err;
    res.send(result);
  });
});

app.put('/advertisments/:id', (req, res) => {
  // Update an advertisement by ID in the Advertisments table
  const {  img_path } = req.body;
  const sql = `UPDATE Advertisments SET  img_path = '${img_path}' WHERE img_id = ${req.params.id}`;
  connection.query(sql, (err, result) => {
    if (err) throw err;
    res.send(result);
  });
});

app.delete('/advertisments/:id', (req, res) => {
  // Delete an advertisement by ID from the Advertisments table
  const sql =` DELETE FROM Advertisments WHERE img_id = ${req.params.id}`;
  connection.query(sql, (err, result) => {
    if (err) throw err;
    res.send(result);
  });
});
/////// Home Page/////////

app.get("/home", (req, res) => {
  connection.query(
    `SELECT 
    speciality.speciality_id,
    speciality.speciality_name,
    speciality.speciality_img,
    COUNT(course.course_id) AS total
FROM 
    speciality
JOIN 
    teacher ON speciality.speciality_id = teacher.speciality_id
JOIN 
    course ON teacher.Teacher_id = course.Teacher_id
GROUP BY 
    speciality.speciality_id,
    speciality.speciality_name,
    speciality.speciality_img
    LIMIT 1`,
    (error, results, fields) => {
      if (error) throw error;
      res.json(results);
    }
  );
});
app.get("/home4", (req, res) => {
  connection.query(
    `SELECT 
    speciality.speciality_id,
    speciality.speciality_name,
    speciality.speciality_img,
    COUNT(course.course_id) AS total
FROM 
    speciality
JOIN 
    teacher ON speciality.speciality_id = teacher.speciality_id
JOIN 
    course ON teacher.Teacher_id = course.Teacher_id
GROUP BY 
    speciality.speciality_id,
    speciality.speciality_name,
    speciality.speciality_img
  
    LIMIT 1`,
    (error, results, fields) => {
      if (error) throw error;
      res.json(results);
    }
  );
});
app.get("/home5", (req, res) => {
  connection.query(
    `SELECT 
    speciality.speciality_id,
    speciality.speciality_name,
    speciality.speciality_img,
    COUNT(course.course_id) AS total
FROM 
    speciality
JOIN 
    teacher ON speciality.speciality_id = teacher.speciality_id
JOIN 
    course ON teacher.Teacher_id = course.Teacher_id
GROUP BY 
    speciality.speciality_id,
    speciality.speciality_name,
    speciality.speciality_img
    LIMIT 2`,
    (error, results, fields) => {
      if (error) throw error;
      res.json(results);
    }
  );
});

app.get("/home1", (req, res) => {
  connection.query(
    `SELECT 
    course.course_id,
    course.course_name,
    course.course_image,
    course.course_hours,
    teacher.teacher_name,
    IFNULL(FLOOR(AVG(student_course_rel.student_course_evaluation)), 0) AS eve,
    COUNT(*) AS total
FROM 
    course
JOIN 
    teacher ON course.teacher_id = teacher.teacher_id
JOIN 
    student_course_rel ON course.course_id = student_course_rel.course_id
GROUP BY 
    course.course_id, 
    course.course_name,
    course.course_image,
    course.course_hours,
    teacher.teacher_name
ORDER BY 
    eve DESC
LIMIT 4;`,
    (error, results, fields) => {
      if (error) throw error;
      res.json(results);
    }
  );
});



app.get("/home2", (req, res) => {
  connection.query(
    `select teacher.Teacher_id,teacher.Teacher_image,teacher.Teacher_mob,teacher.Teacher_whatsapp,teacher.Teacher_name,teacher.Teacher_email,teacher.Teacher_name,speciality.speciality_name
    FROM teacher,speciality
    WHERE teacher.speciality_id=speciality.speciality_id 
    ORDER BY RAND()
    LIMIT 4`,
    (error, results, fields) => {
      if (error) throw error;
      res.json(results);
    }
  );
});


app.get("/home3", (req, res) => {
  connection.query(
    `SELECT student.student_name,student.student_image, student_video_rel.Comment
    from student, student_video_rel
    WHERE student.student_id=student_video_rel.student_id 
    ORDER BY RAND()
    LIMIT 4`,
    (error, results, fields) => {
      if (error) throw error;
      res.json(results);
    }
  );
});
app.get("/home33", (req, res) => {
  connection.query(
    `SELECT student.student_name,student.student_image, student_video_rel.Comment
    from student, student_video_rel
    WHERE student.student_id=student_video_rel.student_id 
    ORDER BY RAND()
    LIMIT 10`,
    (error, results, fields) => {
      if (error) throw error;
      res.json(results);
    }
  );
});

///////// End Home Page //////////
/////////// Categories Page //////
app.get("/categories", (req, res) => {
  connection.query(
    `SELECT 
    s.speciality_name,
     s.speciality_img,
    COUNT(c.course_id) AS course_count
FROM 
    speciality s
LEFT JOIN 
    course c ON s.speciality_id = c.speciality_id 
GROUP BY 
    s.speciality_id, s.speciality_id, c.speciality_id;
    `,
    (error, results, fields) => {
      if (error) throw error;
      res.json(results);
    }
  );
});
///////// All Course PAge /////////
app.get("/allcourse", (req, res) => {
  connection.query(
    `SELECT 
    course.course_id,
    course.course_name,
    course.course_desc,
    course.course_status,
    course.course_hours,
    course.course_image,
    teacher.teacher_id,
    teacher.teacher_name,
    IFNULL(FLOOR(AVG(student_course_rel.student_course_evaluation)), 0) AS eve,
    COUNT(student_course_rel.student_id) AS total
FROM 
    course
LEFT JOIN 
    teacher ON course.teacher_id = teacher.teacher_id
LEFT JOIN 
    student_course_rel ON course.course_id = student_course_rel.course_id
GROUP BY 
    course.course_id,
    course.course_name,
    course.course_desc,
    course.course_status,
    course.course_hours,
    course.course_image,
    teacher.teacher_id,
    teacher.teacher_name;
`,
    (error, results, fields) => {
      if (error) throw error;
      res.json(results);
    }
  );
});
///////// Al Teachers Page //////////
app.get("/allteacher", (req, res) => {
  connection.query(`SELECT  teacher.teacher_id as id , Teacher_name, Teacher_email, Teacher_mob, Teacher_image, Teacher_desc, speciality.speciality_name,Teacher_whatsapp, Teacher_join, User_id ,COUNT(*) as total
  FROM teacher,course,speciality
  WHERE teacher.teacher_id=course.teacher_id and teacher.speciality_id=speciality.speciality_id
  GROUP BY  teacher.teacher_id, Teacher_name, Teacher_email, Teacher_mob, Teacher_image, Teacher_desc, speciality.speciality_name,Teacher_join, user_id`, (error, results) => {
    if (error) throw error;
    else{
      
        res.set('X-Total-Count',2)
        res.json(results);
        
        }
  });
});
/////Teacher And Description Page //////////

app.get("/techinfo/:teacher_id", (req, res) => {
  connection.query(
    `select teacher.*,speciality.speciality_name
    FROM teacher,speciality
    WHERE teacher.speciality_id=speciality.speciality_id
    and teacher_id=?;`,
    [req.params.teacher_id],
    (error, results) => {
      if (error) throw error;
      else{
        res.set('X-Total-Count',2);
        res.send(results);
      }
    }
  );
});
///////Specific Course BY Teacher_Id/////////
app.get("/techcorse/:teacher_id", (req, res) => {
  connection.query(
    `SELECT 
    teacher.*, 
    course.*, 
    IFNULL(FLOOR(AVG(student_course_rel.student_course_evaluation)), 0) AS eve, 
    COUNT(*) AS total
FROM 
    teacher
JOIN 
    course ON teacher.teacher_id = course.teacher_id
JOIN 
    student_course_rel ON course.course_id = student_course_rel.course_id
WHERE 
    teacher.teacher_id = ?
GROUP BY 
    course.course_name;
`,
    [req.params.teacher_id],
    (error, results) => {
      if (error) throw error;
      else{
        res.set('X-Total-Count',2);
        res.send(results);
      }
    }
  );
});
///////Specific Course BY Couers_id/////////
app.get("/courseinfo/:course_id", (req, res) => {
  connection.query(
    `SELECT course.* ,teacher.teacher_name,speciality.speciality_name
    FROM course,teacher,speciality
    WHERE  course.teacher_id=teacher.teacher_id and teacher.speciality_id=speciality.speciality_id
    and course.course_id=?
    `,
    [req.params.course_id],
    (error, results) => {
      if (error) throw error;
      else{
        res.set('X-Total-Count',2);
        res.send(results);
      }
    }
  );
});
//////Specific Videos BY Couers_id/////////
app.get("/videolist/:course_id", (req, res) => {
  connection.query(
    `SELECT video.*,course.*,teacher.*
    FROM course,video,teacher
    WHERE  course.course_id=video.course_id and teacher.teacher_id=course.teacher_id
    and course.course_id=?
    
    `,
    [req.params.course_id],
    (error, results) => {
      if (error) throw error;
      else{
        res.set('X-Total-Count',2);
        res.send(results);
      }
    }
  );
});

//////Specific Video BY Couers_id And Video_id /////////
app.get("/videoinfo/:video_id/:course_id", (req, res) => {
  connection.query(
    `select video.*,teacher.teacher_name,teacher.teacher_image,course_name
    FROM video,teacher,course
    WHERE  video_id=?
    and course.teacher_id=teacher.teacher_id
    and course.course_id=video.course_id
    and course.course_id=?
    `,
    [req.params.video_id,req.params.course_id],
    (error, results) => {
      if (error) throw error;
      else{
        
        res.set('X-Total-Count',2);
        res.send(results);
        
      }
    }
  );
});
//////Specific Video BY Couers_id And Video_id /////////
app.get("/videocomment/:video_id", (req, res) => {
  connection.query(
    `SELECT student_video_rel.* ,student.student_image,student_name,user.user_id
    FROM student_video_rel,student,user
    WHERE user.user_id=student.user_id
    and student.student_id=student_video_rel.student_id
    and  student_video_rel.video_id = ?
    order by student_video_rel.comment_date DESC
    `,
    [req.params.video_id],
    (error, results) => {
      if (error) throw error;
      else{
        res.set('X-Total-Count',2);
        res.send(results);
      }
    }
  );
});

// Add a new comment to the student_video_rel table where video_id =?
app.post("/student_video_rel/add", (req, res) => {
  const { student_id, Video_id, Comment } = req.body;
  connection.query(
    `INSERT INTO student_video_rel (student_id,Video_id, Comment) VALUES (?,?,?)`,
    [student_id, Video_id, Comment],
    (error, results, fields) => {
      if (error) throw error;
      res.json({ message: "Record added successfully" });
    }
  );
});
/// Get all qestion FROm data base with user pucture ////////
app.get("/question", (req, res) => {
  connection.query(`SELECT  qus.*,student.*,user.*
  FROM qus , student ,user
  WHERE qus.user_id=student.user_id and qus.user_id= user.user_id
  ORDER BY qus.qus_date`,
   (error, results) => {
    if (error) throw error;
    else{
      res.set('X-Total-Count',2);
      res.send(results);
    }
    
  });
});
/// Get all Answers FROm data base with user qus_id ////////
app.get("/allanswer/:qus_id", (req, res) => {
  connection.query(`SELECT answer.* ,student.student_image img,student.student_email email,user.user_role,user.user_name  AS name
  FROM student,answer,user
  WHERE student.user_id=answer.user_id
  and
  user.user_id=answer.user_id 
  and
  answer.qus_id=?
  UNION
  SELECT answer.* ,teacher.teacher_image,teacher.teacher_email email,user.user_role,user.user_name as name
  FROM teacher,answer,user
  WHERE teacher.user_id=answer.user_id
  and 
  user.user_id=answer.user_id 
  and
  answer.qus_id=?
  ORDER BY ans_date DESC`,
  [req.params.qus_id,req.params.qus_id],
     (error, results) => {
    if (error) throw error;
    else{
      res.set('X-Total-Count',2);
      res.send(results);
    }
  });
});
/// Get Favorite Courses For Student Profile ////////
app.get("/favoritecourse/:student_id", (req, res) => {
  connection.query(`SELECT course.*,student_course_rel.student_course_evaluation as eve,teacher.teacher_name,COUNT(*) total
  from course,student_course_rel,student,teacher
  WHERE student_course_rel.student_course_type=1
  and student_course_rel.course_id=course.course_id
  and course.teacher_id=teacher.teacher_id
  AND student.student_id=student_course_rel.student_id
  AND student.student_id=?
  GROUP by course.course_name,student_course_rel.student_course_evaluation`,
  [req.params.student_id],
   (error, results) => {
    if (error) throw error;
    else{
      res.set('X-Total-Count',2);
      res.send(results);
    }
    
  });
});
/// Delete Favorite Courses For Student Profile ////////
app.delete("/favoritecourse/:course_id", (req, res) => {
  console.log(req.body);
  console.log(req.params.course_id)
  const {student_id}=req.body;
  connection.query(
    `DELETE FROM student_course_rel WHERE course_id = ?
    and student_id=?
    and student_course_rel.student_course_type=1`,
    [req.params.course_id,student_id],
    (error, results, fields) => {
      if (error) {
        res.json({message:"Error in Server"});
        throw error;
      }else{
        res.json({ message: "course deleted successfully" });
      }
   
    }
  );
});
/// Update Favorite Courses For Student Profile ////////
app.put("/favoritecourse/:course_id", (req, res) => {
  console.log(req.body);
  console.log(req.params.course_id);
  const {
    student_id,
  } = req.body;
  connection.query(
    `UPDATE student_course_rel SET student_course_type = 0
    WHERE course_id=?
    And  student_id = ?`,
    [
      req.params.course_id,
      student_id
    ],
    (error, results, fields) => {
      if (error){
        res.json({message:"Error in Server"})
      };
      res.json({ message: "course updated successfully"  });
    }
  );
});
/// Get Signed Courses For Student Profile ////////
app.get("/signedcourse/:student_id", (req, res) => {
  connection.query(`SELECT course.*,student_course_evaluation as eve,teacher.teacher_name,COUNT(*) total
  FROM student_course_rel,course,teacher,student
  WHERE student_course_rel.student_id=student.student_id
  and student_course_rel.student_course_type=0
  AND student_course_rel.course_id=course.course_id
  AND course.teacher_id=teacher.teacher_id
  AND student.student_id=?
  GROUP by course.course_name,student_course_evaluation,teacher.teacher_name`,
  [req.params.student_id],
   (error, results) => {
    if (error) throw error;
    else{
      res.set('X-Total-Count',2);
      res.send(results);
    }
    
  });
});
/// Delete Signed Courses For Student Profile ////////
app.delete("/signedcourse/:course_id", (req, res) => {
  console.log(req.body);
  console.log(req.params.course_id)
  const {student_id}=req.body;
  connection.query(
    `DELETE FROM student_course_rel WHERE course_id = ?
    and student_id=?
    and student_course_rel.student_course_type=0`,
    [req.params.course_id,student_id],
    (error, results, fields) => {
      if (error) {
        res.json({message:"Error in Server"});
        throw error;
      }else{
        res.json({ message: "course deleted successfully" });
      }
   
    }
  );
});
// Get all comment student on video teacher by teacher id for teacher profile
app.get("/comment_on_video/:user_id", (req, res) => {
  connection.query(`SELECT student_video_rel.*,student.student_name,student.student_email,student.student_image,course.course_name,video.video_name
  FROM student_video_rel,course,teacher,video,student,user
  WHERE student_video_rel.video_id=video.video_id
  and student_video_rel.student_id=student.student_id
  and video.course_id=course.course_id
  AND course.teacher_id=teacher.teacher_id
  AND teacher.user_id=user.user_id
  AND user.user_id=?
  GROUP BY video.video_id
  ORDER BY student_video_rel.comment_date DESC`,
  [req.params.user_id],
    (error, results) => {
    if (error) throw error;
    else{
      
        res.set('X-Total-Count',2)
        res.json(results);
        
        }
  });
});
/////////-Update Teacher Information  for tecaher Profile-///////
app.put("/teacherupdate/:user_id",upload.single('file'), (req, res,next) => {
  console.log(req.file);
  const { teacher_name,teacher_email,teacher_mob,teacher_whatsapp,teacher_desc,teacher_image,user_pass}=req.body;
  connection.query(
    `SELECT teacher.*,speciality.*,user.*
    FROM teacher,speciality,user
    WHERE teacher.speciality_id=speciality.speciality_id
    and teacher.user_id=user.user_id
    and user.user_id = ?
    and user.user_pass=?`,
    [req.params.user_id,user_pass],
       (error, results) => {
      if (error) {
        res.status(500).json({ error: error });
      } else {
        if(results.length>0){
          
////////////////////////////////////////////////////////////////

connection.query(
  `UPDATE teacher SET Teacher_name = ?,
  Teacher_email = ?, Teacher_mob = ?,
  teacher_whatsapp = ?, teacher_desc = ?,
   teacher_image = ?
   WHERE user_id = ?;`,
  [ teacher_name, teacher_email,
    teacher_mob, teacher_whatsapp,
    teacher_desc, req.file.originalname,
    req.params.user_id],
  (error, result) => {
    if (error) throw error;
  console.log('update teacher done')
  }
);
connection.query(`UPDATE user set user_name=?
where user_id=?`,
[teacher_name,req.params.user_id],
(error, result) => {
  if (error) throw error;
  res.set('X-Total-Count',2);
  res.json({message: "Teacher update Successfuly"});
}
);
        }
        else if(results.length==0){
          console.log("baaad");
          
          res.json({message:"Password is Wrong"});
        
        }
        
      }
    }
  );
});
/////////-Update Student Information  for Student Profile-///////
app.put("/studentupdate/:user_id",upload.single('file'), (req, res,next) => {
  console.log(req.file);
 
  const { student_name,student_email,student_image,user_pass}=req.body;
  connection.query(
    `SELECT student.*,user.*
    FROM student,user
    WHERE student.user_id=user.user_id
    and user.user_id = ?
    and user.user_pass=?`,
    [req.params.user_id,user_pass],
       (error, results) => {
      if (error) {
        res.status(500).json({ error: error });
      } else {
        if(results.length>0){
         

          
////////////////////////////////////////////////////////////////

connection.query(
  `UPDATE student SET student_name = ?,
  student_email = ?, student_image = ?
   WHERE user_id = ?`,
  [ student_name, student_email,
    req.file.originalname ,
    req.params.user_id],
  (error, result) => {
    if (error) throw error;
  console.log('update student done');
  }
);
connection.query(`UPDATE user set user_name=?
where user_id=?`,
[student_name,req.params.user_id],
(error, result) => {
  if (error) throw error;
  res.set('X-Total-Count',2);
  res.json({message: "student update Successfuly"});
}
);
        }
        else if(results.length==0){
          console.log("baaad");
          
          res.json({message:"Password is Wrong"});
        
        }
        
      }
    }
  );
});
///////Get ALL Courses BY User Id for TeacherProfile/////////
app.get("/techercourse/:user_id", (req, res) => {
  connection.query(
    `SELECT teacher.*, course.*, IFNULL(FLOOR(AVG(student_course_rel.student_course_evaluation)), 0) AS eve, COUNT(*) AS total
    FROM teacher
    JOIN course ON (teacher.teacher_id = course.teacher_id)
    LEFT JOIN student_course_rel ON (course.course_id = student_course_rel.course_id)
    JOIN user ON (teacher.user_id = user.user_id)
    WHERE teacher.user_id = ?
    GROUP BY course.course_name;`,
    [req.params.user_id],
    (error, results) => {
      if (error) throw error;
      else{
        res.set('X-Total-Count',2);
        res.send(results);
      }
    }
  );
});
/// Get all qestion FROm data base By user_id ////////
app.get("/question/:user_id", (req, res) => {
  connection.query(`SELECT  qus.*,student.*,user.*
  FROM qus , student ,user
  WHERE qus.user_id=student.user_id and qus.user_id= user.user_id
  and user.user_id=?
  ORDER BY qus.qus_date desc`,
  [req.params.user_id],
   (error, results) => {
    if (error) throw error;
    else{
      res.set('X-Total-Count',2);
      res.send(results);
    }
    
  });
});
/// Get Result Search  ////////
app.post("/search", (req, res) => {
  const {word}=req.body;
  connection.query(`SELECT course.* ,teacher.teacher_name,speciality.speciality_name
  FROM course,teacher,speciality
  WHERE  course.teacher_id=teacher.teacher_id and teacher.speciality_id=speciality.speciality_id
  and course.course_name like '%${word}%'
  OR course.course_desc LIKE '%${word}%'
  GROUP BY course.course_name`,

   (error, results) => {
    if (error) throw error;
    else{
      res.set('X-Total-Count',2);
      res.send(results);
    }
    
  });
});
/// Get Coursi id And Student Id From Course_student_rel for Enrol in course or not  ////////
app.get("/course_rel_info/:course_id/:srudent_id", (req, res) => {
  
  connection.query(`select sc_id, student_id,course_id,student_course_evaluation,student_course_type
  FROM student_course_rel
  WHERE course_id=?
  and student_id=?
  GROUP BY course_id;
  `,
  [req.params.course_id,req.params.srudent_id],
   (error, results) => {
    if (error) {
      res.json({message:"Error in Server"})
      throw error
    }

    else{
      res.set('X-Total-Count',2);
      res.send(results);
    }
    
  });
});
/// Get Student Id By User Id For All Pages  ////////
app.get("/student_user_id/:user_id", (req, res) => {
  
  connection.query(`SELECT student_id,student.student_name
  FROM student,user
  WHERE user.user_id=student.user_id
  and user.user_id=?;
  `,
  [req.params.user_id],
   (error, results) => {
    if (error) {
      res.json({message:"Error in Server"})
      throw error
    }

    else{
      res.set('X-Total-Count',2);
      res.send(results);
    }
    
  });
});
/// Enroll in New Course Fore CoursInfo Page ////////
app.post("/enrollcouse", (req, res) => {
 const {course_id,student_id}=req.body;
  connection.query(`INSERT INTO student_course_rel ( student_id, course_id) VALUES (?,?);`,
  [student_id,course_id],
   (error, results) => {
    if (error) {
      res.json({message:"Error in Server"})
      throw error
    }

    else{
   
     
      res.json({message:"تم اللإشتراك بالمادة بنجاح"});
    }
    
  });
});
/// Set Course In favotite in CoursInfo Page ////////
app.put("/setfavoritcourse", (req, res) => {
  const {course_id,student_id}=req.body;
   connection.query(`UPDATE student_course_rel SET student_course_type =1 
   WHERE student_course_rel.course_id = ?
   AND student_course_rel.student_id=?;`,
   [course_id,student_id],
    (error, results) => {
     if (error) {
       res.json({message:"Error in Server"})
       throw error
     }
 
     else{
    
      
       res.json({message:"تم إضافة المادة للمفضلة بنجاح"});
     }
     
   });
 });
 /// Set Rating in Course  in CoursInfo Page ////////
app.put("/setrating", (req, res) => {
  const {rating,course_id,student_id}=req.body;
  console.log(rating)
   connection.query(`UPDATE student_course_rel SET student_course_evaluation = ? 
   WHERE student_course_rel.course_id =?
   and   student_course_rel.student_id=?`,
   [rating,course_id,student_id],
    (error, results) => {
     if (error) {
       res.json({message:"Error in Server"})
       throw error
     }
 
     else{
    
      
       res.json({message:"تم التقييم  بنجاح"});
     }
     
   });
 });
/// Get Studnet_id By user_id ////////
app.get("/studnet_id/:user_id", (req, res) => {
  connection.query(
    `SELECT student_id,student_name
    FROM student JOIN user
    on user.user_id=student.user_id
    WHERE user.user_id=?`,
    [req.params.user_id],
    (error, results) => {
      if (error) throw error;
      if (results.length > 0) {
        res.json(results[0]);
      
      } else {
        res.status(404).json({ message: "Student not found" });
      }
    }
  );
});
/////////// Listen To The Prot ////////////
const port = 3000;
app.listen(port, () => {
  console.log(`Server running on port ${port}`);
});

