## ----message=FALSE-------------------------------------------------------
library(nycflights13)
library(ggplot2)
library(dplyr)
library(knitr)

## ----message=FALSE, warning=FALSE, echo=FALSE----------------------------
# Packages needed internally, but not in text.
library(gapminder)
library(knitr)

## ---- echo=FALSE---------------------------------------------------------
gapminder_2007 <- gapminder %>% 
  filter(year == 2007) %>% 
  select(-year) %>% 
  rename(
    Country = country,
    Continent = continent,
    `Life Expectancy` = lifeExp,
    `Population` = pop,
    `GDP per Capita` = gdpPercap
  )

## ---- echo=FALSE---------------------------------------------------------
gapminder_2007 %>% 
  head() %>% 
  kable(
    digits=2,
    caption = "Gapminder 2007 Data: First 6 of 142 countries", 
    booktabs = TRUE
  )

## ----gapminder, echo=FALSE, fig.cap="Life Expectancy over GDP per Capita in 2007"----
ggplot(data = gapminder_2007, mapping = aes(x=`GDP per Capita`, y=`Life Expectancy`, size=Population, col=Continent)) +
  geom_point()

## ---- echo=FALSE---------------------------------------------------------
map <- data_frame(
  `data variable` = c("GDP per Capita", "Life Expectancy", "Population", "Continent"),
  aes = c("x", "y", "size", "color"),
  geom = c("point", "point", "point", "point")
)

map %>% 
  kable(
    caption = "Summary of Grammar of Graphics for this plot", 
    booktabs = TRUE
    )

## **_Review questions_**

## ------------------------------------------------------------------------
all_alaska_flights <- flights %>% 
  filter(carrier == "AS")

## **Learning Check Solutions**

## ----noalpha, fig.cap="Arrival Delays vs Departure Delays for Alaska Airlines flights from NYC in 2013"----
ggplot(data = all_alaska_flights, mapping = aes(x = dep_delay, y = arr_delay)) + 
  geom_point()

## ----nolayers, fig.cap="Plot with No Layers"-----------------------------
ggplot(data = all_alaska_flights, mapping = aes(x = dep_delay, y = arr_delay))

## **Learning Check Solutions**

## ---- include=show_solutions('3-2'), echo=show_solutions('3-2')----------
ggplot(data = all_alaska_flights, mapping = aes(x = dep_time, y = dep_delay)) +
  geom_point()

## ----alpha, fig.cap="Delay scatterplot with alpha=0.2"-------------------
ggplot(data = all_alaska_flights, mapping = aes(x = dep_delay, y = arr_delay)) + 
  geom_point(alpha = 0.2)

## ----jitter, fig.cap="Jittered delay scatterplot"------------------------
ggplot(data = all_alaska_flights, mapping = aes(x = dep_delay, y = arr_delay)) + 
  geom_jitter(width = 30, height = 30)

## ---- eval = FALSE-------------------------------------------------------
## ggplot(data = all_alaska_flights, mapping = aes(x = dep_delay, y = arr_delay)) +
##   geom_jitter(width = 30, height = 30)
## ggplot(all_alaska_flights, aes(x = dep_delay, y = arr_delay)) +
##   geom_jitter(width = 30, height = 30)

## **Learning Check Solutions**

## ------------------------------------------------------------------------
early_january_weather <- weather %>% 
  filter(origin == "EWR" & month == 1 & day <= 15)

## **Learning Check Solutions**

## ----hourlytemp, fig.cap="Hourly Temperature in Newark for January 1-15, 2013"----
ggplot(data = early_january_weather, mapping = aes(x = time_hour, y = temp)) +
  geom_line()

## **Learning Check Solutions**

## ---- include=show_solutions('3-5'), echo=show_solutions('3-5')----------
ggplot(data = early_january_weather, mapping = aes(x = time_hour, y = humid)) +
  geom_line()

## ----echo=FALSE, fig.height=0.8, fig.cap="Plot of Hourly Temperature Recordings from NYC in 2013"----
ggplot(data = weather, mapping = aes(x = temp, y = factor("A"))) +
  geom_point() +
  theme(axis.ticks.y = element_blank(), 
        axis.title.y = element_blank(),
        axis.text.y = element_blank())
hist_title <- "Histogram of Hourly Temperature Recordings from NYC in 2013"

## ---- warning=TRUE, fig.cap=hist_title-----------------------------------
ggplot(data = weather, mapping = aes(x = temp)) +
  geom_histogram()

## ----fig.cap=paste(hist_title, "- 60 Bins")------------------------------
ggplot(data = weather, mapping = aes(x = temp)) +
  geom_histogram(bins = 60, color = "white")

## ----fig.cap=paste(hist_title, "- 60 Colored Bins")----------------------
ggplot(data = weather, mapping = aes(x = temp)) +
  geom_histogram(bins = 60, color = "white", fill = "steelblue")

## ----fig.cap=paste(hist_title, "- Binwidth = 10"), fig.height=5----------
ggplot(data = weather, mapping = aes(x = temp)) +
  geom_histogram(binwidth = 10, color = "white")

## **Learning Check Solutions**

## ---- echo=show_solutions('3-7'), include=show_solutions('3-7'), message=FALSE, warning=FALSE----
IQR(weather$temp, na.rm=TRUE)

## ---- echo=show_solutions('3-7'), include=show_solutions('3-7'), message=FALSE, warning=FALSE----
summary(weather$temp)

## ----facethistogram, fig.cap="Faceted histogram"-------------------------
ggplot(data = weather, mapping = aes(x = temp)) +
  geom_histogram(binwidth = 5, color = "white") +
  facet_wrap(~ month, nrow = 4)

## **Learning Check Solutions**

## ----badbox, fig.cap="Invalid boxplot specification", fig.height=3.5-----
ggplot(data = weather, mapping = aes(x = month, y = temp)) +
  geom_boxplot()

## ----monthtempbox, fig.cap="Month by temp boxplot", fig.height=3.7-------
ggplot(data = weather, mapping = aes(x = factor(month), y = temp)) +
  geom_boxplot()

## ----monthtempbox2, echo=FALSE, fig.cap="November boxplot", fig.height=3.7----
weather %>% 
  filter(month %in% c(11)) %>% 
  ggplot(mapping = aes(x = factor(month), y = temp)) +
  geom_boxplot()

## ----monthtempbox3, echo=FALSE, fig.cap="November boxplot with points", fig.height=3.7----
quartiles <- weather %>% filter(month == 11) %>% pull(temp) %>% quantile(prob=c(0.25, 0.5, 0.75))
weather %>% 
  filter(month %in% c(11)) %>% 
  ggplot(mapping = aes(x = factor(month), y = temp)) +
  geom_boxplot() +
  geom_jitter(width = 0.05, height = 0.5, alpha = 0.2)

## **Learning Check Solutions**

## ---- echo=FALSE, eval=FALSE---------------------------------------------
## weather %>%
##   filter(month==5 & temp < 25)

## ---- include=show_solutions('3-9'), echo=FALSE--------------------------
weather %>% 
  filter(month==5 & temp < 25) %>% 
  kable()

## There appears to be only one hour and only at JFK that recorded 13.1 F (-10.5 C) in the month of May. This is probably a data entry mistake!

## ---- echo=FALSE, eval=FALSE---------------------------------------------
## # weather %>%
## #   group_by(month) %>%
## #   summarize(IQR = IQR(temp, na.rm=TRUE)) %>%
## #   arrange(desc(IQR))

## ---- echo=FALSE, include=show_solutions('3-9')--------------------------
weather %>%
  group_by(month) %>%
  summarize(IQR = IQR(temp, na.rm=TRUE)) %>%
  arrange(desc(IQR)) %>%
  kable()

## **`r paste0("(LC", chap, ".", (lc - 1), ")")`: We looked at the distribution of a numerical variable over a categorical variable here with this boxplot. Why can't we look at the distribution of one numerical variable over the distribution of another numerical variable? Say, temperature across pressure, for example?**

## ------------------------------------------------------------------------
fruits <- data_frame(
  fruit = c("apple", "apple", "apple", "orange", "orange")
)
fruits_counted <- data_frame(
  fruit = c("apple", "orange"),
  number = c(3, 2)
)

## ---- echo=FALSE---------------------------------------------------------
kable(
    fruits,
    digits=2,
    caption = "Fruits", 
    booktabs = TRUE
  )

## ---- echo=FALSE---------------------------------------------------------
kable(
    fruits_counted,
    digits=2,
    caption = "Fruits (Pre-Counted)", 
    booktabs = TRUE
  )

## ----geombar, fig.cap="Barplot when counts are not pre-tabulated", fig.height=2.5----
ggplot(data = fruits, mapping = aes(x = fruit)) +
  geom_bar()

## ---- geomcol, fig.cap="Barplot when counts are pre-tabulated", fig.height=2.5----
ggplot(data = fruits_counted, mapping = aes(x = fruit, y = number)) +
  geom_col()

## ----flightsbar, fig.cap="Number of flights departing NYC in 2013 by airline using geom_bar", fig.height=2.5----
ggplot(data = flights, mapping = aes(x = carrier)) +
  geom_bar()

## ---- eval=FALSE---------------------------------------------------------
## airlines

## ---- echo=FALSE---------------------------------------------------------
kable(airlines)

## ----message=FALSE, eval=FALSE-------------------------------------------
## flights_table <- flights %>%
##   group_by(carrier) %>%
##   summarize(number = n())
## flights_table

## ----message=FALSE, echo=FALSE-------------------------------------------
flights_table <- flights %>% 
  group_by(carrier) %>% 
  summarize(number = n())
kable(flights_table)

## ----flightscol, fig.cap="Number of flights departing NYC in 2013 by airline using geom_col", fig.height=2.5----
ggplot(data = flights_table, mapping = aes(x = carrier, y = number)) +
  geom_col()

## **Learning Check Solutions**

## ----carrierpie, echo=FALSE, fig.cap="The dreaded pie chart", fig.height=5----
ggplot(flights, mapping = aes(x = factor(1), fill = carrier)) +
  geom_bar(width = 1) +
  coord_polar(theta = "y") +
  theme(axis.title.x = element_blank(), 
    axis.title.y = element_blank(),
    axis.ticks = element_blank(),
    axis.text.y = element_blank(),
    axis.text.x = element_blank(),
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank()) +
  guides(fill = guide_legend(keywidth = 0.8, keyheight = 0.8))

## **Learning Check Solutions**

## ----message=FALSE-------------------------------------------------------
flights_namedports <- flights %>% 
  inner_join(airports, by = c("origin" = "faa"))

## ---- fig.cap="Stacked barplot comparing the number of flights by carrier and airport", fig.height=3.5----
ggplot(data = flights_namedports, mapping = aes(x = carrier, fill = name)) +
  geom_bar()

## **Learning Check Solutions**

## ---- fig.cap="Side-by-side barplot comparing the number of flights by carrier and airport", fig.height=5----
ggplot(data = flights_namedports, mapping = aes(x = carrier, fill = name)) +
  geom_bar(position = "dodge")

## **Learning Check Solutions**

## ----facet-bar-vert, fig.cap="Faceted barplot comparing the number of flights by carrier and airport", fig.height=7.5----
ggplot(data = flights_namedports, mapping = aes(x = carrier, fill = name)) +
  geom_bar() +
  facet_grid(name ~ .)

## **Learning Check Solutions**

## ----viz-map, echo=FALSE, fig.cap="Mind map for Data Visualization", out.width="200%"----
#library(knitr)
#if(knitr:::is_html_output()){
#  include_url("https://coggle.it/diagram/V_G2gzukTDoQ-aZt-", 
#              height = "1000px")
#} else {
  include_graphics("images/coggleviz.png", dpi = 300)
#}

