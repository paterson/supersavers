class HomeController < UIViewController
	def init
		self
	end

	def viewDidLoad
		super
		self.title = "Super Savers"
		self.view.backgroundColor = UIColor.whiteColor
    #self.navigationController.navigationBar.barTintColor = UIColor.blueColor
    font = UIFont.fontWithName("Verdana-Bold", size:25)

    @label = UILabel.alloc.initWithFrame(CGRectZero)
    @label.text = "Super Savers Bank"
    @label.setFont(font)
    @label.sizeToFit
    @label.center = CGPointMake(self.view.frame.size.width / 2, self.view.frame.size.height / 2)
    self.view.addSubview @label

    @label1 = UILabel.alloc.initWithFrame(CGRectZero)
    @label1.text = "Dominican College"
    @label1.setFont(font)
    @label1.sizeToFit
    @label1.center = CGPointMake(self.view.frame.size.width / 2, self.view.frame.size.height / 2 - 32)
    self.view.addSubview @label1
 
    @image = UIImage.imageNamed("logo.png")
    @image_view = UIImageView.alloc.initWithImage(@image)
    @image_view.setFrame(CGRectMake(70, 30, 200, 200))
    self.view.addSubview @image_view
	end

end