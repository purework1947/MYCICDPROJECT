FROM cypress/included:12.17.0

WORKDIR /app

COPY package.json package-lock.json ./
RUN npm ci --no-audit --no-fund

COPY . .

# Disable ANSI colors
ENV NO_COLOR=1

CMD ["cypress", "run"]
