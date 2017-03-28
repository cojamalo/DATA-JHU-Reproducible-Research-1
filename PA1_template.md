### Submission by Connor Lenio. Email: <cojamalo@gmail.com>

Completion Date: Mar 27, 2017

### Introduction to the Data

Please view the README.md for the background information for this project.

### Load packages

``` r
library(data.table)
library(mice)
library(pander)
library(ggplot2)
library(lubridate)
library(dplyr)
```

### Load and Process data

Use fread to quickly read in the data to R and convert the data column to the date class using lubridate - act:

``` r
act <- fread("activity.csv", header= TRUE, na.strings = "NA") %>% tbl_df
act$date <- ymd(act$date)
```

------------------------------------------------------------------------

### Part 1: What is mean total number of steps taken per day?

The mean total number of steps taken per day is 10766.2.

<br>

#### 1. Calculate the total number of steps taken per day

Ignore NA values and summarize by date to get the total number of steps for each day recorded in the data - total\_steps\_per\_day:

``` r
total_steps_per_day <- act %>% filter(!is.na(steps)) %>% group_by(date) %>% summarize(total_steps = sum(steps))
pandoc.table(total_steps_per_day)
```

<table style="width:33%;">
<colgroup>
<col width="15%" />
<col width="18%" />
</colgroup>
<thead>
<tr class="header">
<th align="center">date</th>
<th align="center">total_steps</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="center">2012-10-02</td>
<td align="center">126</td>
</tr>
<tr class="even">
<td align="center">2012-10-03</td>
<td align="center">11352</td>
</tr>
<tr class="odd">
<td align="center">2012-10-04</td>
<td align="center">12116</td>
</tr>
<tr class="even">
<td align="center">2012-10-05</td>
<td align="center">13294</td>
</tr>
<tr class="odd">
<td align="center">2012-10-06</td>
<td align="center">15420</td>
</tr>
<tr class="even">
<td align="center">2012-10-07</td>
<td align="center">11015</td>
</tr>
<tr class="odd">
<td align="center">2012-10-09</td>
<td align="center">12811</td>
</tr>
<tr class="even">
<td align="center">2012-10-10</td>
<td align="center">9900</td>
</tr>
<tr class="odd">
<td align="center">2012-10-11</td>
<td align="center">10304</td>
</tr>
<tr class="even">
<td align="center">2012-10-12</td>
<td align="center">17382</td>
</tr>
<tr class="odd">
<td align="center">2012-10-13</td>
<td align="center">12426</td>
</tr>
<tr class="even">
<td align="center">2012-10-14</td>
<td align="center">15098</td>
</tr>
<tr class="odd">
<td align="center">2012-10-15</td>
<td align="center">10139</td>
</tr>
<tr class="even">
<td align="center">2012-10-16</td>
<td align="center">15084</td>
</tr>
<tr class="odd">
<td align="center">2012-10-17</td>
<td align="center">13452</td>
</tr>
<tr class="even">
<td align="center">2012-10-18</td>
<td align="center">10056</td>
</tr>
<tr class="odd">
<td align="center">2012-10-19</td>
<td align="center">11829</td>
</tr>
<tr class="even">
<td align="center">2012-10-20</td>
<td align="center">10395</td>
</tr>
<tr class="odd">
<td align="center">2012-10-21</td>
<td align="center">8821</td>
</tr>
<tr class="even">
<td align="center">2012-10-22</td>
<td align="center">13460</td>
</tr>
<tr class="odd">
<td align="center">2012-10-23</td>
<td align="center">8918</td>
</tr>
<tr class="even">
<td align="center">2012-10-24</td>
<td align="center">8355</td>
</tr>
<tr class="odd">
<td align="center">2012-10-25</td>
<td align="center">2492</td>
</tr>
<tr class="even">
<td align="center">2012-10-26</td>
<td align="center">6778</td>
</tr>
<tr class="odd">
<td align="center">2012-10-27</td>
<td align="center">10119</td>
</tr>
<tr class="even">
<td align="center">2012-10-28</td>
<td align="center">11458</td>
</tr>
<tr class="odd">
<td align="center">2012-10-29</td>
<td align="center">5018</td>
</tr>
<tr class="even">
<td align="center">2012-10-30</td>
<td align="center">9819</td>
</tr>
<tr class="odd">
<td align="center">2012-10-31</td>
<td align="center">15414</td>
</tr>
<tr class="even">
<td align="center">2012-11-02</td>
<td align="center">10600</td>
</tr>
<tr class="odd">
<td align="center">2012-11-03</td>
<td align="center">10571</td>
</tr>
<tr class="even">
<td align="center">2012-11-05</td>
<td align="center">10439</td>
</tr>
<tr class="odd">
<td align="center">2012-11-06</td>
<td align="center">8334</td>
</tr>
<tr class="even">
<td align="center">2012-11-07</td>
<td align="center">12883</td>
</tr>
<tr class="odd">
<td align="center">2012-11-08</td>
<td align="center">3219</td>
</tr>
<tr class="even">
<td align="center">2012-11-11</td>
<td align="center">12608</td>
</tr>
<tr class="odd">
<td align="center">2012-11-12</td>
<td align="center">10765</td>
</tr>
<tr class="even">
<td align="center">2012-11-13</td>
<td align="center">7336</td>
</tr>
<tr class="odd">
<td align="center">2012-11-15</td>
<td align="center">41</td>
</tr>
<tr class="even">
<td align="center">2012-11-16</td>
<td align="center">5441</td>
</tr>
<tr class="odd">
<td align="center">2012-11-17</td>
<td align="center">14339</td>
</tr>
<tr class="even">
<td align="center">2012-11-18</td>
<td align="center">15110</td>
</tr>
<tr class="odd">
<td align="center">2012-11-19</td>
<td align="center">8841</td>
</tr>
<tr class="even">
<td align="center">2012-11-20</td>
<td align="center">4472</td>
</tr>
<tr class="odd">
<td align="center">2012-11-21</td>
<td align="center">12787</td>
</tr>
<tr class="even">
<td align="center">2012-11-22</td>
<td align="center">20427</td>
</tr>
<tr class="odd">
<td align="center">2012-11-23</td>
<td align="center">21194</td>
</tr>
<tr class="even">
<td align="center">2012-11-24</td>
<td align="center">14478</td>
</tr>
<tr class="odd">
<td align="center">2012-11-25</td>
<td align="center">11834</td>
</tr>
<tr class="even">
<td align="center">2012-11-26</td>
<td align="center">11162</td>
</tr>
<tr class="odd">
<td align="center">2012-11-27</td>
<td align="center">13646</td>
</tr>
<tr class="even">
<td align="center">2012-11-28</td>
<td align="center">10183</td>
</tr>
<tr class="odd">
<td align="center">2012-11-29</td>
<td align="center">7047</td>
</tr>
</tbody>
</table>

<br>

#### 2. Make a histogram of the total number of steps taken each day

Plot the distribution of the summarized data above:

``` r
ggplot(total_steps_per_day, aes(x = total_steps)) + 
    geom_histogram(fill = "#F8766D") +
    labs(title = "Histogram of the Total Number of Steps Taken Each Day", x = "Total Steps by Date", y = "Count") +
    theme(plot.title = element_text(hjust = 0.5))
```

    ## `stat_bin()` using `bins = 30`. Pick better value with `binwidth`.

![](PA1_template_files/figure-markdown_github/Question%201-2-1.png)

<br>

#### 3. Calculate and report the mean and median of the total number of steps taken per day

Using the summarized data above, find the average and median for the total number of steps taken per day - report:

``` r
report <- total_steps_per_day %>% summarize(`Mean Steps Per Day` = mean(total_steps), `Median Steps Per Day` = median(total_steps))

pandoc.table(report)
```

<table style="width:60%;">
<colgroup>
<col width="29%" />
<col width="30%" />
</colgroup>
<thead>
<tr class="header">
<th align="center">Mean Steps Per Day</th>
<th align="center">Median Steps Per Day</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="center">10766.19</td>
<td align="center">10765</td>
</tr>
</tbody>
</table>

------------------------------------------------------------------------

### Part 2: What is the average daily activity pattern?

The average daily activity pattern involves around zero average steps taken at the beginning of the daily intervals, with a rapid increase in the amount of steps taken occuring after the 500 interval until the 835 interval. After the max around the 835 interval, the average steps taken drops until just before the 1000 interval where it varies between about 25 and 100 average steps per interval until the 2000 interval when a drop to near zero average steps occurs.

<br>

#### 1. Make a time series plot (i.e. 𝚝𝚢𝚙𝚎 = "𝚕") of the 5-minute interval (x-axis) and the average number of steps taken, averaged across all days (y-axis)

Summarize the data grouping by interval to find the average number of steps taken for each interval across all days - mean\_steps\_by\_interval:

``` r
mean_steps_by_interval <- act %>% group_by(interval) %>% summarise(mean_steps = mean(steps, na.rm = TRUE))
ggplot(mean_steps_by_interval, aes(x =interval, y = mean_steps)) + 
    geom_line(col = "#F8766D") +
    labs(title = "Average Number of Steps Taken by 5-Minute Interval for All Days", x = "Interval", y = "Average Steps Taken") +
    theme(plot.title = element_text(hjust = 0.5))
```

![](PA1_template_files/figure-markdown_github/Question%202-1-1.png) <br>

#### 2. Which 5-minute interval, on average across all the days in the dataset, contains the maximum number of steps?

Determine the interval that contains the maximum value for the average total steps using which.max - max\_steps\_interval:

``` r
max_steps_interval <- which.max(mean_steps_by_interval$mean_steps)
max_steps_interval <- mean_steps_by_interval$interval[max_steps_interval]
```

The 835 interval is the interval that contains the maximum number of average steps for all days.

------------------------------------------------------------------------

### Part 3: Imputing missing values

#### 1. Calculate and report the total number of missing values in the dataset (i.e. the total number of rows with 𝙽𝙰s)

Use is.na to count the number of rows with missing data - missing:

``` r
missing <- sum(is.na(act))
```

The total number of missing values in the dataset is 2304.

<br>

#### 2. Devise a strategy for filling in all of the missing values in the dataset. The strategy does not need to be sophisticated. For example, you could use the mean/median for that day, or the mean for that 5-minute interval, etc.

One popular method of imputation is the Multivariate Imputation by Chained Equations (MICE). A MICE procedure is useful because it accounts for uncertainty and generates imputations assuming the missingess is random. Please visit <https://www.ncbi.nlm.nih.gov/pmc/articles/PMC3074241/> for more info on MICE. In R, use the mice package to conduct a MICE procedure - imputed:

``` r
#date column is ignored for this procedure as it is not numerical and only the steps column is missing values
imputed <- mice(data = select(act, steps, interval), seed = 500)
```

<br>

#### 3. Create a new dataset that is equal to the original dataset but with the missing data filled in.

Inspect the distributions of the imputed data using summary. Select one of the imputation options with a similar distribution to the original data. Construct the new dataset with the imputed values - cact:

``` r
#summary(act$steps)
#summary(complete(imputed,1))
cact <- complete(imputed, 4) %>% tbl_df %>% bind_cols(as.data.frame(act$date))
names(cact) <- c("steps", "interval", "date")
```

<br>

#### 4. Make a histogram of the total number of steps taken each day. Calculate and report the mean and median total number of steps taken per day.

Repeat the steps from Questions 1-2 and 1-3 with the dataset with imputed values to construct a new histogram and mean and median values - total\_steps\_per\_day, report:

``` r
total_steps_per_day <- cact %>% group_by(date) %>% summarize(total_steps = sum(steps))
ggplot(total_steps_per_day, aes(x = total_steps)) + 
    geom_histogram(fill = "#00BFC4") +
    labs(title = "Histogram of the Total Number of Steps Taken Each Day", x = "Total Steps by Date", y = "Count") +
    theme(plot.title = element_text(hjust = 0.5))
```

    ## `stat_bin()` using `bins = 30`. Pick better value with `binwidth`.

![](PA1_template_files/figure-markdown_github/Question%203-4-1.png)

``` r
report <- total_steps_per_day %>% summarize(`Mean Steps Per Day` = mean(total_steps), `Median Steps Per Day` = median(total_steps))
pandoc.table(report)
```

<table style="width:60%;">
<colgroup>
<col width="29%" />
<col width="30%" />
</colgroup>
<thead>
<tr class="header">
<th align="center">Mean Steps Per Day</th>
<th align="center">Median Steps Per Day</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="center">10754.25</td>
<td align="center">10765</td>
</tr>
</tbody>
</table>

<br>

##### Do these values differ from the estimates from the first part of the assignment?

Yes, the mean total steps per day is about 12 steps less than the mean value for the original data. However, the median is the same as the median of the total steps of the original data. The histogram does have different counts for the total steps per day values, but athe distribution of these values is very close to its distribution before the imputation.

<br>

#### What is the impact of imputing missing data on the estimates of the total daily number of steps?

Looking at these three summaries of the data, the mean, median, and histogram, the MICE imputation did not considerably impact the summaries of the total daily number of steps.

In general, it is worth noting that depending on which imputation you chose out of the multiple completed, the mean and median could have differed in many possible ways from the original values. Usually, one would utilize all the imputations completed if using MICE procedures to draw inferences about the data. However, in this case, I just selected one with similar summary statistics to the original data, giving preference to the distribution of the original data rather than the many possible random shifts in that distribution that the MICE imputations allow you to simulate.

------------------------------------------------------------------------

### Part 4: Are there differences in activity patterns between weekdays and weekends?

While there is much less data for weekend days compared to weekdays, there does appear to be a difference in activity patterns between the two types of days. Relative to weekdays, weekends involve more overall activity with greater variation in activity and higher activity between the 1000 and 2000 interval.

#### 1. Create a new factor variable in the dataset with two levels – “weekday” and “weekend” indicating whether a given date is a weekday or weekend day.

Use dplyr to add a new column with either weekend or weekday as the levels of a factor vector based on which day of the week each date was - cact$daytype:

``` r
cact <- mutate(cact, daytype = ifelse(wday(date) %in% c(1,7), "weekend", "weekday"))
cact$daytype <- factor(cact$daytype)
```

<br>

#### 2. Make a panel plot containing a time series plot (i.e. 𝚝𝚢𝚙𝚎 = "𝚕") of the 5-minute interval (x-axis) and the average number of steps taken, averaged across all weekday days or weekend days (y-axis). See the README file in the GitHub repository to see an example of what this plot should look like using simulated data.

Summarize the new data grouping by interval to find the average number of steps taken for each interval across all days. Then plot the data as vertical panels by day type - mean\_steps\_by\_interval

``` r
mean_steps_by_interval <- cact %>% group_by(interval, daytype) %>% summarise(mean_steps = mean(steps, na.rm = TRUE))
ggplot(mean_steps_by_interval, aes(x =interval, y = mean_steps)) + 
    geom_line() +
    facet_grid(daytype~.) +
    labs(title = "Average Number of Steps Taken by 5-Minute Interval and Day Type", x = "Interval", y = "Average Steps Taken") +
    theme(plot.title = element_text(hjust = 0.5))
```

![](PA1_template_files/figure-markdown_github/Question%204-2-1.png)
