

file=open("hello.txt","a")
text=input("Enter your text: ")
file.write(text)

file.close()
file=open("hello.txt","r")
content=file.read() 
print("The content of the file is:")
print(content)