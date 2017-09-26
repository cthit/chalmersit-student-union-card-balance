FROM ruby:2.4.2

ENV PHANTOM_JS "phantomjs-2.1.1-linux-x86_64"

RUN apt-get update && \
  apt-get install -y net-tools curl bzip2 libfreetype6 libfontconfig && \
  curl -sSL -O https://bitbucket.org/ariya/phantomjs/downloads/$PHANTOM_JS.tar.bz2 && \
  tar xvjf $PHANTOM_JS.tar.bz2 && \
  mv $PHANTOM_JS /usr/local/share && \
  ln -sf /usr/local/share/$PHANTOM_JS/bin/phantomjs /usr/local/bin && \
  mkdir -p /root/.phantomjs/2.4.2/x86_64-linux/bin && \
  ln -sf /usr/local/share/$PHANTOM_JS/bin/phantomjs /root/.phantomjs/2.4.2/x86_64-linux/bin/phantomjs && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

# Set locale
ENV LANG C.UTF-8

# Install gems
ENV APP_HOME /app
ENV HOME /root
RUN mkdir $APP_HOME
WORKDIR $APP_HOME
COPY Gemfile* $APP_HOME/
RUN bundle install

# Upload source
COPY . $APP_HOME

RUN useradd ruby
USER ruby

# Start server
ENV PORT 3000
EXPOSE 3000
CMD ["ruby", "app.rb"]
