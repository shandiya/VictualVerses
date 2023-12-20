#' Get a random string with exactly 17 syllables
#'
#' @param book Input text. A dataframe or tibble, with character strings in
#'   each row
#'
#' @return A character string with 17 syllables
#' @importFrom nsyllable nsyllable
#' @export

get_verses <- function(book) {

  correct_count <- FALSE

  while (correct_count == FALSE) {

    choose_row <- sample(1:nrow(book), size = 1)

    word_count <- length(strsplit(book$text[choose_row], "\\s+")[[1]])
    choose_start_word <- sample(1:word_count, size = 1)

    words_in_row <- strsplit(book$text[choose_row], "\\s+")[[1]]
    start_string <- paste(words_in_row[choose_start_word:length(words_in_row)],
                          collapse = " ")

    text_to_sample <- paste(start_string,
                            book$text[choose_row + 1],
                            book$text[choose_row + 2],
                            collapse = " ")

    split_string <- strsplit(text_to_sample, "\\s+")[[1]]

    syllable_count <- nsyllable(split_string)

    cumulative_syllable_count <- cumsum(syllable_count)

    correct_count <- all(c(5, 12, 17) %in% cumulative_syllable_count)
  }

  i_5 <- which(cumulative_syllable_count == 5)
  line_1 <- paste(split_string[1:i_5], collapse = " ")

  i_12 <- which(cumulative_syllable_count == 12)
  line_2 <- paste(split_string[(i_5+1):i_12], collapse = " ")

  i_17 <- which(cumulative_syllable_count == 17)
  line_3 <- paste(split_string[(i_12+1):i_17], collapse = " ")

  verses <- paste(line_1, line_2, line_3, sep = "\n")

  return(verses)

}
