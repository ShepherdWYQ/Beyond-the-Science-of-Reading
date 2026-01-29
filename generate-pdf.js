#!/usr/bin/env node

const puppeteer = require('puppeteer');
const fs = require('fs');
const path = require('path');

async function generatePDF() {
  console.log('启动PDF生成...');
  
  const browser = await puppeteer.launch({
    headless: true,
    args: ['--no-sandbox', '--disable-setuid-sandbox']
  });
  
  const page = await browser.newPage();
  
  // 设置页面格式
  await page.setViewport({ width: 1200, height: 800 });
  
  // 读取所有Markdown文件并转换为HTML
  const chapters = [
    'index.md',
    'chapters/Beyond the Science of Reading.md',
    'chapters/Chapter 1_ How Embracing All of the Science of Reading Can Get Us Past the Old Debates.md',
    'chapters/Chapter 2_ Why the Reading Crisis Is Actually a Learning Crisis.md'
  ];
  
  let htmlContent = `
    <!DOCTYPE html>
    <html lang="zh-CN">
    <head>
      <meta charset="UTF-8">
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
      <title>Beyond the Science of Reading</title>
      <style>
        body {
          font-family: "PingFang SC", "Helvetica Neue", Arial, sans-serif;
          line-height: 1.6;
          color: #333;
          max-width: 800px;
          margin: 0 auto;
          padding: 20px;
        }
        h1, h2, h3, h4, h5, h6 {
          color: #2c3e50;
          margin-top: 2em;
          margin-bottom: 1em;
        }
        h1 {
          border-bottom: 3px solid #3498db;
          padding-bottom: 10px;
        }
        h2 {
          border-bottom: 1px solid #bdc3c7;
          padding-bottom: 5px;
        }
        p {
          margin-bottom: 1em;
          text-align: justify;
        }
        ul, ol {
          margin-bottom: 1em;
          padding-left: 2em;
        }
        li {
          margin-bottom: 0.5em;
        }
        blockquote {
          border-left: 4px solid #3498db;
          margin: 1em 0;
          padding-left: 1em;
          color: #7f8c8d;
        }
        code {
          background-color: #f8f9fa;
          padding: 2px 4px;
          border-radius: 3px;
          font-family: "SF Mono", Consolas, monospace;
        }
        pre {
          background-color: #f8f9fa;
          padding: 1em;
          border-radius: 5px;
          overflow-x: auto;
        }
        .page-break {
          page-break-before: always;
        }
        .toc {
          background-color: #f8f9fa;
          padding: 20px;
          border-radius: 5px;
          margin-bottom: 2em;
        }
        .toc h2 {
          margin-top: 0;
        }
        .toc ul {
          list-style-type: none;
          padding-left: 0;
        }
        .toc li {
          margin-bottom: 0.3em;
        }
        .toc a {
          text-decoration: none;
          color: #3498db;
        }
        .toc a:hover {
          text-decoration: underline;
        }
      </style>
    </head>
    <body>
  `;
  
  // 添加目录
  htmlContent += `
    <div class="toc">
      <h2>目录</h2>
      <ul>
        <li><a href="#introduction">简介</a></li>
        <li><a href="#chapter1">第1章：拥抱完整的阅读科学如何让我们超越旧有辩论</a></li>
        <li><a href="#chapter2">第2章：为什么阅读危机实际上是学习危机</a></li>
      </ul>
    </div>
  `;
  
  // 处理每个文件
  for (const filePath of chapters) {
    if (fs.existsSync(filePath)) {
      console.log(`处理文件: ${filePath}`);
      const content = fs.readFileSync(filePath, 'utf8');
      
      // 简单的Markdown到HTML转换
      let htmlChapter = content
        .replace(/^---[\s\S]*?---\n/m, '') // 移除front matter
        .replace(/^# (.*$)/gm, '<h1>$1</h1>')
        .replace(/^## (.*$)/gm, '<h2>$1</h2>')
        .replace(/^### (.*$)/gm, '<h3>$1</h3>')
        .replace(/^#### (.*$)/gm, '<h4>$1</h4>')
        .replace(/^\* (.*$)/gm, '<li>$1</li>')
        .replace(/^(\d+)\. (.*$)/gm, '<li>$1. $2</li>')
        .replace(/\*\*(.*?)\*\*/g, '<strong>$1</strong>')
        .replace(/\*(.*?)\*/g, '<em>$1</em>')
        .replace(/`(.*?)`/g, '<code>$1</code>')
        .replace(/\n\n/g, '</p><p>')
        .replace(/^(?!<[h|l|p])/gm, '<p>')
        .replace(/(<li>.*<\/li>)/gs, '<ul>$1</ul>')
        .replace(/<\/ul>\s*<ul>/g, '');
      
      htmlContent += `<div class="page-break">${htmlChapter}</div>`;
    }
  }
  
  htmlContent += `
    </body>
    </html>
  `;
  
  // 设置HTML内容
  await page.setContent(htmlContent, { waitUntil: 'networkidle0' });
  
  // 生成PDF
  const pdfBuffer = await page.pdf({
    format: 'A4',
    printBackground: true,
    margin: {
      top: '20mm',
      right: '15mm',
      bottom: '20mm',
      left: '15mm'
    },
    displayHeaderFooter: true,
    headerTemplate: '<div style="font-size: 10px; width: 100%; text-align: center;">Beyond the Science of Reading</div>',
    footerTemplate: '<div style="font-size: 10px; width: 100%; text-align: center;"><span class="pageNumber"></span> / <span class="totalPages"></span></div>'
  });
  
  // 保存PDF
  const outputPath = 'Beyond-the-Science-of-Reading.pdf';
  fs.writeFileSync(outputPath, pdfBuffer);
  
  console.log(`PDF已生成: ${outputPath}`);
  
  await browser.close();
}

// 检查依赖
if (!fs.existsSync('node_modules/puppeteer')) {
  console.log('请先安装依赖: npm install puppeteer');
  process.exit(1);
}

generatePDF().catch(console.error);