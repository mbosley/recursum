#' Split a string into groups of a given length
#'
#' @param x A character string to split into groups
#' @param n The number of characters in each group
#' @return A character vector containing the split groups
#' @examples
#' split_group("abcdefghijklmnopqrstuvwxyz", 5)
#' #> "abcde" "fghij" "klmno" "pqrst" "uvwxy" "z"
split_group <- function(x, n) {
  if (nchar(x) <= n) {
    return(x)
  } else {
      beginning <- substring(x, 1, n)
      remaining <- substring(x, n + 1)
      return(c(beginning, split_group(remaining, n)))
  }
}
