# Recursum - An R package for summarizing text data using OpenAI's GPT-3

Recursum is an R package that interfaces with the OpenAI API to use GPT-3 models to summarize text data. This package provides two main functions summarize_text and recursive_summarize to summarize a given text or a dataset respectively.

## Installation

To install Recursum, you need the devtools package installed on your machine. Then, you can use the following code to install the package:

``` R
if (!require(remotes))
    install.packages("remotes")
remotes::install_github("mbosley/recursum")
```

## Accessing the OpenAI API
The simplest way to access the OpenAI API is to use:

``` R
Sys.setenv(
    OPENAI_API_KEY = 'xxxxxx'
)
```
Replace the 'xxxxxx' with your OpenAI API key, but be sure not to accidentally upload it to GitHub!
Please keep in mind that depending on the amount of data you're summarizing and the model you're using, you quickly start to incur costs on your OpenAI account. Please start with a small sample of your data.


## `summarize_text` function

The `summarize_text` function takes in a text, and returns its summary. The function also takes several optional parameters to control the summarization process.

### Parameters
- text: The text to be summarized.
- prompt: A string used as a prompt for GPT-3 (default: "Please summarize the following text:\n\nTEXT:\n").
- chunk_prompt: A string used as a prompt for the text chunks to be summarized (default: "Integrate the following chunk into the existing summary so that they form a new coherent summary.\n\nSUMMARY:\n").
- model: The name of the GPT-3 model to use (default: "text-curie-001").
- max_chars: The maximum number of characters to be used for summarization (default: 2000).
- split: A boolean indicating whether to split speech into chunks of max_chars size (default: TRUE).
- split_on_newline: A boolean indicating whether to split on newline (default: FALSE).
- gather_chunks: A boolean indicating whether to gather chunks together based on max_chars (default: FALSE).
- max_chunks: The maximum number of chunks to be created (default: 10).
- chunk_summary_strategy: A string indicating the strategy to summarize the chunks (default: "separate").
- output_format: A string indicating the format of the output (default: "SUMMARY").
- verbose: A boolean indicating whether to include update messages or not (default: TRUE).
### Return value
The summarize_text function returns a summary of the input text.

## `recursive_summarize` function

The recursive_summarize function takes in a dataset, and returns the dataset with added columns for the summaries at each level of recursion. The function also takes several optional parameters to control the summarization process.

### Parameters
- dataset: The dataset to be summarized.
- groups: The variables by which the dataset should be grouped.
- prompts: A set of strings used as prompts for each level of recursion.
- level: The number of levels of recursion (default: 1).
### Return value
The recursive_summarize function returns the input dataset with added columns for the summaries at each level of recursion.

## Examples

Here are some examples of how you can use the recursum package to summarize your text data:

### Summarizing a single piece of text

``` R
text <- "This is an example text. This text has multiple sentences, and it's meant to be summarized. The goal of this example is to show how you can use the `recursum` package to summarize text data."

recursum::summarize_text(text)
```

This will return a summarized version of the input text, which has been generated using OpenAI's GPT-3.

### Recursively summarizing a dataset

``` R
# Load required libraries
library(dplyr)
library(stringr)

# Create a sample dataset
speaker_day_dataset <- data.frame(
  speaker = c(rep("Speaker 1", 3), rep("Speaker 2", 3)),
  day = c(rep(1, 3), rep(2, 3)),
  text = c("Speaker 1 says something on day 1", 
           "Speaker 1 says something else on day 1", 
           "Speaker 1 says a third thing on day 1",
           "Speaker 2 says something on day 2", 
           "Speaker 2 says something else on day 2", 
           "Speaker 2 says a third thing on day 2")
)

# Define the groups and prompts
groups <- c("speaker", "day")
prompts <- c("Please summarize the following text for speaker ",
             "Please summarize the following text for day ")

# Use the recursive_summarize function to summarize the dataset
recursive_summarized_dataset <- recursive_summarize(
  speaker_day_dataset, groups, prompts
)

recursive_summarized_dataset
```

The result will be a new dataset with added columns for the summaries at each level of recursion.
