

def getData():
    filePath="data.txt"
    data=[]
    try:
        with open(filePath, 'r') as file:
            data = file.readlines()
        data = [line.strip() for line in data]
        print("Data retrieved successfully.")
    except FileNotFoundError:
        print("Data file not found.")
    return data