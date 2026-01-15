const express = require('express');

const app = express();
const port=8080
app.set('view engine', 'ejs');
const BACKEND_URL = process.env.BACKEND_URL || 'http://localhost:8000'

app.use(express.urlencoded({ extended: true }));
app.use(express.json());

app.listen(port,'0.0.0.0', () => {
  console.log(`Server is running on http://0.0.0.0:${port}`);
})

app.get('/', (req, res) => {
  res.render("index")
})


app.post("/registerUser", async (req, res) => {
  try {
    
    const response = await fetch(`${BACKEND_URL}/registerUser`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify(req.body)
    });
    

    
    res.send(await response.text())
  } catch (err) {
    res.status(500).json({ error: 'Backend error' });
  }
})


app.get("/view", async (req, res) => {
  try {
      console.log("Fetching users from backend...");
     const response = await fetch(`${BACKEND_URL}/view`) 
      const data = await response.json();
      
      res.send(data);


     }catch(err){
      res.status(500).json({ error: 'Backend error' });
     }
    })
