library(dplyr)

beeton_raw <- readLines("https://www.gutenberg.org/cache/epub/50191/pg50191.txt")

beeton <- beeton_raw |>
  tibble() |>
  rename(text = beeton_raw) |>
  filter(trimws(text) != "") |>
  mutate(text = gsub("[=_]", "", text)) |>
  slice(70:24171)

usethis::use_data(beeton, overwrite = TRUE)
