FROM debian:stretch-slim

RUN groupadd -r bitcoin && useradd -r -m -g bitcoin bitcoin

RUN set -ex \
	&& apt-get update \
	&& apt-get install -qq --no-install-recommends ca-certificates dirmngr gosu gpg wget \
	&& rm -rf /var/lib/apt/lists/*

ENV BITCOIN_VERSION 0.19.1
ENV BITCOIN_FILE bitcoin-0.19.1-x86_64-linux-gnu.tar.gz
ENV BITCOIN_URL https://bitcoin.org/bin/bitcoin-core-0.19.1/
ENV BITCOIN_SHA256 5fcac9416e486d4960e1a946145566350ca670f9aaba99de6542080851122e4c
ENV BITCOIN_ASC_URL https://bitcoincore.org/bin/bitcoin-core-0.19.1/SHA256SUMS.asc
ENV BITCOIN_PGP_KEY 01EA5486DE18A882D4C2684590C8019E36C2E964

# install bitcoin binaries
RUN set -ex \
	&& cd /tmp \
	&& wget -qO "$BITCOIN_FILE" "$BITCOIN_URL$BITCOIN_FILE" \
	&& echo "$BITCOIN_SHA256 $BITCOIN_FILE" | sha256sum -c - \
	&& gpg --batch --keyserver keyserver.ubuntu.com --recv-keys "$BITCOIN_PGP_KEY" \
	&& wget -qO bitcoin.asc "$BITCOIN_ASC_URL" \
	&& sha256sum --ignore-missing --check bitcoin.asc \
	&& gpg --verify bitcoin.asc \
	&& tar -xzvf "$BITCOIN_FILE" -C /usr/local --strip-components=1 --exclude=*-qt \
	&& rm -rf /tmp/*

# create data directory
ENV BITCOIN_DATA /data
RUN mkdir "$BITCOIN_DATA" \
	&& chown -R bitcoin:bitcoin "$BITCOIN_DATA" \
	&& ln -sfn "$BITCOIN_DATA" /home/bitcoin/.bitcoin \
	&& chown -h bitcoin:bitcoin /home/bitcoin/.bitcoin
VOLUME /data

COPY docker-entrypoint.sh /entrypoint.sh
RUN chmod a+x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 8332 8333 18332 18333 18443 18444
CMD ["bitcoind"]
