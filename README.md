# docker-bitcoin

[![License](https://img.shields.io/github/license/timchurchard/docker-bitcoin.svg)](https://github.com/timchurchard/docker-bitcoin/blob/master/LICENSE)

yet another bitcoin docker

Based on [NicolasDorier/docker-bitcoin](https://github.com/NicolasDorier/docker-bitcoin)

Bitcoin uses peer-to-peer technology to operate with no central authority or banks; managing transactions and the issuing of bitcoin is carried out collectively by the network. Bitcoin is open-source; its design is public, nobody owns or controls Bitcoin and everyone can take part. Through many of its unique properties, Bitcoin allows exciting uses that could not be covered by any previous payment system.

This Docker image provides `bitcoin`, `bitcoin-cli` and `bitcoin-tx` applications which can be used to run and interact with a bitcoin server.

### Usage

To start a bitcoind instance running the latest version:

```
$ docker run timchurchard/bitcoin
```

See ./example.sh for more commands.

### License

Configuration files and code in this repository are distributed under the [MIT license](/LICENSE).
