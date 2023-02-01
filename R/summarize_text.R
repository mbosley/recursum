#' Summarize text using GPT-3 API
#'
#' @param text The text to be summarized
#' @param prompt Prompt to be provided to model
#' @param model Model to be used
#' @param max_chars Maximum number of characters to use
#' @param split Boolean indicating whether to split speech into chunks
#' of `max_chars` size.
#' @param split_on_newline boolean indicating whether to split on newline
#' @param gather_chunks boolean indicating whether to gather chunks together based on max_chars
#' @param max_chunks integer indicating maximum number of chunks
#' @param verbose boolean indicating whether to include update messages or not
#'
#' @return A summary of the input text
#'
#' @export
summarize_text <- function(text,
                           prompt = "Please summarize the following text:\n\nTEXT:\n",
                           chunk_prompt = "Integrate the following chunk into the existing summary so that they form a new coherent summary.\n\nSUMMARY:\n",
                           model = "text-curie-001",
                           max_chars = 2000,
                           split = TRUE,
                           split_on_newline = FALSE,
                           gather_chunks = FALSE,
                           max_chunks = 10,
                           chunk_summary_strategy = c("separate", "summarize", "recursive"),
                           output_format = "SUMMARY",
                           verbose = TRUE) {


  chunks <- split_chunks(
    split, text, max_chars, max_chunks,
    split_on_newline, gather_chunks
  )

  for (chunk in chunks) {
    prompt <- paste0(
        prompt, paste0(chunk, "\n\n", output_format, ":\n")
      )
  }

  summary <- ""
  chunk_count <- 1
  for (chunk in chunks){
    # Use GPT-3 to summarize the text
    if (chunk_count > 1) {
      chunk_prompt_all <- paste0(
        chunk_prompt,
        summary,
        "\n\nCHUNK:\n",
        chunk,
        paste0("\n\nNEW ", output, ":\n")
      )
    } else {
      chunk_prompt_all <- paste0(
        prompt,
        paste0(chunk, "\n\n", output, ":\n")
      )
    }

    if (verbose) {
      message(paste0("Processing chunk ", chunk_count, " of ", length(chunks)))
    }

    response <- openai::create_completion(
                          engine = model,
                          max_tokens = 1000,
                          temperature = 0,
                          prompt = chunk_prompt_all
                        )
    summary <- response$choices[1]$text

    if (verbose) {
      message(paste0("CURRENT ", output, ":\n\n ", summary))
    }

    chunk_count <- chunk_count + 1
  }
  return(summary)
}
