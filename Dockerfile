FROM mcr.microsoft.com/playwright:v1.52.0-noble

WORKDIR /app

# Avoid re-downloading browsers; the image already contains them
ENV PLAYWRIGHT_SKIP_BROWSER_DOWNLOAD=1
# Many Playwright images keep browsers here; harmless even if already set
ENV PLAYWRIGHT_BROWSERS_PATH=/ms-playwright

# Copy dependency manifests first (better caching)
COPY package.json ./
COPY package-lock.json* ./

# Install deps without running postinstall (your postinstall runs "npx playwright install")
RUN npm ci --ignore-scripts; 

# Copy the rest of the project
COPY . .

# One-shot: start Astro, wait for it, generate PDF, exit
CMD ["bash", "-lc", "npx start-server-and-test \"npm run preview -- --host 0.0.0.0 --port 4321\" http://127.0.0.1:4321 \"node ./scripts/generate-pdf.js\""]
