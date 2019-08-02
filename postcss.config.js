class TailwindExtractor {
	static extract(content) {
		return content.match(/[A-z0-9-:\/]+/g)
	}
}

module.exports = {   
  plugins: [        
    require('postcss-import')({
      path: ["assets/css"],
    }), 
    require('@fullhuman/postcss-purgecss')({
      content: ['layouts/**/*.html', 'content/**/*.md'],
      extractors: [
        {
          extractor: TailwindExtractor,
          extensions: ['html']
        }], 
        fontface: false,
        whitelist: ['blockquote', 'pre', 'ol', 'h6'],
        whitelistPatterns: [/^slick/],
    }),    
    require('autoprefixer')({
      grid: true,
    }), 
  ]
}