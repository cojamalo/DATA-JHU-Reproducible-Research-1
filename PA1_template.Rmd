---
title: "DATA-JHU-Reproducible-Research-1"
output:
  html_document: default
  html_notebook: default
---
### Submission by Connor Lenio. Email: cojamalo@gmail.com
Completion Date: Mar 27, 2017

### Introduction to the Data
Please view the README.md for the background information for this project.

### Load packages
```{r load-packages, message = FALSE}
library(data.table)
library(mice)
library(pander)
library(ggplot2)
library(lubridate)
library(dplyr)
```

### Load and Process data
Use fread to quickly read in the data to R and convert the data column to the date class using lubridate - act:
```{r load-data}
act <- fread("activity.csv", header= TRUE, na.strings = "NA") %>% tbl_df
act$date <- ymd(act$date)
```

* * *

### Part 1: What is mean total number of steps taken per day?
The mean total number of steps taken per day is 10766.2.

<br>

#### 1. Calculate the total number of steps taken per day
Ignore NA values and summarize by date to get the total number of steps for each day recorded in the data - total_steps_per_day:
```{r Question 1-1, echo=TRUE, results="asis"}
total_steps_per_day <- act %>% filter(!is.na(steps)) %>% group_by(date) %>% summarize(total_steps = sum(steps))
pandoc.table(total_steps_per_day)
```

<br>

#### 2. Make a histogram of the total number of steps taken each day
Plot the distribution of the summarized data above:
```{r Question 1-2, echo=TRUE, messages = FALSE}
ggplot(total_steps_per_day, aes(x = total_steps)) + 
    geom_histogram(fill = "#F8766D") +
    labs(title = "Histogram of the Total Number of Steps Taken Each Day", x = "Total Steps by Date", y = "Count") +
    theme(plot.title = element_text(hjust = 0.5))
```

<br>

#### 3. Calculate and report the mean and median of the total number of steps taken per day
Using the summarized data above, find the average and median for the total number of steps taken per day - report:
```{r Question 1-3, echo=TRUE, results="asis"}
report <- total_steps_per_day %>% summarize(`Mean Steps Per Day` = mean(total_steps), `Median Steps Per Day` = median(total_steps))

pandoc.table(report)
```

* * *

### Part 2: What is the average daily activity pattern?
The average daily activity pattern involves around zero average steps taken at the beginning of the daily intervals, with a rapid increase in the amount of steps taken occuring after the 500 interval until the 835 interval. After the max around the 835 interval, the average steps taken drops until just before the 1000 interval where it varies between about 25 and 100 average steps per interval until the 2000 interval when a drop to near zero average steps occurs.

<br>

#### 1. Make a time series plot (i.e. 𝚝𝚢𝚙𝚎 = "𝚕") of the 5-minute interval (x-axis) and the average number of steps taken, averaged across all days (y-axis)
Summarize the data grouping by interval to find the average number of steps taken for each interval across all days - mean_steps_by_interval:
```{r Question 2-1, echo=TRUE}
mean_steps_by_interval <- act %>% group_by(interval) %>% summarise(mean_steps = mean(steps, na.rm = TRUE))
ggplot(mean_steps_by_interval, aes(x =interval, y = mean_steps)) + 
    geom_line(col = "#F8766D") +
    labs(title = "Average Number of Steps Taken by 5-Minute Interval for All Days", x = "Interval", y = "Average Steps Taken") +
    theme(plot.title = element_text(hjust = 0.5))
```
<br>

#### 2. Which 5-minute interval, on average across all the days in the dataset, contains the maximum number of steps?
Determine the interval that contains the maximum value for the average total steps using which.max - max_steps_interval:
```{r Question 2-2, echo=TRUE}
max_steps_interval <- which.max(mean_steps_by_interval$mean_steps)
max_steps_interval <- mean_steps_by_interval$interval[max_steps_interval]
```


The `r max_steps_interval` interval is the interval that contains the maximum number of average steps for all days.

* * *

### Part 3: Imputing missing values

#### 1. Calculate and report the total number of missing values in the dataset (i.e. the total number of rows with 𝙽𝙰s)
Use is.na to count the number of rows with missing data - missing:
```{r Question 3-1, echo=TRUE}
missing <- sum(is.na(act))
```
The total number of missing values in the dataset is `r missing`.

<br>

#### 2. Devise a strategy for filling in all of the missing values in the dataset. The strategy does not need to be sophisticated. For example, you could use the mean/median for that day, or the mean for that 5-minute interval, etc.
One popular method of imputation is the Multivariate Imputation by Chained Equations (MICE). A MICE procedure is useful because it accounts for uncertainty and generates imputations assuming the missingess is random. Please visit https://www.ncbi.nlm.nih.gov/pmc/articles/PMC3074241/ for more info on MICE. In R, use the mice package to conduct a MICE procedure - imputed:
```{r Question 3-2, echo=TRUE, cache=TRUE, results="hide"}
#date column is ignored for this procedure as it is not numerical and only the steps column is missing values
imputed <- mice(data = select(act, steps, interval), seed = 500)
```

<br>

#### 3. Create a new dataset that is equal to the original dataset but with the missing data filled in.
Inspect the distributions of the imputed data using summary. Select one of the imputation options with a similar distribution to the original data. Construct the new dataset with the imputed values - cact: 
```{r Question 3-3, echo=TRUE}
#summary(act$steps)
#summary(complete(imputed,1))
cact <- complete(imputed, 4) %>% tbl_df %>% bind_cols(as.data.frame(act$date))
names(cact) <- c("steps", "interval", "date")
```

<br> 

#### 4. Make a histogram of the total number of steps taken each day. Calculate and report the mean and median total number of steps taken per day. 
Repeat the steps from Questions 1-2 and 1-3 with the dataset with imputed values to construct a new histogram and mean and median values - total_steps_per_day, report:
```{r Question 3-4, echo = TRUE, results="asis"}
total_steps_per_day <- cact %>% group_by(date) %>% summarize(total_steps = sum(steps))
ggplot(total_steps_per_day, aes(x = total_steps)) + 
    geom_histogram(fill = "#00BFC4") +
    labs(title = "Histogram of the Total Number of Steps Taken Each Day", x = "Total Steps by Date", y = "Count") +
    theme(plot.title = element_text(hjust = 0.5))
report <- total_steps_per_day %>% summarize(`Mean Steps Per Day` = mean(total_steps), `Median Steps Per Day` = median(total_steps))
pandoc.table(report)
```

<br>

##### Do these values differ from the estimates from the first part of the assignment? 
Yes, the mean total steps per day is about 12 steps less than the mean value for the original data. However, the median is the same as the median of the total steps of the original data. The histogram does have different counts for the total steps per day values, but athe distribution of these values is very close to its distribution before the imputation.

<br>

#### What is the impact of imputing missing data on the estimates of the total daily number of steps?
Looking at these three summaries of the data, the mean, median, and histogram, the MICE imputation did not considerably impact the summaries of the total daily number of steps. 

In general, it is worth noting that depending on which imputation you chose out of the multiple completed, the mean and median could have differed in many possible ways from the original values. Usually, one would utilize all the imputations completed if using MICE procedures to draw inferences about the data. However, in this case, I just selected one with similar summary statistics to the original data, giving preference to the distribution of the original data rather than the many possible random shifts in that distribution that the MICE imputations allow you to simulate.

* * *

### Part 4: Are there differences in activity patterns between weekdays and weekends?
While there is much less data for weekend days compared to weekdays, there does appear to be a difference in activity patterns between the two types of days. Relative to weekdays, weekends involve more overall activity with greater variation in activity and higher activity between the 1000 and 2000 interval.

#### 1. Create a new factor variable in the dataset with two levels – “weekday” and “weekend” indicating whether a given date is a weekday or weekend day.
Use dplyr to add a new column with either weekend or weekday as the levels of a factor vector based on which day of the week each date was - cact$daytype:
```{r Question 4-1, echo=TRUE}
cact <- mutate(cact, daytype = ifelse(wday(date) %in% c(1,7), "weekend", "weekday"))
cact$daytype <- factor(cact$daytype)
```

<br>

#### 2. Make a panel plot containing a time series plot (i.e. 𝚝𝚢𝚙𝚎 = "𝚕") of the 5-minute interval (x-axis) and the average number of steps taken, averaged across all weekday days or weekend days (y-axis). See the README file in the GitHub repository to see an example of what this plot should look like using simulated data.
Summarize the new data grouping by interval to find the average number of steps taken for each interval across all days. Then plot the data as vertical panels by day type - mean_steps_by_interval
```{r Question 4-2, echo=TRUE}
mean_steps_by_interval <- cact %>% group_by(interval, daytype) %>% summarise(mean_steps = mean(steps, na.rm = TRUE))
ggplot(mean_steps_by_interval, aes(x =interval, y = mean_steps)) + 
    geom_line() +
    facet_grid(daytype~.) +
    labs(title = "Average Number of Steps Taken by 5-Minute Interval and Day Type", x = "Interval", y = "Average Steps Taken") +
    theme(plot.title = element_text(hjust = 0.5))
```


