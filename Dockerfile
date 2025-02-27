FROM node:18

# Set working directory
WORKDIR /usr/src/app

# Install pnpm
RUN npm install -g pnpm

# Copy package.json and pnpm-lock.yaml to leverage Docker cache
COPY APP/package.json APP/pnpm-lock.yaml ./

# Install dependencies
RUN pnpm install --frozen-lockfile

# Copy the rest of the application
COPY APP/ ./

# Install all necessary dev dependencies
RUN pnpm add astro -D --workspace-root

# List installed packages (optional, just for debugging)
RUN pnpm list

# Expose the application port
EXPOSE 8080

# Command to run the app
CMD ["pnpm", "run", "dev"]
