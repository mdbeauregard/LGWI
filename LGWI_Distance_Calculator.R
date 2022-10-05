## First, install and load the following packages using `install.packages'
## and 'library'.

install.packages("tidyverse")
install.packages("igraph")

library(tidyverse)
library(igraph)

## Next, load the CSV file containing the employee list.
## (Make sure that the R session directory is the one
## where the file is located. It's easiest just to save
## this R file to the directory where the CSV is located
## and then set the working directory to there;
## Session -> Set Working Directory -> To Source File Location)

employees = read.csv("Guilford County Employee List 05.20.21.csv")

## Next, create a new data frame that contains only the employees' names 
## and each employee's direct supervisor.

EmpsSups = data.frame(employees$Full.Name, employees$Supervisor.1)

## This next function will create a "graph object", which
## will allow us to create the new variable containing employee
## distance from the ultimate supervisor/manager.

graph = graph_from_data_frame(EmpsSups, directed=F)

## The following lines will check to see if each name in the supervisor
## column appears in the employee column.

x <- unique(EmpsSups$employees.Full.Name)
y <- unique(EmpsSups$employees.Supervisor.1)
y %in% x

## This will create an object that contains the shortest paths
## between every employee and the ultimate supervisor/manager.

sp = shortest_paths(graph, "Halford, Michael", EmpsSups$employees.Full.Name)

## This next line creates a distance variable in the graph.

EmpsSups$Distance <- length(sp$vpath[[]])

## This replaces the above variable with the distances from each
## employee to the ultimate/supervisor manager. 

for (i in 1:nrow(EmpsSups)) {
  EmpsSups$Distance[i] <- length(sp$vpath[[i]])
}

## This will stitch the new distance variable back to the original
## list of employees.

employees$Distance2 = EmpsSups$Distance

## This will write a new CSV file containing the original data
## as well as the new distance variable.

write.csv(employees, file = "New_Guilford_Data_with_Distance.csv")
