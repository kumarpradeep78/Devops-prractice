from flask import Flask , request


from addData import updateFile
from getData import getData


app = Flask(__name__)

@app.route('/')
def index():
    return "Backend is running"


@app.route('/registerUser', methods=['POST'])
def form():
    print(request.json)
    data= request.get_json(force=True)
    print(data)
    updateFile(str(data))
    return "Form submitted successfully!"


        

@app.route('/view')
def view():
    data=getData()
    return {'data':data}



if __name__ == "__main__":
    app.run(port=8000,host="0.0.0.0",debug=True)
