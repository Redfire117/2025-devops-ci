FROM node:18 AS builder
WORKDIR /app

COPY package*.json ./

RUN npm install -g pnpm@latest

RUN pnpm install --frozen-lockfile

COPY . .

RUN pnpm run build

FROM node:18 AS runner
WORKDIR /app

run npm install -g serve

COPY --from=builder /app/dist ./dist

EXPOSE 3000

CMD ["serve", "-s", "dist", "-l", "3000"]