FROM golang:1.20 as builder
ENV GOPROXY=https://goproxy.cn
WORKDIR /app
COPY go.* ./
RUN go mod download
COPY . .
RUN CGO_ENABLED=0 go build -o main

FROM alpine
WORKDIR /app
COPY --from=builder /app/main ./main
CMD ["/app/main"]