library(tidyverse)
library(igraph)

employees = read.csv("Guilford County Employee List 05.20.21.csv")
EmpsSups = data.frame(employees$Full.Name, employees$Supervisor.1)

graph = graph_from_data_frame(EmpsSups, directed=F)

## Checking to see if each supervisor shows up as an employee.

x <- unique(EmpsSups$employees.Full.Name)
y <- unique(EmpsSups$employees.Supervisor.1)

y %in% x

##'sp' used later in line 22

sp = shortest_paths(graph, "Halford, Michael", EmpsSups$employees.Full.Name)

EmpsSups$Distance <- length(sp$vpath[[]])

for (i in 1:nrow(EmpsSups)) {
  EmpsSups$Distance[i] <- length(sp$vpath[[i]])
}
