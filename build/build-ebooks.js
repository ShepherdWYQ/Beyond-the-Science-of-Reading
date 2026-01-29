#!/usr/bin/env node

/**
 * Beyond the Science of Reading - 电子书构建脚本
 * 参考 xindoo/agentic-design-patterns 项目架构
 * 支持生成 PDF 和 EPUB 格式
 */

const fs = require('fs');
const path = require('path');
const { execSync } = require('child_process');

class EbookBuilder {
  constructor() {
    this.projectRoot = path.resolve(__dirname, '..');
    this.buildDir = path.join(this.projectRoot, 'build');
    this.outputDir = path.join(this.projectRoot, 'dist');
    this.tempDir = path.join(this.buildDir, 'temp');
    
    this.bookConfig = {
      title: 'Beyond the Science of Reading',
      subtitle: 'Connecting Literacy Instruction to the Science of Learning',
      author: 'Natalie Wexler (原著) | 中文翻译项目',
      language: 'zh-CN',
      description: '《Beyond the Science of Reading: Connecting Literacy Instruction to the Science of Learning》中文翻译项目',
      cover: path.join(this.projectRoot, 'images', 'cover.png'),
      isbn: '978-1-4166-3356-3',
      publisher: 'ASCD',
      publishDate: '2025年1月21日'
    };
    
    this.chapters = [
      { file: 'index.md', title: '简介', level: 0 },
      { file: 'chapters/Beyond the Science of Reading.md', title: '关于本书', level: 0 },
      { file: 'chapters/Chapter 1_ How Embracing All of the Science of Reading Can Get Us Past the Old Debates.md', title: '第1章：拥抱完整的阅读科学如何让我们超越旧有辩论', level: 1 },
      { file: 'chapters/Chapter 2_ Why the Reading Crisis Is Actually a Learning Crisis.md', title: '第2章：为什么阅读危机实际上是学习危机', level: 1 },
      { file: 'glossary.md', title: '术语表', level: 0 }
    ];
  }

  // 初始化构建环境
  init() {
    console.log('🚀 初始化电子书构建环境...');
    
    // 创建必要的目录
    [this.buildDir, this.outputDir, this.tempDir].forEach(dir => {
      if (!fs.existsSync(dir)) {
        fs.mkdirSync(dir, { recursive: true });
      }
    });

    // 检查依赖
    this.checkDependencies();
  }

  // 检查构建依赖
  checkDependencies() {
    const dependencies = [
      { cmd: 'pandoc --version', name: 'Pandoc', install: 'brew install pandoc' },
      { cmd: 'calibre --version', name: 'Calibre', install: 'brew install --cask calibre' }
    ];

    console.log('📋 检查构建依赖...');
    
    dependencies.forEach(dep => {
      try {
        execSync(dep.cmd, { stdio: 'ignore' });
        console.log(`✅ ${dep.name} 已安装`);
      } catch (error) {
        console.log(`❌ ${dep.name} 未安装，请运行: ${dep.install}`);
        process.exit(1);
      }
    });
  }

  // 生成书籍元数据
  generateMetadata() {
    const metadata = {
      title: this.bookConfig.title,
      subtitle: this.bookConfig.subtitle,
      author: this.bookConfig.author,
      language: this.bookConfig.language,
      description: this.bookConfig.description,
      rights: '本翻译项目遵循原书的许可证条款。翻译内容仅供学习交流使用。',
      publisher: this.bookConfig.publisher,
      date: this.bookConfig.publishDate,
      identifier: this.bookConfig.isbn
    };

    const metadataPath = path.join(this.tempDir, 'metadata.yaml');
    const yamlContent = Object.entries(metadata)
      .map(([key, value]) => `${key}: "${value}"`)
      .join('\n');

    fs.writeFileSync(metadataPath, yamlContent);
    return metadataPath;
  }

  // 合并所有章节
  mergeChapters() {
    console.log('📚 合并章节内容...');
    
    let mergedContent = '';
    
    // 添加标题页
    mergedContent += `---
title: "${this.bookConfig.title}"
subtitle: "${this.bookConfig.subtitle}"
author: "${this.bookConfig.author}"
date: "${this.bookConfig.publishDate}"
lang: zh-CN
documentclass: book
geometry: margin=2.5cm
fontsize: 11pt
linestretch: 1.3
toc: true
toc-depth: 3
numbersections: true
---

# ${this.bookConfig.title}

## ${this.bookConfig.subtitle}

**作者**: ${this.bookConfig.author}  
**出版日期**: ${this.bookConfig.publishDate}  
**ISBN**: ${this.bookConfig.isbn}

---

\\newpage

`;

    // 处理每个章节
    this.chapters.forEach((chapter, index) => {
      const filePath = path.join(this.projectRoot, chapter.file);
      
      if (fs.existsSync(filePath)) {
        console.log(`  处理: ${chapter.title}`);
        
        let content = fs.readFileSync(filePath, 'utf8');
        
        // 移除 Jekyll front matter
        content = content.replace(/^---[\s\S]*?---\n/m, '');
        
        // 添加章节分页
        if (index > 0) {
          mergedContent += '\\newpage\n\n';
        }
        
        // 处理图片路径
        content = content.replace(/!\[(.*?)\]\((?!http)(.*?)\)/g, (match, alt, src) => {
          const imagePath = path.resolve(this.projectRoot, src);
          if (fs.existsSync(imagePath)) {
            return `![${alt}](${imagePath})`;
          }
          return match;
        });
        
        mergedContent += content + '\n\n';
      } else {
        console.log(`  ⚠️  文件不存在: ${chapter.file}`);
      }
    });

    const mergedPath = path.join(this.tempDir, 'complete-book.md');
    fs.writeFileSync(mergedPath, mergedContent);
    
    return mergedPath;
  }

  // 生成 PDF
  async generatePDF() {
    console.log('📄 生成 PDF 电子书...');
    
    const inputFile = this.mergeChapters();
    const outputFile = path.join(this.outputDir, 'Beyond-the-Science-of-Reading.pdf');
    
    const pandocArgs = [
      inputFile,
      '-o', outputFile,
      '--pdf-engine=xelatex',
      '--variable', 'mainfont="PingFang SC"',
      '--variable', 'sansfont="PingFang SC"',
      '--variable', 'monofont="SF Mono"',
      '--variable', 'CJKmainfont="PingFang SC"',
      '--toc',
      '--toc-depth=3',
      '--number-sections',
      '--highlight-style=github',
      '--template=eisvogel',
      '--listings'
    ].filter(Boolean);

    try {
      execSync(`pandoc ${pandocArgs.join(' ')}`, { 
        stdio: 'inherit',
        cwd: this.projectRoot 
      });
      
      console.log(`✅ PDF 生成成功: ${outputFile}`);
      return outputFile;
    } catch (error) {
      // 如果 eisvogel 模板不存在，使用默认模板
      console.log('⚠️  使用默认模板重试...');
      
      const fallbackArgs = pandocArgs.filter(arg => !arg.includes('template') && !arg.includes('listings'));
      
      try {
        execSync(`pandoc ${fallbackArgs.join(' ')}`, { 
          stdio: 'inherit',
          cwd: this.projectRoot 
        });
        
        console.log(`✅ PDF 生成成功: ${outputFile}`);
        return outputFile;
      } catch (fallbackError) {
        console.error('❌ PDF 生成失败:', fallbackError.message);
        throw fallbackError;
      }
    }
  }

  // 生成 EPUB
  async generateEPUB() {
    console.log('📱 生成 EPUB 电子书...');
    
    const inputFile = this.mergeChapters();
    const metadataFile = this.generateMetadata();
    const outputFile = path.join(this.outputDir, 'Beyond-the-Science-of-Reading.epub');
    
    const pandocArgs = [
      inputFile,
      '-o', outputFile,
      '--metadata-file', metadataFile,
      '--toc',
      '--toc-depth=3',
      '--epub-cover-image', this.bookConfig.cover,
      '--css', path.join(__dirname, 'styles', 'epub.css')
    ].filter(Boolean);

    try {
      execSync(`pandoc ${pandocArgs.join(' ')}`, { 
        stdio: 'inherit',
        cwd: this.projectRoot 
      });
      
      console.log(`✅ EPUB 生成成功: ${outputFile}`);
      return outputFile;
    } catch (error) {
      console.error('❌ EPUB 生成失败:', error.message);
      throw error;
    }
  }

  // 生成 MOBI (Kindle格式)
  async generateMOBI() {
    console.log('📖 生成 MOBI 电子书...');
    
    const epubFile = path.join(this.outputDir, 'Beyond-the-Science-of-Reading.epub');
    const mobiFile = path.join(this.outputDir, 'Beyond-the-Science-of-Reading.mobi');
    
    if (!fs.existsSync(epubFile)) {
      console.log('⚠️  EPUB 文件不存在，先生成 EPUB...');
      await this.generateEPUB();
    }

    try {
      execSync(`ebook-convert "${epubFile}" "${mobiFile}"`, { 
        stdio: 'inherit',
        cwd: this.projectRoot 
      });
      
      console.log(`✅ MOBI 生成成功: ${mobiFile}`);
      return mobiFile;
    } catch (error) {
      console.error('❌ MOBI 生成失败:', error.message);
      console.log('💡 提示: 需要安装 Calibre 来生成 MOBI 格式');
      throw error;
    }
  }

  // 清理临时文件
  cleanup() {
    console.log('🧹 清理临时文件...');
    
    if (fs.existsSync(this.tempDir)) {
      fs.rmSync(this.tempDir, { recursive: true, force: true });
    }
  }

  // 构建所有格式
  async buildAll() {
    try {
      this.init();
      
      console.log('📚 开始构建电子书...\n');
      
      const results = [];
      
      // 生成 PDF
      try {
        const pdfFile = await this.generatePDF();
        results.push({ format: 'PDF', file: pdfFile, success: true });
      } catch (error) {
        results.push({ format: 'PDF', error: error.message, success: false });
      }
      
      // 生成 EPUB
      try {
        const epubFile = await this.generateEPUB();
        results.push({ format: 'EPUB', file: epubFile, success: true });
      } catch (error) {
        results.push({ format: 'EPUB', error: error.message, success: false });
      }
      
      // 生成 MOBI
      try {
        const mobiFile = await this.generateMOBI();
        results.push({ format: 'MOBI', file: mobiFile, success: true });
      } catch (error) {
        results.push({ format: 'MOBI', error: error.message, success: false });
      }
      
      // 输出结果
      console.log('\n📊 构建结果:');
      results.forEach(result => {
        if (result.success) {
          console.log(`✅ ${result.format}: ${result.file}`);
        } else {
          console.log(`❌ ${result.format}: ${result.error}`);
        }
      });
      
      const successCount = results.filter(r => r.success).length;
      console.log(`\n🎉 成功生成 ${successCount}/${results.length} 种格式的电子书`);
      
    } catch (error) {
      console.error('❌ 构建失败:', error.message);
      process.exit(1);
    } finally {
      this.cleanup();
    }
  }
}

// 命令行接口
if (require.main === module) {
  const builder = new EbookBuilder();
  
  const command = process.argv[2] || 'all';
  
  switch (command) {
    case 'pdf':
      builder.init();
      builder.generatePDF().then(() => builder.cleanup());
      break;
    case 'epub':
      builder.init();
      builder.generateEPUB().then(() => builder.cleanup());
      break;
    case 'mobi':
      builder.init();
      builder.generateMOBI().then(() => builder.cleanup());
      break;
    case 'all':
    default:
      builder.buildAll();
      break;
  }
}

module.exports = EbookBuilder;