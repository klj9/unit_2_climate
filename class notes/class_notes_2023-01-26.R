#2023-01-26
#Logical, boolean, if/else statements

vec = c(1,0,2,1)
vec
#manual subsetting - this is how r subsets in the back end
vec[c(TRUE, FALSE, TRUE, FALSE)]

#important operators: >, >=, <, <=, ==, !=, %in%

1 %in% vec #returns true
4 %in% vec #returns false

#logical operators can be applied to vectors

1 > c(0, 1, 2) #returns true, false, false
c(1, 2, 3) == c(3, 2, 1) #returns false, true, false
c(1,3,5,7) %in% c(1,2,3) #returns true, true, false, false

#now lets work with the world oceans data frame we created before

world_oceans = data.frame(ocean = c("Atlantic", "Pacific", "Indian", "Arctic", "Southern"),
                          area_km2 = c(77e6, 156e6, 69e6, 14e6, 20e6),
                          avg_depth_m = c(3926, 4028, 3963, 3953, 4500))
world_oceans

#we want to look at the subset of oceans deeper than 4000m

world_oceans$avg_depth_m > 4000

deep_oceans = world_oceans[world_oceans$avg_depth_m > 4000, ] #subset of rows based on one of the columns, but bring along the rest of the columns
deep_oceans
sum(world_oceans$avg_depth_m > 4000) #coerces trues and falses into 1s and 0s

#imprecise numerics

1+2 == 3 #returns true
0.1+0.2 == 0.3 #returns false - binary form of the number is not exactly 0.1 etc
#if we need to do this test, we would have to rewrite it as something like:
my_error = 0.0001
abs(0.3 - (0.1+0.2)) > my_error

#boolean operators:

#   & - AND: are both conditions true?
#   | - OR: is one or more condition true?
#   xor - is exactly one of the conditions true
#   ! - is this condition false?
#   any - are any of these conditions true? (for a list of conditions)
#   all - is every condition true? (for a list of conditions)

#common mistake in evaluating 2 conditions:
x=5
#x>2 & <9 throws an error 
x>2 & x<9

x<3 | x>15 #false
x<3 | x<15 #true
x<10 & x %in% c(1,2,3) #false
x<10 | x %in% c(1,2,3) #true

#using conditions to subset world oceans data fram

world_oceans[world_oceans$avg_depth_m > 4000 & world_oceans$area_km2 < 50e6, ]
#only Southern ocean meets both conditions, returns all columns

world_oceans[world_oceans$avg_depth_m > 4000 | world_oceans$area_km2 < 50e6, ]
#looser conditions, returns more rows

z = c(TRUE, FALSE, FALSE)
z
any(z) #true
all(z) #false

#handling missing data

NA == NA #returns NA, not true, bc na is special
is.na(NA) #returns true
vec = c(0,1,2,NA,4)
is.na(vec) #false false false true false
any(is.na(vec)) #true

#practice exercises


#moving on to next tutorial

#------------------------------------------------------------------
#   2.3: CONDITIONAL STATEMENTS
#------------------------------------------------------------------

#if statements

num = -3

if(num<0){
  print("oh no num is negative!")
  num = num*(-1)
  print("don't worry i fixed it")
}

num

#exercise 3.1

temp = 98

if(temp>98.6) {
  fever = temp - 98.6
  print("uh oh looks like you have a fever of:")
  print(fever)
  if(temp>101) {
    print("warning! you have a high fever")
  }
}

#else if and else statements

a=40
b=40

if(a>b){
  print("you won!")
} else if(a<b){
  print("you lost :(")
} else{
  print("you tied")
}

#ifelse statement consolidates it all into a single function
#three arguments: condition, if statement, else statement

a = 2
ifelse(a != 0, 1/a, NA)