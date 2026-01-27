FROM cypress/included:13.6.0

WORKDIR /e2e

COPY package.json package-lock.json* ./
RUN npm ci || npm install

COPY . .

CMD ["npx", "cypress", "run"]
