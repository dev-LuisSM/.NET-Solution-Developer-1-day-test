# Differences between the following two SQL commands.

- First Case: 

``INSERT INTO Account VALUES (1,'John','Adams','john@abc.com',123456,'12 Street', 'AB12 3DE', '01235 632563');``

- Second Case:

``INSERT INTO Account VALUES (1,'John','Adams','john@abc.com',123456,'12 Street', 'AB12 3DE', '01235 632563');``

## What will happen?
1) In this first case, all values will be assigned to the column found first. <br>
  E.g. if the fourth column is the Street and not the Email, the street value will be "john@abc.com".

2) An error will occur when the value does not match the type of the column. <br>
  E.g. In the first example: An error may occur if in case the first column needs a varchar value, it will show an error.
  <br> In the second example: An error will occur in the AccountNumber column if the value is an int.
  
3) In the second example, the last value (john@abc.com) needs quotes because it is a varchar value.
