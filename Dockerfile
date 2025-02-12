# How to build:
# docker build -t pingora_lb .
# How to run:
# docker run -d -p 6188:6188 pingora_lb

# docker tag pingora_lb ${username}/pingora_lb:latest
# docker push ${username}/pingora_lb:latest

FROM rust:latest as builder

WORKDIR /app

RUN apt-get update && apt-get install -y cmake

RUN git clone https://github.com/Kenji0510/pingora-sample.git .

RUN cargo build --release

FROM debian:bookworm-slim

WORKDIR /app

COPY --from=builder /app/target/release/pingora_lb /app/pingora_lb

CMD ["./pingora_lb"]