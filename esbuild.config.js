#!/usr/bin/env node
const esbuild = require('esbuild')
const path = require('path')
const inlineImage = require("esbuild-plugin-inline-image");
esbuild
  .build({
    entryPoints: ['application.js'],
    bundle: true,
    sourcemap: true,
    watch: process.argv.includes('--watch') && {
      onRebuild(error, result) {
        if (error) console.error('watch build failed:', error)
        else console.log('watch build succeeded:', result)
      },
    },
    absWorkingDir: path.join(process.cwd(), 'app/javascript'),
    outdir: path.join(process.cwd(), 'app/assets/builds'),
    loader: {
      '.jsx': 'jsx',
      '.png': 'file'
    },
    plugins: [
      inlineImage()
    ]
  })
  .catch(() => process.exit(2))
