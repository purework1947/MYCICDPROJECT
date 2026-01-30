FROM cypress/included:14.5.4

WORKDIR /app

COPY package.json package-lock.json ./
RUN npm ci --no-audit --no-fund

COPY . .

ENV NO_COLOR=1

CMD ["cypress", "run"]
