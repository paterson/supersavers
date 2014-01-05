class GalleryController < UICollectionViewController
	def initWithCollectionViewLayout layout
    @layout = layout
    @images = [
      "http://www.pngfactory.net/_png/_thumb/13281-Wazatsu-1up.png", 
      "http://thoseguys.tv/wp-content/uploads/2012/08/yellow-coin.png", 
      "http://gamerinvestments.com/video-game-stocks/wp-content/uploads/2009/10/super-mario-bros-wii-i_20476-250x250.jpg", 
      "http://www.tattooset.com/images/tattoo/2012/08/20/8500-super-mario-bros-mushroom_large.jpg", 
      "http://www.rte.ie/blogs/thevoice/wp-content/themes/voice/img/coach3.jpg", 
      "http://www.polyvore.com/cgi/img-thing?.out=jpg&size=l&tid=4564328", 
      "http://images.celebrateexpress.com/mgen/merchandiser/57907.jpg?zm=250,250,1,0,0",
      "https://a3-images.myspacecdn.com/images03/33/9fe330704f684b4d8d876f3b6bf3b633/300x300.jpg"
    ]
		super
	end

	def viewDidLoad
    puts 'here'
		super
		self.title = "Gallery"
    self.collectionView.registerClass(UICollectionViewCell, forCellWithReuseIdentifier:"Aisling")
    @layout.setItemSize(CGSizeMake(90, 90))
    @layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10)
    @layout.setScrollDirection(UICollectionViewScrollDirectionVertical)
    self.collectionView.collectionViewLayout = @layout
    self.collectionView.backgroundColor = UIColor.whiteColor
    self.collectionView.dataSource = self
    create_tap_recognizer(1, "handleTap:")
    @is_fullscreen = false
	end

  def handleTap(gesture)
    puts @is_fullscreen
    if @is_fullscreen
      self.view.subviews.each do |subview|
        #subview.removeFromSuperview if subview.tag == 7
        if subview.tag == 7
          UIView.transitionWithView(self.view, duration: 0.5, options: UIViewAnimationOptionTransitionFlipFromRight, animations: proc { subview.removeFromSuperview }, completion: nil)
        end
      end
      @is_fullscreen = false
      self.navigationController.navigationBar.hidden = false
    else
      point = gesture.locationInView(self.collectionView)
      indexPath = self.collectionView.indexPathForItemAtPoint(point)
      if indexPath
        delegate.collectionView(self.collectionView, didSelectItemAtIndexPath:indexPath)
      end
    end 
  end


  def collectionView(collectionView, numberOfItemsInSection: section)
    return 9
  end

  def collectionView(collectionView, cellForItemAtIndexPath: indexPath)
    cell = collectionView.dequeueReusableCellWithReuseIdentifier(Cell::CELL_ID, forIndexPath: indexPath)
    @image = UIImage.imageNamed("logo.png")
    @image = UIImage.imageWithData(NSData.dataWithContentsOfURL(NSURL.URLWithString(@images[indexPath.row])))
    @image_view = UIImageView.alloc.initWithImage(@image)
    @image_view.frame = cell.contentView.bounds
    cell.contentView.addSubview(@image_view)
    cell
  end

  def collectionView(collectionView, didSelectItemAtIndexPath:indexPath)
    @image = UIImage.imageWithData(NSData.dataWithContentsOfURL(NSURL.URLWithString(@images[indexPath.row])))
    @image_view = UIImageView.alloc.initWithImage(@image)
    @image_view.frame = UIScreen.mainScreen.bounds
    @image_view.contentMode = UIViewContentModeCenter
    @image_view.tag = 7
    @is_fullscreen = true
    @image_view.backgroundColor = UIColor.blackColor
    UIView.transitionWithView(self.view, duration: 0.5, options: UIViewAnimationOptionTransitionFlipFromLeft, animations: proc { self.view.addSubview(@image_view)}, completion: nil)
    #self.view.addSubview(@image_view)
    self.navigationController.navigationBar.hidden = true
  end

  private

    def create_tap_recognizer(number_of_taps, action_handler)
      UITapGestureRecognizer.alloc.initWithTarget(self, action:action_handler).tap do |the_tap|
        the_tap.numberOfTouchesRequired = number_of_taps
        self.view.addGestureRecognizer(the_tap)
      end
    end 
end