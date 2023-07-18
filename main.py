import mysql.connector

mydb = mysql.connector.connect(host="localhost",  user="username",  password="password" , database = "databasename")

mycursor = mydb.cursor()

print("\n")
print("###################################")
print("#####  Welcome to Car Rental  #####")
print("###################################")
print("\n")

while True:
    print("1. Register New Customer")
    print("2. Add New Car")      
    print("3. Reserve a Car")             
    print("4. Return a Car") 
    print("5. Update rental rates")   
    print("6. For Exit")
    print("\n")

    value = int(input("Select the action number which you need to perform: "))
    print("\n")

    if value == 1:
        firstname = input("Enter your first name: ").strip().capitalize()
        lastname =  input("Enter your last name: ").strip().capitalize()
        custname = firstname[0:1]+"."+ lastname   
        phone =  input("Enter your 10 digit phone number without any spaces or special characters e.g. 9999999999: ")
        phone = phone[:3] + "-" + phone[3:6] + "-" + phone[6:]
        customerType = input(" Enter type of customer - business or individual: ").strip().lower()
        if customerType in["business", "individual"]:                
            mycursor.execute('''INSERT INTO customers (custname, phone, customerType) VALUES(%s,%s,%s) ''', (custname,phone,customerType))
            mydb.commit()
            print("\n")
            print("############################################")
            print("#########",mycursor.rowcount, " new customer register #########")
            print("############################################")
            new_id = mycursor.lastrowid
            print("##### Customer registeration ID is:", new_id, "#####")
            print("############################################")
        else:
           print("enter correct custType")
           exit()

    

    elif value==2:
        model = input("Enter model of the car: ").strip().capitalize()
        year = int(input("Enter built year of the car: "))
        vehicleType = input("Enter type of vehicle - compact or medium or large or SUV or truck or van: ").strip().lower()
        if vehicleType in ["compact", "medium", "large", "suv", "truck", "van"]:
            IsAvailable = 1
            carType = input("Enter type of car - luxury or regular: ").strip().lower()
            if carType in ["luxury", "regular"]:
                dailyRate = float(input("Enter daily rate: "))
                weeklyrate = float(input("Enter weekly rate: "))
                ownerType = input("Enter type of vehicle - rental company or bank or individual: ").strip().lower()
                if ownerType in ["rental company", "bank", "individual"]:
                    mycursor.execute('''INSERT INTO cars(model, year, vehicleType, IsAvailable, carType, dailyRate, weeklyrate, ownerType)
                                        VALUES (%s, %s, %s, %s, %s, %s, %s, %s)''',
                                    (model, year, vehicleType, IsAvailable, carType, dailyRate, weeklyrate, ownerType))
                    mydb.commit()
                    print("\n")
                    print("########################################")
                    print("######### Added" ,mycursor.rowcount, "new vehicle. #########")
                    print("########################################")       
                    new_id = mycursor.lastrowid
                    print("####### New vehicle ID is:", new_id,"########")
                    print("########################################") 

                else:
                    print("Invalid ownerType")
                    exit()
            else:
                print("Invalid carType")
                exit()
        else:
            print("Invalid vehicleType")
            exit() 


    elif value==3:
        mycursor.execute("Select c.vehicleId, c.model, c.year, c.vehicleType, c.carType, c.dailyRate,c.weeklyrate, a.startDate, a.endDate from cars c, availability a where c.vehicleId = a.vehicleId; ")
        result = mycursor.fetchall()
        if len(result) > 0:
            print("#################################################### Available Vehicle: ##########################################################")
            print("##################(vehicleId, model, year, vehicleType, carType, dailyRate, weeklyrate, startDate, endDate)#######################")
            for row in result:
                print("#####",row,"#####")
            print("#################################################################################################################################")
        else:
            print("No cars available.")

        print("\n")
        customerId =  input("Enter your customer Id to book a Car: ")
        vehicleId =  input("Which car you want to book? Enter vehicle Id for that Car: ")
        rentalType = input("Do you want to rent for weekly or daily basis? ").lower()
        noOfDaysOrWeeks = int(input("For how many days/week you want to rent vehicle? "))
        startDate = input("From which date you want to rent it? ")
        returnDate = input("Till which date you want to rent it? ")
        mycursor.execute('''INSERT INTO rental(vehicleId,customerID, rentalType, noOfDaysORWeeks, startDate, returnDate)
                                        VALUES (%s,%s, %s, %s, %s, %s)''',
                                    (vehicleId,customerId, rentalType, noOfDaysOrWeeks, startDate, returnDate))
        mydb.commit()
        print("\n")
        print("####################################################")
        print("######## You booked" ,mycursor.rowcount, "vehicle successfully. ########")
        print("####################################################")       
        new_id = mycursor.lastrowid
        print("############# Your booking Id is :", new_id,"##############")
        print("####################################################") 
       



        
    elif value==4:
        customerId = input("Enter customer Id: ")
        print("Id of Vehicle which you need to return today: ")
        mycursor.execute("""SELECT model from cars where vehicleId IN (Select vehicleId FROM rental WHERE customerId=%s and returnDate=CURDATE());""", (customerId,))
        result1 = mycursor.fetchall()
        print(result1)

        mycursor.execute("""SELECT sum(amountDue) FROM rental WHERE customerId=%s""", (customerId,))
        result = mycursor.fetchone()
        print("Amount due for rental car: ", result)

        print("\n")
        print("####################################################")        
        print("######## Thank you for paying due Amount. ##########")
        print("####################################################")
       
    elif value==5:
        vehicleId = input("Enter vehicleId which you want to update: ")
        rate = input("Enter type of rate which you want to update - weekly or daily: ")
        if rate == 'weekly':
            weeklyrate= float(input("Enter weekly rate: "))
            update_query = "UPDATE cars SET weeklyrate = %s WHERE vehicleId = %s"
            update_values = (weeklyrate, vehicleId)
            mycursor.execute(update_query, update_values)
            mydb.commit()
            print("\n")
            print("##################################################################")
            print("######## Weekly rate updated for",mycursor.rowcount, "vehicle with Id:",vehicleId," ########")
            print("##################################################################")     
        elif  rate == 'daily':
            dailyrate = float(input("Enter daily rate: "))
            update_query = "UPDATE cars SET dailyrate = %s WHERE vehicleId = %s"
            update_values = (dailyrate, vehicleId)
            mycursor.execute(update_query, update_values)
            mydb.commit()
            print("\n")
            print("#################################################################")
            print("######## Daily rate updated for",mycursor.rowcount, "vehicle with Id:",vehicleId," ########")
            print("#################################################################")   
        else :
            print("Invalid rate type")
            exit()


    elif value==6: 
        print("#######################################################")
        print("########## Exiting Car rental application... ##########")
        print("##### Thank you for using our car rental service! #####")
        print("#######################################################")
        break

    else:
        print("Invalid action number. Please try again.")

    # ask user if they want to continue
    print("\n")
    choice = input("Do you want to continue? (Y/N): ")
    if choice.lower() != "y":
        print("\n")
        print("#######################################################")
        print("########## Exiting Car rental application... ##########")
        print("##### Thank you for using our car rental service! #####")
        print("#######################################################")
        print("\n")
        break
    



    

       
    

