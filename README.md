# Student union card balance fetcher
Service for chalmers.it, fetches the balance of a chalmers student union card.

## Development setup:
Install [phantomjs](http://phantomjs.org/). Then run the following:

```
gem install bundler
bundle
ruby app.rb
```


## Instructions for Docker

```bash
  docker build -t cthit/student-union-card-balance .
  docker run --rm -p 3000:3000 cthit/student-union-card-balance
```
