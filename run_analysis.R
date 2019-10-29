library(tidyverse)
path <- "./UCI\ HAR\ Dataset/"
                                        # Load Data
## Load train and test data
X_train <- read.table(file = paste0(path,"train/X_train.txt"),sep = "") %>% as_tibble
X_test <- read.table(file = paste0(path,"test/X_test.txt"),sep = "") %>% as_tibble
## Get Y data
y_train <- read.table(file = paste0(path,"train/y_train.txt"),sep = "") 
y_test <- read.table(file = paste0(path,"test/y_test.txt"),sep = "")
## Get subject identifier
subject_train <- read.table(file = paste0(path,"train/subject_train.txt"),sep = "",stringsAsFactors = FALSE) %>% as_tibble
subject_test <- read.table(file = paste0(path,"test/subject_test.txt"),sep = "",stringsAsFactors = FALSE) %>% as_tibble

                                        # Map and bind data
## Map activitites function
activity_map <- function(a){
    out <- numeric(length = length(a))
    for(i in seq_along(a)){
        if(a[i]==1){out[i] = ('WALKING')}
        else if(a[i]==2){out[i] = ('WALKING_UPSTAIRS')}
        else if(a[i]==3){out[i] = ('WALKING_DOWNSTAIRS')}
        else if(a[i]==4){out[i] = ('SITTING')}
        else if(a[i]==5){out[i] = ('STANDING')}
        else if(a[i]==6){out[i] = ('LAYING')}}
    return(out)
}
## Map activities
y_train <- map(y_train,activity_map) %>% as_tibble
y_test <- map(y_test,activity_map) %>% as_tibble


## Bind Train data  and test data
X_tot <- rbind(X_train,X_test)
y_tot <- rbind(y_train,y_test) %>% rename("ACTIVITY" = V1)
sub_tot <- rbind(subject_train,subject_test ) %>% rename("SUBJECT" = V1)

# Rename columns
colnames(X_tot) <- feat_names[,2]

## Get mean and standard deviation columns
cols <- grep("std()|mean()", names(X_tot), value = TRUE)
X_tot <- X_tot[,cols]


## Bind Columns
df_tot <- cbind(X_tot,y_tot,sub_tot) %>% as_tibble

                                        # Produces avrages by grouping
# Produce Avrage of subject and activity 
df_avg <- df_tot %>% group_by(SUBJECT,ACTIVITY) %>% summarize_all("mean")
