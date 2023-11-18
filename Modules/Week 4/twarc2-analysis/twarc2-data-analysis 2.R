## reading from twarc2

## first install using the command prompt

#pip3 install --upgrade twarc-csv

#twarc2 csv results.json blm.csv

#Please note results.jsonl is the file you downloaded and 
#the csv file that is getting created is blm.csv
# turn off scientific notation otherwise your tweet/userIDs will be converted 
#to scientific notation and that will introduce errors
options(scipen = 999)
getwd()
#setwd("/Users/nasi0029/OneDrive - Flinders/DataEngineering-Material/wk4")

df = data.frame()
#read file in a data frame called df
df = read.csv("blm.csv", header=T, as.is=T)

# to find column names
colnames(df) # please explore the column names to find out
            # what each column contains

#to display the first author
df$author.id[1]

#display the number of unique tweets
length(unique(df$id))

#display tweet text of tweet number 10
df$text[10]

# hashtags
df$entities.hashtags[1] 
# Weird output! how to fix it?? 
# Do you recall seeing such a format anywhere else? 

# It is a JSON format!!!! Which means hashtags are in JSON format!
#lets read them for the first tweet!

htags = fromJSON(df$entities.hashtags[1], method = 'C', unexpected.escape = "error")

#how many hashtags? Well got them in a list! Lets see the length

length(htags) #12

for (i in 1:length(htags))
{
 print(htags[[i]]$tag) #please note recursive indexing 
                      #will not work for list with two square brackets
}

#how about finding hashtags in the first 10 tweets and creating a frequency chart? 


