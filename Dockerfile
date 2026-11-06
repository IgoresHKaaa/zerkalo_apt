FROM mbentley/apt-cacher-ng:trixie

RUN apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends stunnel4 \
 && rm -rf /var/lib/apt/lists/* \
 && printf '\nBindAddress: 127.0.0.1\n' >> /etc/apt-cacher-ng/zzz_acng.conf \
 && mkdir -p /etc/s6/stunnel /etc/s6/cert-watch

COPY stunnel.conf /etc/stunnel/stunnel.conf
COPY s6/stunnel/run /etc/s6/stunnel/run
COPY s6/cert-watch/run /etc/s6/cert-watch/run
RUN chmod 755 /etc/s6/stunnel/run /etc/s6/cert-watch/run
COPY apt-cacher-ng/zzzz_https.conf /etc/apt-cacher-ng/zzzz_https.conf
