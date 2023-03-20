#!/bin/bash

counter=1
max_restarts=2
while true; do

# Initialize model prices
A_CLASS_MIN=24095
A_CLASS_MAX=38095
A_CLASS_AVG=31095

B_CLASS_MIN=28045
B_CLASS_MAX=38280
B_CLASS_AVG=33162

C_CLASS_MIN=34670
C_CLASS_MAX=50405
C_CLASS_AVG=42537

E_CLASS_MIN=39680
E_CLASS_MAX=69015
E_CLASS_AVG=54437

AMG_C65_MIN=78103
AMG_C65_MAX=81217
AMG_C65_AVG=79660

# Initialize salesperson salary and bonuses
BASIC_SALARY=2000
BONUS_200K=10000
BONUS_300K=15000
BONUS_400K=20000
BONUS_500K=25000
BONUS_650K=30000

# Prompt user for their name
echo "What is your name?"
read name

# Prompt user for a month
echo "Enter month in exact spelling format, e.g (January, February, March...): "
read month

# Check if month input is valid
while [[ $month != "January" && $month != "February" && $month != "March" && $month != "April" && $month != "May" && $month != "June" && $month != "July" && $month != "August" && $month != "September" && $month != "October" && $month != "November" && $month != "December" ]]; do
echo "Invalid month. Please enter a valid month."
read month
done

# Prompt user for the number of A class
while true; do
echo "Enter the number of A class models: "
read a_class
if [[ $a_class =~ ^[0-9]+$ ]]; then
break
else
echo "Invalid input. Please enter a whole number."
fi
done

# Prompt user for the number of B class
while true; do
echo "Enter the number of B class models: "
read b_class
if [[ $b_class =~ ^[0-9]+$ ]]; then
break
else
echo "Invalid input. Please enter a whole number."
fi
done

# Prompt user for the number of C class
while true; do
echo "Enter the number of C class models: "
read c_class
if [[ $c_class =~ ^[0-9]+$ ]]; then
break
else
echo "Invalid input. Please enter a whole number."
fi
done

# Prompt user for the number of E class
while true; do
echo "Enter the number of E class models: "
read e_class
if [[ $e_class =~ ^[0-9]+$ ]]; then
break
else
echo "Invalid input. Please enter a whole number."
fi
done

# Prompt user for the number of AMG C65
while true; do
echo "Enter the number of AMG C65 models: "
read amg_c65
if [[ $amg_c65 =~ ^[0-9]+$ ]]; then
break
else
echo "Invalid input. Please enter a whole number."
fi
done


# Calculate total prices
a_class_total=$((a_class * A_CLASS_AVG))
b_class_total=$((b_class * B_CLASS_AVG))
c_class_total=$((c_class * C_CLASS_AVG))
e_class_total=$((e_class * E_CLASS_AVG))
amg_c65_total=$((amg_c65 * AMG_C65_AVG))

# Calculate total sales and bonuses
total_sales=$((a_class_total + b_class_total + c_class_total + e_class_total + amg_c65_total))
bonus=0
if [ $total_sales -ge 650000 ]; then
  bonus=$BONUS_650K
elif [ $total_sales -ge 500000 ]; then
  bonus=$BONUS_500K
elif [ $total_sales -ge 400000 ]; then
  bonus=$BONUS_400K
elif [ $total_sales -ge 300000 ]; then
  bonus=$BONUS_300K
elif [ $total_sales -ge 200000 ]; then
  bonus=$BONUS_200K
fi

# Gross monthly salary calculations
gross_salary=$(expr $BASIC_SALARY + $bonus )

# Tax calculations
if [ $gross_salary -lt 12500 ]; then
  tax=0
elif [ $gross_salary -lt 50000 ]; then
  tax=`echo "($gross_salary) * 0.2" | bc`
else
  basic_tax=`echo "(50000 - 12500) * 0.2" | bc`
  tax=`echo "$basic_tax + $additional_tax + $higher_tax" | bc`
fi

# Net salary calculation
net_salary=$(echo "$gross_salary - $tax" | bc)

# Print greeting with name and month
echo "Hello, $name,"
echo "Your gross salary for $month is £$gross_salary"
echo "Your net salary for $month is £$net_salary"
echo "This set of data has been saved in the file 'salesperson_salary_JJ.txt' in a folder called 'TCA2'"

# Save the inputs/outputs into another file in a new directory
if [ ! -d ~/TCA2 ]; then
  mkdir ~/TCA2
fi
if [ ! -f ~/TCA2/salesperson_salary_JJ.txt ]; then
  touch ~/TCA2/salesperson_salary_JJ.txt
fi
echo "$name $month $net_salary $gross_salary" >> ~/TCA2/salesperson_salary_JJ.txt

# Restart or quit prompt
if [ $counter -gt $max_restarts ]; then
read -p "Press 'n' to quit, or input any other key to continue: " input_new_data
if [ "$input_new_data" == "n" ]; then
break
else
((counter++))
fi
# Prevents the program being used over 20 times
elif [ $counter -eq 19 ]; then
echo "You have reached the maximum number of restarts. Quitting now."
break
else
((counter++))
fi

done
