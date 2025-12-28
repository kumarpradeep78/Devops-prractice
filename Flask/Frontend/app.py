from flask import Flask , render_template , request
from datetime import date
import requests

backend="http://127.0.0.1:5000"





app = Flask(__name__)

@app.route('/')
def home():
    return  render_template('index.html')

@app.route('/todoform')
def todoform():
    
    return  render_template('todo.html')

@app.route('/todo', methods=['POST'])
def todo():
   
    data=dict(request.form)
    print(data)
    requests.post(f"{backend}/todo", json=data) 
    print( "TODO submitted successfully!")
    return  "TODO submitted successfully!"


@app.route('/form', methods=['POST'])
def submit():
    data=dict(request.form)
    requests.post(f"{backend}/form", json=data) 
    return  "Form submitted successfully!"


@app.route('/api')
def view():
    response=requests.get(f"{backend}/view")
    response= response.json()
    
    return response
if __name__ == "__main__":
    app.run(port=8080, debug=True)
