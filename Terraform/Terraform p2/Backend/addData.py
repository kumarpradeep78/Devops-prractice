

filePath="data.txt"

def updateFile(content):    
    with open(filePath, 'a') as file:
        file.write(content + '\n')  
    print("File updated successfully.")
    
