class FacebookController < UIViewController
	def init
		self
	end

	def viewDidLoad
		super
		self.title = 'Facebook'
		self.view = UIWebView.new
		url = NSURL.URLWithString("https://www.facebook.com/supersavers1314")
		request = NSURLRequest.requestWithURL(url)
		self.view.loadRequest request
	end

end