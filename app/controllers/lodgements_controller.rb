class LodgementsController < UIViewController
	def init
    self.viewDidAppear(true)
		self
	end

	def viewDidLoad
		super
		self.title = "My Lodgements"
		self.view.backgroundColor = UIColor.whiteColor

    new_button = UIBarButtonItem.alloc.initWithTitle("+", style: UIBarButtonItemStylePlain, target:self, action: "new")
    self.navigationItem.rightBarButtonItem = new_button

	end

  def viewWillAppear(animated)
    @lodgements = Lodgement.all
    @lodgements = @lodgements.sort_by do |lodgement|
      lodgement.lodgement_timestamp || 0
    end
    @lodgements = @lodgements.reverse
    total
    @table = UITableView.new
    @table.delegate = self
    @table.dataSource = self
    @table.frame = self.view.bounds
    self.view.addSubview(@table)
  end

  def total
    @total = 0
    @lodgements.each do |lodgement|
      @total = @total + lodgement.amount
    end
  end

  def new
    new_lodgement_controller = LodgementsNewController.new
    self.navigationController.pushViewController(new_lodgement_controller, animated:true)
  end

  def tableView(tableView, cellForRowAtIndexPath: indexPath)
    #stuff that has to be here:
    @reuseIdentifier ||= "Aisling"

    cell = tableView.dequeueReusableCellWithIdentifier(@reuseIdentifier) || begin
      UITableViewCell.alloc.initWithStyle(UITableViewCellStyleValue1, reuseIdentifier: @reuseIdentifier)
    end

    if indexPath.row == @lodgements.count
      # if this is the last row
      cell.textLabel.font = UIFont.boldSystemFontOfSize(16)
      cell.textLabel.text = "Total"
      cell.detailTextLabel.font = UIFont.boldSystemFontOfSize(16)
      cell.detailTextLabel.text = "€#{@total}"
      

    else
      order = @lodgements.count - indexPath.row
      lodgement = @lodgements[indexPath.row]
      text = "#{order}.  #{lodgement.date}"


      cell.textLabel.text = text
      cell.detailTextLabel.text = "€#{lodgement.amount}"
    end

    return cell
  end

  def tableView(tableView, numberOfRowsInSection:section)
    return @lodgements.count + 1
  end

  def tableView(tableView, didSelectRowAtIndexPath: indexPath)
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
  end

  def tableView(tableView, canEditRowAtIndexPath:indexPath)
    indexPath.row != @lodgements.count
  end

  def tableView(tableView, commitEditingStyle: editing_style, forRowAtIndexPath: indexPath)
    if editing_style == UITableViewCellEditingStyleDelete
      lodgement = @lodgements[indexPath.row]
      @lodgements.delete(lodgement)
      lodgement.delete
      total
      @table.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimationAutomatic)
      @table.reloadRowsAtIndexPaths(@table.indexPathsForVisibleRows, withRowAnimation:UITableViewRowAnimationNone)
    end
  end
end