#' Recursively summarize a dataset
#'
#' @param dataset The dataset to be summarized
#' @param groups The variables by which the dataset should be grouped
#' @param prompts A set of strings used as prompts for each level of recursion
#' @param level The number of levels of recursion
#
#'
#' @return The input dataset with added columns for the summaries at
#' each level of recursion
#'
#' @export
recursive_summarize <- function(dataset, groups, prompts, level = 1) {
  if (level == length(groups) + 1) {
    message("Summarization finished, ending")
    return(dataset)
  }

  # Create a new column for the current level of recursion
  new_col <- paste0(groups[level], "_summary")

  # define the previous column
  if (level == 1) {
    prev_col <- groups[1]
  } else {
    prev_col <- paste0(groups[level - 1], "_summary")
  }

  # Recursively call the function for the next level of recursion
  message(paste("Summarizing:", groups[level], collapse = " "))
  dataset <- dataset |>
    dplyr::group_by(!!rlang::sym(groups[level])) |>
    dplyr::mutate(
             !!new_col := stringr::str_c(
                                     !!rlang::sym(prev_col),
                                     collapse = "\n\n"
                                   ) |>
               summarize_text(prompt = prompts[level])
           )
  recursive_summarize(dataset, groups, prompts, level + 1)
}
