class LodgementsNewController < Formotion::FormController
	def init
    @form = Formotion::Form.new({
      title: "New Entry",
      sections: [{
        rows: [{
          title: "Date",
          type: :date,
          picker_mode: :date,
          format: :short,
          key: :date
        }, {
          title: "Amount",
          type: :number,
          placeholder: "Amount",
          key: :amount,
          value: "€"
        }]
      }, {
        rows: [{
          title: "Add",
          type: :submit
        }]
      }]
    })
    @form.on_submit do
      self.create
    end
    super.initWithForm(@form)

	end

  def create
    details = @form.render
    puts details[:date]
    amount = details[:amount]
    amount = amount[1..-1] if amount[0] == '€'
    amount = amount.to_i

    time = Time.at(details[:date]) if details[:date]
    time_string = time.strftime("%d/%m/%y") if details[:date]

    lodgement = Lodgement.new
    lodgement.lodgement_timestamp = details[:date]
    lodgement.date = time_string
    lodgement.amount = amount
    lodgement.save

    self.navigationController.popViewControllerAnimated(true)
  end

	def viewDidLoad
		super
		self.view.backgroundColor = UIColor.whiteColor
	end

end