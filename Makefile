CONTAINER ?= docker
IMAGE     ?= varoa-net
PORT      ?= 4000

.PHONY: build serve

build:
	$(CONTAINER) build -t $(IMAGE) .

# Run the site locally. The --rm flag removes the container when it stops.
serve: build
	$(CONTAINER) run --rm -it \
		-p $(PORT):4000 \
		-p 35729:35729 \
		-v $(CURDIR):/site \
		$(IMAGE)
