# -----------------------------
# Stage 1: Build
# -----------------------------
FROM node:18-slim AS builder

WORKDIR /app

COPY package*.json ./
RUN npm install --omit=dev

COPY . .

# -----------------------------
# Stage 2: Runtime (Distroless)
# -----------------------------
FROM gcr.io/distroless/nodejs20

WORKDIR /app

COPY --from=builder /app /app

EXPOSE 3000

CMD ["app.js"]