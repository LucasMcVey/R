#text mining
#Week 6
#https://rstudio-pubs-static.s3.amazonaws.com/132792_864e3813b0ec47cb95c7e1e2e2ad83e7.html
library(tm)
library(SnowballC)
library(wordcloud)

#
# read the file

reviews = read.csv("movie_reviews.csv", stringsAsFactors = F)

# library(dplyr)
# reviews = mutate(reviews, id =row_number())

review_corpus = Corpus(VectorSource(reviews$Summary))

#Next we normalize the texts in the reviews using a series of pre-processing steps: 1. Switch to lower case 2. Remove numbers 3. Remove punctuation marks and stopwords 4. Remove extra whitespaces

review_corpus = tm_map(review_corpus, content_transformer(tolower))
review_corpus = tm_map(review_corpus, removeNumbers)
review_corpus = tm_map(review_corpus, removePunctuation)
review_corpus = tm_map(review_corpus, removeWords, c("the", "and", stopwords("english")))
review_corpus =  tm_map(review_corpus, stripWhitespace)

# Some warnings..ignore them. 
#You get a warning, not an error. 
#This warning only appears when you have a corpus based on a VectorSource in combination when you use Corpus instead of VCorpus.


# analyse data

review_dtm <- DocumentTermMatrix(review_corpus)
review_dtm
# pick some documents to see the words. 
#Please note, each line is one document
inspect(review_dtm[500:505, 500:505])

#To reduce the dimension of the DTM, we can emove the less frequent terms such that the sparsity is less 
review_dtm = removeSparseTerms(review_dtm, 0.99)
review_dtm

#first review

inspect(review_dtm[1,1:20])

#We can draw a simple word cloud

findFreqTerms(review_dtm, 1000) # top 1k terms

freq = data.frame(sort(colSums(as.matrix(review_dtm)), decreasing=TRUE))
wordcloud(rownames(freq), freq[,1], max.words=50, colors=brewer.pal(1, "Dark2"))

#we can remove words such as film and movie and use
#tfids instead of frequencies of terms as entries. 
#tf-idf measures the relative importance of a word to a document

review_dtm_tfidf <- DocumentTermMatrix(review_corpus, control = list(weighting = weightTfIdf))
review_dtm_tfidf = removeSparseTerms(review_dtm_tfidf, 0.98)
review_dtm_tfidf

inspect(review_dtm_tfidf[1,1:20]) # see non-sparse entries

freq = data.frame(sort(colSums(as.matrix(review_dtm_tfidf)), decreasing=TRUE))
wordcloud(rownames(freq), freq[,1], max.words=50, colors=brewer.pal(1, "Dark2"))


#wordcloud(rownames(freq)[1:40], freq[,1], max.words=40, colors = c("#132B43", "#56B1F7"))

