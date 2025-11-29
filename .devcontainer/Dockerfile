# Claude Code Research Agent - Docker Container (GPU Enabled)
# Based on NVIDIA CUDA image for GPU support
# Provides an isolated environment for running Claude Code safely

FROM nvidia/cuda:12.4.1-devel-ubuntu22.04

# Prevent interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Install system dependencies including Node.js
RUN apt-get update && apt-get install -y \
    git \
    curl \
    wget \
    jq \
    sudo \
    zsh \
    fzf \
    python3 \
    python3-pip \
    python3-venv \
    ca-certificates \
    gnupg \
    && mkdir -p /etc/apt/keyrings \
    && curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg \
    && echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_20.x nodistro main" | tee /etc/apt/sources.list.d/nodesource.list \
    && apt-get update \
    && apt-get install -y nodejs \
    && rm -rf /var/lib/apt/lists/*

# Install git-delta for better diffs
RUN ARCH=$(dpkg --print-architecture) && \
    if [ "$ARCH" = "amd64" ]; then \
        DELTA_ARCH="x86_64"; \
    elif [ "$ARCH" = "arm64" ]; then \
        DELTA_ARCH="aarch64"; \
    else \
        DELTA_ARCH="$ARCH"; \
    fi && \
    wget -qO- "https://github.com/dandavison/delta/releases/download/0.18.2/delta-0.18.2-${DELTA_ARCH}-unknown-linux-gnu.tar.gz" | \
    tar xzf - -C /usr/local/bin --strip-components=1 "delta-0.18.2-${DELTA_ARCH}-unknown-linux-gnu/delta"

# Install uv for Python environment management
RUN curl -LsSf https://astral.sh/uv/install.sh | sh
ENV PATH="/root/.local/bin:$PATH"

# Create node user (matching the previous setup)
RUN useradd -m -s /bin/bash -u 1000 node

# Set up directories with proper ownership
RUN mkdir -p /usr/local/share/npm-global \
    && mkdir -p /home/node/.claude \
    && mkdir -p /home/node/workspace \
    && mkdir -p /commandhistory \
    && chown -R node:node /usr/local/share/npm-global \
    && chown -R node:node /home/node/.claude \
    && chown -R node:node /home/node/workspace \
    && chown -R node:node /commandhistory

# Configure npm to use the global directory
ENV NPM_CONFIG_PREFIX=/usr/local/share/npm-global
ENV PATH=/usr/local/share/npm-global/bin:$PATH

# Install Claude Code globally
USER node
RUN npm install -g @anthropic-ai/claude-code
USER root

# Install uv for node user as well
USER node
RUN curl -LsSf https://astral.sh/uv/install.sh | sh
USER root

# Set up shell history persistence
RUN SNIPPET="export PROMPT_COMMAND='history -a' && export HISTFILE=/commandhistory/.bash_history" \
    && mkdir -p /commandhistory \
    && touch /commandhistory/.bash_history \
    && chown -R node:node /commandhistory \
    && echo "$SNIPPET" >> /home/node/.bashrc

# Give node user sudo access for full control inside container
RUN echo "node ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers.d/node-sudo \
    && chmod 0440 /etc/sudoers.d/node-sudo

# Set working directory
WORKDIR /home/node/workspace

# Switch to node user
USER node
ENV PATH="/home/node/.local/bin:$PATH"

# CUDA environment variables
ENV NVIDIA_VISIBLE_DEVICES=all
ENV NVIDIA_DRIVER_CAPABILITIES=compute,utility

# Default command - runs Claude with skip-permissions for autonomous operation
CMD ["claude", "--dangerously-skip-permissions"]
