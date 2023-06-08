import subprocess as sp
import matplotlib.pyplot as plt
import pymysql
import pymysql.cursors
import math
import prettytable
from tabulate import tabulate
import getpass
import numpy

def Find_Working():
    try:
        query = "Select * from worker_name natural join Worker\
            natural join worker_age where Working_Status='Y'"
        
        cur.execute(query)
        con.commit()
        myans = cur.fetchall()

        mylist=[]
        for y in myans:
            l=[y["W_No"],y["F_Name"],y["M_Name"],y["L_Name"],\
                y["Gender"],y["DOB"],y["S_No"],y["Working_Status"],y["Age"]]
            mylist.append(l)
        print("These are the Workers currently working: ")
        print(tabulate(mylist, headers=["W_No", "F_Name", "M_Name","L_Name",\
            "Gender","DOB","S_No","Working_Status","Age"], tablefmt='psql'))

    except Exception as e:
        con.rollback()
        print("Failed to insert into database")
        print(">>>>", e)

    return



def insert_model():
    try:
        row = {}
        print("Enter the model details: ")
        
        row["Model_Name"] = input("Name of Model: ")
        row["Car_Type"] = input("Type of Car: ")
        row["Count_in_Storage"] = int(0)
        row["Plastic_Req"] = int(input("Plastic Required: "))
        row["Steel_Req"] = int(input("Steel Required: "))
        row["Leather_Req"] = int(input("Leather Required: "))
        row["Cloth_Req"] = int(input("Cloth Required: "))
        col=input("Colours Available (comma seperated): ").split(",")

        cur.execute("insert into car_models values('%s','%s','%d','%d','%d','%d')"\
            % (row["Model_Name"],row["Car_Type"],row["Plastic_Req"]\
                ,row["Steel_Req"],row["Leather_Req"],row["Cloth_Req"]))

        for x in col:
            cur.execute("insert into colours_available values('%s','%s')" % (row["Model_Name"],x))
        
        con.commit()

    except Exception as e:
        con.rollback()
        print("Failed to insert into database")
        print(">>>>>>>>>>>>>", e)
    return


def Max_Model_Name():
    try:
        query = "select Model_Name,Count(*) as \
            Storage_Count from cars_in_storage group\
            by Model_Name having count(*)=(select \
            max(Y.b) from (select Count(*) as b \
            from cars_in_storage group by model_name) as Y)"
        
        cur.execute(query)
        con.commit()
        myans = cur.fetchall()

        mylist=[]
        for y in myans:
            l=[y["Model_Name"],y["Storage_Count"]]
            mylist.append(l)
        print("Model with Maximum cars in storage: ")
        print(tabulate(mylist, headers=["Model_Name","Storage_Count"], tablefmt='psql'))

    except Exception as e:
        con.rollback()
        print("Some Issue occured")
        print(">>>>", e)
    return


def get_vin():
    try:
        query="select * from Cars_On_Conveyer_Belts having progress>=50"
        cur.execute(query)
        con.commit()
        myans = cur.fetchall()
        
        mylist=[]
        for y in myans:
            l=[y["VIN_NO"],y["Belt_No"],y["Progress"]]
            mylist.append(l)
        print("Cars with Progress>=50% Are: ")
        print(tabulate(mylist, headers=["VIN_NO","Belt_No","Progress"], tablefmt='psql'))

    except Exception as e:
        con.rollback()
        print("Failed to insert into database")
        print(">>>>>>>>>>>>>", e)

    return

def get_names():
    try:
        a=input("Enter starting character of worker name: ")
        a=a+"%"
        cur.execute("select W_No,F_Name,M_Name,L_Name\
            from worker_name where F_Name like '%s' " %(a))
        con.commit()
        myans = cur.fetchall()

        mylist=[]
        for y in myans:
            l=[y["W_No"],y["F_Name"],y["M_Name"],y["L_Name"]]
            mylist.append(l)

        print(tabulate(mylist, headers=["W_No","F_Name","M_Name","L_Name"], tablefmt='psql'))

    except Exception as e:
        con.rollback()
        print("Some Issue occured")
        print(">>>>", e)
    return

def avg_date():
    try:
        query = "select * from cars_in_storage\
             where datediff(now(),date_of_arrival) > (select AVG(Y.b)\
                 from (select datediff(Now(),date_of_arrival)\
                     as b from cars_in_storage) as Y)"
        
        cur.execute(query)
        con.commit()
        myans = cur.fetchall()

        mylist=[]
        for y in myans:
            l=[y["VIN"],y["Date_of_Arrival"],y["W_NO"],y["Model_Name"]]
            mylist.append(l)

        print(tabulate(mylist, headers=["VIN","Date_of_Arrival","W_NO","Model_Name"], tablefmt='psql'))

    except Exception as e:
        con.rollback()
        print("Some Issue occured")
        print(">>>>", e)
    return

def update_progress():
    try:
        vi=input("Enter Vin of car to update progress: ")
        p=input("Enter new progress value: ")
        if int(p)!=100:
            cur.execute("update Cars_On_Conveyer_Belts set\
                 progress='%s' where VIN_NO='%s'" % (p,vi))
        else:
            wno=input("Car has completed Production! Enter Worker Number to assign: ")
            cur.execute("insert into cars_in_storage values('%s',NOW(),'%s',NULL)" % (vi,wno))
            cur.execute("delete from Colours_of_cars_on_conveyer_belts where VIN='%s'" % (vi))
            cur.execute("delete from Workers_of_cars_on_conveyer_belts where VIN='%s'" % (vi))
            cur.execute("delete from Requires where VIN_NO='%s'" % (vi))
            cur.execute("delete from robots where VIN_No='%s'" % (vi))
            cur.execute("delete from cars_on_conveyer_belts where VIN_NO='%s'" % (vi))
            cur.execute("update cars_in_storage set Model_Name=\
                (select Model_Name from cars where cars.VIN='%s') where VIN='%s' " % (vi,vi))
        con.commit()

    except Exception as e:
        con.rollback()
        print("Some Issue occured")
        print(">>>>", e)
    return

def show_me_table(st):
    try:
        cur.execute("select * from %s" % (st))
        con.commit()
        myans=cur.fetchall()
        for y in myans:
            print(y)

    except Exception as e:
        con.rollback()
        print("Some Issue occured")
        print(">>>>", e)
    return

def change_state():
    try:
        cur.execute("Select * from robots")
        con.commit()
        m=cur.fetchall()

        mylist=[]
        for y in m:
            l=[y["VIN_No"],y["Work_Code"],y["Working_Status"]]
            mylist.append(l)

        print(tabulate(mylist, headers=["VIN_No","Work_Code","Working_Status"], tablefmt='psql'))

        inp=input("Enter Vin of Car: ")
        code=input("Enter Working Code of Robot: ")
        st=input("Enter new status (Y or N): ")

        cur.execute("update robots set working_status='%s' \
        where VIN_No='%s' and work_code='%s'" % (st,inp,code))
        con.commit()

        print("New Robots Table:")
        cur.execute("Select * from robots")
        con.commit()
        m=cur.fetchall()

        mylist=[]
        for y in m:
            l=[y["VIN_No"],y["Work_Code"],y["Working_Status"]]
            mylist.append(l)

        print(tabulate(mylist, headers=["VIN_No","Work_Code","Working_Status"], tablefmt='psql'))

    except Exception as e:
        con.rollback()
        print("Some Issue occured")
        print(">>>>", e)
    return

def change_resource():
    try:
        cur.execute("Select * from resources")
        con.commit()
        m=cur.fetchall()

        mylist=[]
        for y in m:
            l=[y["Name"],y["No_Suppliers"],y["Supply_Available"]]
            mylist.append(l)

        print(tabulate(mylist, headers=["Name","No_Suppliers","Supply_Available"], tablefmt='psql'))

        b=input("Enter Name of Resource: ")
        c=input("Enter new number of suppliers: ")

        cur.execute("update resources set No_Suppliers=%d where Name='%s'" % (int(c),b))
        con.commit()

        print("Resources Now: ")
        cur.execute("Select * from resources")
        con.commit()
        m=cur.fetchall()

        mylist=[]
        for y in m:
            l=[y["Name"],y["No_Suppliers"],y["Supply_Available"]]
            mylist.append(l)

        print(tabulate(mylist, headers=["Name","No_Suppliers","Supply_Available"], tablefmt='psql'))

    except Exception as e:
        con.rollback()
        print("Some Issue occured")
        print(">>>>", e)
    return

def inc_supply():
    try:
        cur.execute("Select * from resources")
        con.commit()
        m=cur.fetchall()

        mylist=[]
        for y in m:
            l=[y["Name"],y["No_Suppliers"],y["Supply_Available"]]
            mylist.append(l)

        print(tabulate(mylist, headers=["Name","No_Suppliers","Supply_Available"], tablefmt='psql'))

        b=input("Enter Name of Resource: ")
        c=input("Enter new Supply: ")

        cur.execute("update resources set Supply_Available=%d where Name='%s'" % (int(c),b))
        con.commit()

        print("Resources Now: ")
        cur.execute("Select * from resources")
        con.commit()
        m=cur.fetchall()

        mylist=[]
        for y in m:
            l=[y["Name"],y["No_Suppliers"],y["Supply_Available"]]
            mylist.append(l)

        print(tabulate(mylist, headers=["Name","No_Suppliers","Supply_Available"], tablefmt='psql'))

    except Exception as e:
        con.rollback()
        print("Some Issue occured")
        print(">>>>", e)
    return

def load_belt():
    try:
        cur.execute("select Belt_No as Belt_Number,count(*) as Count from\
             cars_on_conveyer_belts group by Belt_No")
        con.commit()
        m=cur.fetchall()
        tot=set(int(val["Belt_Number"]) for val in m)

        ct=[]
        for a in tot:
            for b in m:
                if b["Belt_Number"]==a:
                    ct.append(int(b["Count"]))

        print(tot)
        print(ct)

        xpts=numpy.array(list(tot))
        ypts=numpy.array(ct)
        plt.title("Load on conveyer belts")
        plt.bar(xpts,ypts, color ='purple',width=0.5)
        plt.show()        

    except Exception as e:
        con.rollback()
        print("Some Issue occured")
        print(">>>>", e)
    return

def new_car():
    try:
        print("These are the Models Available: ")
        cur.execute("select Model_Name,Car_Type from car_models")
        con.commit()
        m=cur.fetchall()

        mylist=[]
        for y in m:
            l=[y["Model_Name"],y["Car_Type"]]
            mylist.append(l)

        print(tabulate(mylist, headers=["Model_Name","Car_Type"], tablefmt='psql'))
        v=input("Enter VIN for new car: ")
        c=input("Enter Model Name: ")
        cur.execute("insert into cars values('%s','%s')" % (v,c))
        con.commit()
        belt=int(input("Enter Belt Number: "))
        prog=0
        cur.execute("select Colour from colours_available where Model_Name='%s'" % (c))
        con.commit()
        vi=cur.fetchall()
        abc=[]
        for y in vi:
            l=[y["Colour"]]
            abc.append(l)
        
        print(tabulate(abc, headers=["Colour"], tablefmt='psql'))
        col=input("Enter colours for car (comma seperated): ").split(",")
        cur.execute("insert into cars_on_conveyer_belts values('%s','%s',%d)" % (v,belt,prog))
        con.commit()
        for x in col:
            cur.execute("insert into Colours_of_Cars_On_Conveyer_Belts values('%s','%s')" % (v,x))
            con.commit()
        wn=input("Enter Worker Number for managing this car: ")
        cur.execute("insert into Workers_Of_Cars_On_Conveyer_Belts values('%s','%s')" % (v,wn))
        con.commit()

        cur.execute("select * from cars_on_conveyer_belts")
        con.commit()
        data=cur.fetchall()

        mml=[]
        for y in data:
            l=[y["VIN_NO"],y["Belt_No"],y["Progress"]]
            mml.append(l)
        
        print(tabulate(mml, headers=["VIN_NO","Belt_No","Progress"], tablefmt='psql'))
    except:
        con.rollback()
        print("Some Issue occured")
        print(">>>>", e)
    return

def dispatch(ch):
    if(ch == "1"):
        Find_Working()
    elif(ch == "2"):
        Max_Model_Name()
    elif(ch == "4"):
        get_vin()
    elif(ch=="3"):
        get_names()
    elif(ch=="5"):
        avg_date()
    elif(ch=="6"):
        update_progress()
    elif(ch=="7"):
        insert_model()
    elif(ch=='8'):
        new_car()
    elif(ch=='9'):
        change_state()
    elif(ch=='10'):
        change_resource()
    elif (ch=='11'):
        inc_supply()
    elif (ch=='12'):
        load_belt()
    elif(ch=='13'):
        exit(0)
    elif(ch == "quit"):
        return
    else:
        print("Error: Invalid Option")


# Global
while(1):
    tmp = sp.call('clear', shell=True)
    
    # Can be skipped if you want to hardcode username and password
    username = input("Username: ")
    password = getpass.getpass("Password: ")

    try:
        # Set db name accordingly which have been create by you
        # Set host to the server's address if you don't want to use local SQL server 
        con = pymysql.connect(host='localhost',
                              user=username,
                              password=password,
                              db='CAR_PRODUCTION',
                              cursorclass=pymysql.cursors.DictCursor)
        tmp = sp.call('clear', shell=True)

        if(con.open):
            print("Successfully Connected !!")
            print()
        else:
            print("Failed to connect")

        tmp = input("Enter any key to CONTINUE>")

        with con.cursor() as cur:
            while(1):
                tmp = sp.call('clear', shell=True)
                # Here taking example of Employee Mini-world
                print("Welcome To The Car Factory !")
                print("What can we help you with ?")
                print("1. Find Employees Currently Working on a Car on Conveyer Belt")  # Hire an Employee
                print("2. Find model with maximum units in storage")  # Fire an Employee
                print("3. Find all workers with name starting with a given letter")  # Promote Employee
                print("4. Get Details about all cars with progress >= 50%")  # Employee Statistics
                print("5. Get details of car in storage with waiting time more than avg waiting time")
                print("6. Update progress of a Car On Conveyer Belt")
                print("7. Insert a new Car Model")
                print("8. Put a car into production")
                print("9. Change working status of a robot")
                print("10. Increase number of suppliers of a resource")
                print("11. Increase Supply of a resource")
                print("12. Find Load on each Conveyer Belt")
                print("13. To quit")
                ch = input("Enter choice> ")
                tmp = sp.call('clear', shell=True)
                dispatch(ch)
                tmp = input("Enter any key to CONTINUE>")

    except Exception as e:
        tmp = sp.call('clear', shell=True)
        print(e)
        print("Connection Refused: Either username or password is incorrect or user doesn't have access to database")
        tmp = input("Enter any key to CONTINUE>")