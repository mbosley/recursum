#' Split text into chunks
#'
#' This function splits text into chunks of a specified maximum number of characters. If the split argument is set to TRUE, the text will be split into groups of the specified max_chars. If set to FALSE, the text will be split into one chunk of the specified max_chars.
#'
#' @param split logical indicating whether to split text into groups of max_chars (TRUE) or one chunk of max_chars (FALSE) # nolint
#' @param text character vector of text to be split
#' @param max_chars integer indicating the maximum number of characters per chunk
#' @param max_chunks integer indicating maximum number of chunks
#' @param split_on_newline boolean indicating whether to split on newline
#' @param gather_chunks boolean indicating whether to gather chunks together based on max_chars
#' @return a list of character vectors representing the chunks of text
#' @examples
#' text <- "This is some text that I want to split into chunks."
#' split_chunks(TRUE, text, 10)
#' split_chunks(FALSE, text, 10)
split_chunks <- function(split, text, max_chars, max_chunks, split_on_newline = FALSE, gather_chunks = FALSE) {


  #' This function takes in two parameters: str_list and max_chars.
  #' It loops through each string in str_list and checks if the current string's length plus the total length of the previous strings is less than or equal to max_chars.
  #' If it is, it adds the length of the current string to the total and increments the count of sequential strings. If it's not, it updates the maximum number of sequential strings and resets the total length and count of sequential strings. Finally, it returns the maximum number of sequential strings, either from the loop or the last iteration.
  max_seq_strings <- function(str_list, max_chars) {
    total_chars <- 0
    max_seq <- 0
    seq_count <- 0

    for (str in str_list) {
      str_length <- nchar(str)
      if (total_chars + str_length <= max_chars) {
        total_chars <- total_chars + str_length
        seq_count <- seq_count + 1
      } else {
        max_seq <- max(max_seq, seq_count)
        total_chars <- str_length
        seq_count <- 1
      }
    }

    return(max(max_seq, seq_count))
  }

  if (split) {
    if (split_on_newline) {
      chunks <- unlist(strsplit(text, "\n\n"))
    } else {
      chunks <- split_group(text, max_chars)
    }
  } else {
    chunks <- list(substr(text, start = 1, stop = max_chars))
  }

  # remove newlines from chunks
  chunks <- lapply(chunks, gsub, pattern = "\\n\\n", replacement = "")

  if (gather_chunks) {
    new_chunks <- list()
    chunk_counter <- 1
    repeat {
      max_allowed_chunks <- max_seq_strings(chunks, max_chars)
      if (max_allowed_chunks <= 1) {
        break
      }
      new_chunks[chunk_counter] <- paste0(
        chunks[1:max_allowed_chunks],
        collapse = "\n\n"
      )
      chunks <- chunks[-c(1:max_allowed_chunks)]
      chunk_counter <- chunk_counter + 1
    }
    chunks <- new_chunks
  }

  return(chunks)
}
