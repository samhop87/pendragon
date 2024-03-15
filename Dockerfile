FROM golang:latest

WORKDIR /app

# Copy the go.mod and go.sum files first and download dependencies for better layer caching
COPY go.mod go.sum ./
RUN go mod tidy && go mod download

# Now, copy the rest of your source code
COPY . ./

# Explicitly fetch and update the problematic packages (if still necessary)
RUN go get -u gonum.org/v1/gonum/mat
RUN go get -u gonum.org/v1/gonum/stat/distuv

# Build the binary and place it in the current working directory (/app)
RUN go build -o pendragon

EXPOSE 8080

# Run the binary from the current working directory
CMD [ "./pendragon" ]