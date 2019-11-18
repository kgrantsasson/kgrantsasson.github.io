**Review of "Using Geolocated Twitter Data to Monitor the Prevelance of Healthy and Unhealthy Food Preferences across the US"
by Widener and Li. 

This study uses social media data retrieval and sentiment analyses of geolocated tweets to explore the prevelance of healthy
and unhealthy eating across the US. The authors cross-referenced these results with the USDA's list of food deserts to determine
wether unhealthy and healthy eating correlates to access to healthy foods. They ask, are people in food deserts more likely to 
consume less healthy foods?

While the authors do present this question, implying a hint of a hypotheses, they catagorize their study as exploratory, and
thus inductive. 

Overall, the authors of this study are very forthright with the methods of their analyses, perhaps becuase, as they claim,
this type of advanced sentiment analyses has never been done before. The authors used the Twitter streaming API which returns
near-real-time tweets. They describe their analyses through a series of modules. The first, the retrieval module, connects to the API
Public Stream which requires the establishment of a persistent HTTP conection. Through this connection, queried tweets are 
identified. The authors do not provide the list of terms they used to query the tweets which is required is someone wanted to 
reproduce the study. They do explain how they parsed out "noise" data, such as tweets that contained food words but that actually
referred to something else, like "Apple" reffering to the company rather than the fruit. 

Notably, the authors used an "error handling mechanism" which shuts down the program once the number of failed 
attempts is more than a predetermined value (Widener and Li, 191). The authors do not explain what exactly constitutes a failed
attempt, but I imagine that that just means that the query did not function properly.

Once the raw tweets were returned to the server, they were serialized and stored in the database. The parsing module 
then deserialized the tweets into text based JSON objects and extracted such information as the user ID, location, tweet text,
and time. 

The second module, the analyses module, performs a taxonomy analyses which assigns themes to each tweet. To be included in further
analyses one of the themes assigned to a tweet must be "Food and Drink". It is very helpful that the authors provide the explicit
tag they used so that someone trying to reproduce the study doesn't get bogged down in this critical step.

Finally, the authors performed a "sentiment analyses" which sought to determine whether the tweet implied a positive or negative
orientation towards the unhealthy or healthy food object. They used a feature-based sentiment analyses which assigns a positive 
negative value [-1-1] to each food object found in the tweets rather than to a whole tweet. They provide the quadrupal formula 
that they used which determined the (1) opinion of the (2) user on (3) some object at (4) a certain time. 

In order to determine the opinion of the user, the authors data-mined social media for 200 billion opinion words and extracted
these from the tweets. They did not provide a list of these words which would be helpful, although the reproducer could presumably
come up with a similar list. They then estimated teh positive or negative orientation of each of these words. 

The authors provide a thorough list of healthy/unhealthy food words which they used to code the tweets. They then created a 
population density surface in order to create a population-weighted kernel density estimate (KDE) of the tweets. The resulting
layers, after a couple more rounds of normalizing which the authors describe in detail, are in the units of tweets/people.

Overall, I find this study to be relatvely reproducible. While they don't provide the data that they used, they are very explicit
with how they manipulated this data and the methods of their analyses. I do wish that they provided the query code they used.
I imagine that the study can be replicated to analyze different kinds of sentiments just by replacing the words in initial query
and replacing the healhty/unhealthy food binary with another. If the authors had supplied their list of positive/negative
opinion words these could be also used to replicate the study. 

Check out the study [here](WidenerandLi.PDF) 
