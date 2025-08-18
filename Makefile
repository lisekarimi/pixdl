# =====================================
# 🌱 Project & Environment Configuration
# =====================================

# Read from pyproject.toml using grep (works on all platforms)
PROJECT_NAME = $(shell python3 -c "import re; print(re.search('name = \"(.*)\"', open('pyproject.toml').read()).group(1))")
VERSION = $(shell python3 -c "import re; print(re.search('version = \"(.*)\"', open('pyproject.toml').read()).group(1))")

include .env
export DOCKER_USERNAME
DOCKER_IMAGE = $(DOCKER_USERNAME)/$(PROJECT_NAME)
TAG = $(VERSION)
CONTAINER_NAME = $(PROJECT_NAME)-container

# Default to PyTorch build
DOCKERFILE ?= Dockerfile.pytorch
FRAMEWORK ?= pytorch

# =======================
# 🐳 Docker Commands
# =======================

build: ## Build PyTorch Docker image
	docker build -f Dockerfile.pytorch -t $(DOCKER_USERNAME)/$(PROJECT_NAME)-pytorch:$(TAG) .

build-tf: ## Build TensorFlow Docker image
	docker build -f Dockerfile.tf -t $(DOCKER_USERNAME)/$(PROJECT_NAME)-tf:$(TAG) .

run: ## Run PyTorch container
	docker run --name $(CONTAINER_NAME) -p 8888:8888 -p 5000:5000 --gpus all --ipc=host --ulimit memlock=-1 --ulimit stack=67108864 -v $(PWD):/workspace $(DOCKER_USERNAME)/$(PROJECT_NAME)-pytorch:$(TAG)

run-tf: ## Run TensorFlow container
	docker run --name $(PROJECT_NAME)-tf-container -p 8888:8888 --gpus all --ipc=host --ulimit memlock=-1 --ulimit stack=67108864 -v $(PWD):/workspace $(DOCKER_USERNAME)/$(PROJECT_NAME)-tf:$(TAG)

dev: build run ## PyTorch development mode (default)
dev-tf: build-tf run-tf ## TensorFlow development mode

# =====================================
# 📚 Documentation & Help
# =====================================

help: ## Show this help message
	@echo "Available commands:"
	@echo ""
	@python3 -c "import re; lines=open('Makefile', encoding='utf-8').readlines(); targets=[re.match(r'^([a-zA-Z_-]+):.*?## (.*)$$',l) for l in lines]; [print(f'  make {m.group(1):<20} {m.group(2)}') for m in targets if m]"


# =======================
# 🎯 PHONY Targets
# =======================

# Auto-generate PHONY targets (cross-platform)
.PHONY: $(shell python3 -c "import re; print(' '.join(re.findall(r'^([a-zA-Z_-]+):\s*.*?##', open('Makefile', encoding='utf-8').read(), re.MULTILINE)))")

# Test the PHONY generation
# test-phony:
# 	@echo "$(shell python3 -c "import re; print(' '.join(sorted(set(re.findall(r'^([a-zA-Z0-9_-]+):', open('Makefile', encoding='utf-8').read(), re.MULTILINE)))))")"
