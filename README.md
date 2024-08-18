# FT Flow

Fine tuning flow for LLMs, going from creating a custom fine-tuning dataset to saving that model to ollama for downloading and using anywhere.

## Creating a custom fine-tuning dataset

First, let's justify when fine-tuning is even required. In my case I'm convinced I need to, but if you are unsure, I would invite you watch this [video](https://www.youtube.com/watch?v=4EPZZkVrXC4&list=PLgIaq8VgndJsQN0PPGJrMBzJCnDzbGwTv&index=3) about when FT is really necessary, and if still convinced, keep reading :-)

THe first problem we face when fine-tuning a model for a specific use case is that there may not enough data to train on. This could be because the data is isn't capturable, or this product may not even have been built yet! In this case, we can use a synthetic dataset to fine-tune the model.

This synthetic dataset is built with the key assumptions:

-   Within the largest publicly available chat datasets, some subset of that data is relevant to the fine-tuning task.
-   If you create a system prompt that captures all you want the goal FT to do or say, you can create a synthetic dataset that is similar to the data you want to fine-tune on.

Under these beliefs, the notebook `generate-chat-dataset.ipynb` will guide you through the process of creating a synthetic dataset for fine-tuning.

## Fine-tuning the model

Once you have the dataset, you can use the notebook `instruct-tune-llm.ipynb` to fine-tune the model on the dataset you created.

At the end of that notebook there are some instructions on how to save this model in a gguf format, which is already good enough on it's own for fast inference.

For an additional convenience, you can save this model to ollama, which will allow you to download it and use it anywhere. The text file `save-to-ollama.txt` will guide you through this process.

## Next steps

-   Creating synthetic preference datasets
-   Figure out how to evaluate the model on benchmarks like MMLU
-   Single file to run everything end to end
