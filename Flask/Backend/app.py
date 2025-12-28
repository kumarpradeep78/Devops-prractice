from flask import Flask , render_template , request

from mongoengine import connect
import os
from dotenv import load_dotenv
from mongoengine.connection import get_db
from mongoengine import Document, StringField


load_dotenv()
connect(
    host=os.getenv('MONGO_URL')
)


try:
    db = get_db()
    print("MongoDB connected:", db.name)
except Exception as e:
    print(" MongoDB connection failed:", e)

class UserForm(Document):
    name = StringField(required=True)
    email = StringField(required=True)
    password = StringField( required=True)


app = Flask(__name__)


@app.route('/form', methods=['POST'])
def form():

    data=request.json
    user_form = UserForm(
         name=data.get('name'),
         email=data.get('email'),
         password=data.get('password')
                )
    user_form.save()
    return "Form submitted successfully!"

@app.route('/view')
def view():
    users = UserForm.objects()
    data=[{'name': user.name, 'email': user.email, 'password': user.password} for user in users]
    return data
if __name__ == "__main__":
    app.run(debug=True)
