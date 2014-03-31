Trying to solve http://web.archive.org/web/20130215052516/http://rubyquiz.com/quiz44.html.

My general strategy is as follows:
Beginning with the original word, cut down the dictionary to only include words of the same length. This will be your wordbank.

Create a Hash that will contain keys of words, and values of words that are one letter different from the original word. To start, it will be empty.

Create a word queue, beginning with the original word. Check each word in the wordbank, and compare the letters of the wordbank to the letters of your current word. If a word is one letter different from the current word being checked, three things happen:
1. I add it to the hash with the key as "{ wordbank-word => current-word}".
2. I remove the new word from the wordbank
3. I add the new word to the end of the queue.

If a word is one letter different from the final word, the search ends. You can then use the hash of words and one-letter-different words to find the path back to the original word (follow the breadcrumbs).

If the queue is empty and the final word is not found, then there is no path from our current words to the final words, and the search ends and nil is returned.
