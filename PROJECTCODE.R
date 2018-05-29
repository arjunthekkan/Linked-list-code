#Load the data into R

tweets=read.csv(file.choose())
tweets
library(tm)
#build a corpus, and specify the source to be character vectors
tc=Corpus(VectorSource(tweets$text))
tc
inspect(tc)
tvc=VCorpus(VectorSource(tweets))
inspect(tc)
# convert to lower case
tc=tm_map(tc,content_transformer(tolower))
# remove URLs
remurl=function(tc)gsub("http[^[:space:]]*","",tc)

tc=tm_map(tc,content_transformer(remurl))
# remove anything other than English letters or space
rmvnumpunct=function(tc)gsub("[^[:alpha:][:space:]]*","",tc)
tc=tm_map(tc,content_transformer(rmvnumpunct))
# remove stopwords
msw=c(setdiff(stopwords('english'),c("r","big")),"rt","see","used","via","amp","eduaubdedubuf","eduaubdedubuaeduaubdedubuaeduaubdedubuaeduaubdedubuaddemonet","eduaubdedubu","eduaubeedubueduaubdedubueduaubdedubuc","roshankar","reddi","gauravcsaw","pgurus","atheistkrishna", "mahikainfra","drgpradhan","harshkkapoor","vaidyanathan","drkumarvishwa","eduaubeedububeduaubcedubfubbuduufef","eduaubdedubueduaubdedubu","eduaubdedubudeduaubdedubud","eduaubdedubuaeduaubdedubuaeduaubdedubuaeduaubdedubuaddemonet","eduaubdedubuaeduaubdedubuaeduaubdedubuaeduaubdedubuaddemonet")
tc=tm_map(tc,removeWords,msw)
# remove extra whitespace
tc=tm_map(tc,stripWhitespace)
inspect(tc)
# stem words
tc=tm_map(tc,stemDocument)
writeLines(strwrap(tc[[60]]$content,30))
#Build term document matrix
tdm=TermDocumentMatrix(tc,control = list(wordLengths = c(1,Inf)))

inspect(tdm)
install.packages("Rgraphviz")
library(ggplot2)
# inspect frequent words
(freq.terms <- findFreqTerms(tdm, lowfreq = 40))
term.freq = rowSums(as.matrix(tdm))
term.freq = subset(term.freq,term.freq >=300)
df = data.frame(term = names(term.freq),freq = term.freq)

# plot the frequent words
ggplot(df,aes(x=term,y=freq))+geom_bar(stat = "identity")+ xlab("terms")+ ylab("count")+coord_flip()+theme(axis.text = element_text(size = 7))
install.packages("topicmodels")
install.packages("sentiment140")
library(sentiment)
install.packages("sentimentr")
library(sentimentr)
library(sentiment)
m=as.matrix(tdm)
# calculate the frequency of words and sort it by frequency
word.freq=sort(rowSums(m),decreasing = T)
#plot word cloud
library(wordcloud)
pal <- brewer.pal(8, "Dark2")
pal <- pal[-(1:6)]
wordcloud(words = names(word.freq),freq = word.freq,min.freq = 3,max.words = 200,  random.order = F,colors = pal)
# which words are associated with 'poor and corrupt'?

findAssocs(tdm,"poor",0.2)
findAssocs(tdm,"corrupt",0.2)
library(graph)
library(Rgraphviz)
dtm=as.DocumentTermMatrix(tdm)
dtm
length(tweets)
#topic modelling
library(topicmodels)
# find 8 topics
lda = LDA(dtm,k=8)
# first 7 terms of every topic
term = terms(lda,7)
(term = apply(term,MARGIN = 2,paste, collapse = ", "))
topics = topics(lda)
install.packages("xts")
install.packages("data.table")
library(xts)
library(data.table)
require(data.table)
topics <- topics(lda)
topics <- data.frame(date=as.IDate(tweets$created), topic=topics)
ggplot(topics,aes(date,fill=term[topic]))+geom_density(position = "stack")
#sentiment analysis
library(plyr)
library(stringr)
library(sentiment)
tweet_result
sentiments = sentiment(tweet_result,split="")
table(sentiments$polarity)
# sentiment plot
sentiments$score <- 0
sentiments$score[sentiments$polarity == "positive"] <- 1

sentiments$score[sentiments$polarity == "negative"] <- -1
library(data.table)
library(twitteR)
tweets.df =as.data.frame(tweets)
sentiments$date <- as.IDate(tweets.df$created)
result <- aggregate(score ~ date, data = sentiments, sum)
plot(result, type = "l")
strsplit(topics,split = " ")
score.sentiment




#sentiment analysis
library(tm)
library(stringr)
library(syuzhet) #this library contain sentiment dictionary
library(lubridate) #provides tools that make it easier to parse and manipulate dates
library(ggplot2)
library(scales)
library(reshape2)
library(dplyr ) #dplyr provides a flexible grammar of data manipulation

#fetch sentiment words from tweets
tweets <- data.frame(lapply(tweets, as.character), stringsAsFactors=FALSE)
mySentiment <- get_nrc_sentiment(tweets$text)
head(mySentiment)
text <- cbind(tweets$text, mySentiment)

#count the sentiment words by category
sentimentTotals <- data.frame(colSums(text[,c(2:11)]))
names(sentimentTotals) <- "count"
sentimentTotals <- cbind("sentiment" = rownames(sentimentTotals), sentimentTotals)
rownames(sentimentTotals) <- NULL

#total sentiment score of all texts
ggplot(data = sentimentTotals, aes(x = sentiment, y = count)) +
  geom_bar(aes(fill = sentiment), stat = "identity") +
  theme(legend.position = "none") +
  xlab("Sentiment") + ylab("Total Count") + ggtitle("Total Sentiment Score for All Texts with related to Demonetisation")

