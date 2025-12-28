record={}
def addStudent():
    name=input("Enter student name: ")
    grade=input("Enter student grade: ")
    record[name]=grade

def viewStudents():
    for name, grade in record.items():
        print(f"Student: {name}, Grade: {grade}")

def updaeStudent():
    name=input("Enter student name to update: ")
    if name in record:
        grade=input("Enter new grade: ")
        record[name]=grade
    else:
        print("Student not found.")
        
addStudent()
addStudent()
updaeStudent()
viewStudents()