import { chromium } from "playwright";

const main = async () => {
  const browser = await chromium.launch();
  const page = await browser.newPage();

  await page.goto("http://localhost:4321/", { waitUntil: "networkidle" });

  await page.evaluate(() => {
    const article = document.querySelector("#article-pdf-main");
    if (!article) throw new Error("article-pdf-main not found");
    document.body.innerHTML = "";
    document.body.appendChild(article);
    document.body.style.margin = "0";
  });

  await page.emulateMedia({ media: "screen" });

  await page.pdf({
    path: "public/resume.pdf",
    printBackground: false,
  });

  return browser.close();
};

main();
