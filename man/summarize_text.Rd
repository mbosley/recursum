% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/summarize_text.R
\name{summarize_text}
\alias{summarize_text}
\title{Summarize text using GPT-3 API}
\usage{
summarize_text(
  text,
  prompt = "Please summarize the following text:\\n\\nTEXT:\\n",
  chunk_prompt =
    "Integrate the following chunk into the existing summary so that they form a new coherent summary.\\n\\nSUMMARY:\\n",
  model = "text-curie-001",
  max_chars = 2000,
  split = TRUE,
  split_on_newline = FALSE,
  gather_chunks = FALSE,
  max_chunks = 10,
  chunk_summary_strategy = c("separate", "summarize", "recursive"),
  output_format = "SUMMARY",
  verbose = TRUE
)
}
\arguments{
\item{text}{The text to be summarized}

\item{prompt}{Prompt to be provided to model}

\item{model}{Model to be used}

\item{max_chars}{Maximum number of characters to use}

\item{split}{Boolean indicating whether to split speech into chunks
of \code{max_chars} size.}

\item{split_on_newline}{boolean indicating whether to split on newline}

\item{gather_chunks}{boolean indicating whether to gather chunks together based on max_chars}

\item{max_chunks}{integer indicating maximum number of chunks}

\item{verbose}{boolean indicating whether to include update messages or not}
}
\value{
A summary of the input text
}
\description{
Summarize text using GPT-3 API
}
