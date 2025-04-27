import csv
threshold = 70
def analyze_csv(file_name, threshold):
    try:
        with open(file_name, mode='r') as file:
            reader = csv.DictReader(file)
            
            for row in reader:
                name = row['name']
                grades = [int(row['Eng']), int(row['Hindi']), int(row['Maths'])]
                avg_grade = sum(grades) / len(grades)
                if avg_grade > threshold:
                    print(f"{name} has an average grade above {threshold}: {avg_grade:.2f}")
    
    except Exception as e:
        print(f"Error reading the file: {e}")
analyze_csv('Parth.csv', threshold)
