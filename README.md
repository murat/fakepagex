# Fakepage

_Bu proje [#ucbuyucuturnuvasi](https://ucbuyucuturnuvasi.com/) kapsaminda `Felix Felicis` takımının geliştirdiği bir projedir._

Fakepage generates a new text from a given text source. It is built on [Markov Chain Model](https://en.wikipedia.org/wiki/Markov_chain). You may want to use it to make new, reorganized, meaningful articles, news, stories, etc.

Also, this project has a crawler for web articles.

P.S: The webpage on given URL needs to paragraphs `<p></p>` tags in `<article></article>` objects.

![https://i.imgur.com/1lMzxGe.png](https://i.imgur.com/1lMzxGe.png)

## Installation

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## References

* [Markov chains in Elixir](https://neiro.io/2016-07-31-markov-chains-in-elixir.md.html)
* [Another markov chain implementation written in golang **by me**](https://github.com/murat/mark-go-v/blob/master/main.go)