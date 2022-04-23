import scrape from 'website-scraper'
import PuppeteerPlugin from 'website-scraper-puppeteer'
import path from 'path'
import { fileURLToPath } from 'url'
import { dirname } from 'path'
import minimist from 'minimist'

const __filename = fileURLToPath(import.meta.url)
const __dirname = dirname(__filename)
const { url, dir } = minimist(process.argv)

scrape({
    urls: [url],
    directory: path.resolve(__dirname, dir),
    plugins: [ 
        new PuppeteerPlugin({
            launchOptions: { 
                headless: true
            },
            scrollToBottom: {
                timeout: 10000, 
                viewportN: 10 
            }
        })
    ]
})
