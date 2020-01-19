Pastebim
========

A pastebim written in Nim.

## How to Use

### posting
making a paste is a POST request to either the field or file of a form, using
the `plugname` you specify in `config.toml` as a key.  For example, both of the
following should work:

```curl -F f=@data.txt http://your.server/```

or

```echo "😸" | curl -F "f=<-" http://your.server```

### reading 
to get pastes back, it's easy:
```curl "http://your.server/plug```

## How to Set Up the Server

First, modify config.toml to your liking.

then, build the binary:
```nimble build```

then build the docker image:
```docker build -t pastebim .```

run it with `docker-compose`
```docker-compose up -d```

then probably put that behind nginx or somethin.