// Extract URLS, URIs, SRCs and HREFs from all HTML elements

urls = []
$$('*').forEach(element => {
  urls.push(element.src)
	urls.push(element.href)
	urls.push(element.url)
}); console.log(...new Set(urls)) 

