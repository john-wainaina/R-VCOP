
# Calculate the percentage of missing values per column

sapply(combined, function(x)  sum(is.na(x)))

sapply(combined, function(x)  sum(is.na(x))/nrow(combined) * 100)

sapply(combined, function(x) sum(is.na(x))/length(x) * 100)

colMeans(is.na(combined)) * 100

combined %>% summarise_all( ~ mean(is.na(.)) * 100)

apply(combined, 2, function(x) sum(is.na(x))/length(x) * 100)

apply(combined, 2, \(x) sum(is.na(x))/length(x) *100)

fns <- function(x) sum(is.na(x))/length(x)*100

purrr::map(combined, fns)


library(naniar)
miss_var_summary(combined, percent = TRUE) %>% View()


# Calculate summaries of every numeric variables ## mean

combined %>% select_if(is.numeric)

Filter(is.numeric, combined)

combined %>% select(where(is.numeric))

combined %>% summarise(across(where(is.numeric), mean, na.rm = T))

sapply(combined[, sapply(combined, is.numeric)], mean, na.rm = T)

sapply(combined[, sapply(combined, is.numeric)], mean, na.rm = T)

x = combined[sapply(combined, is.numeric)]

colMeans(x, na.rm = T)


# assuming `combined` is a data frame with numeric columns ## using purrr::map
x <- combined[sapply(combined, is.numeric)]

mean_fn <- function(col){
  mean(x[[col]], na.rm = TRUE)
}

purrr::map(names(x), mean_fn)

combined %>%
  summarise(
    across(
      .cols  = is.numeric, #everything(),
      .fns   = mean, na.rm = T,
      .names = "{col}_mean"
    )
  )



