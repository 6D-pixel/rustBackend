FROM rust:latest AS builder

WORKDIR /usr/src/myapp
COPY . .
RUN cargo install --path .

FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y libssl3 ca-certificates && rm -rf /var/lib/apt/lists/*

COPY --from=builder /usr/local/cargo/bin/myapp /usr/local/bin/myapp

EXPOSE 8080

CMD ["myapp"]
