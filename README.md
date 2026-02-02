See https://varoa.net

To run locally:

    docker build -t varoa.net .
    docker run -p 4000:4000 -v $(pwd):/site varoa.net
