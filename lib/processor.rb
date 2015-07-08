class Processor
  def self.send_shipment(shipment, config)
    doc = Documents::Shipment.new(shipment, config)
    res = Sender.send_doc(doc.to_xml, config)

    sent_notification(res)
  end

  def self.receive_results(bucket, type, folder_name= "")
    down  = Downloader.new(bucket)
    files = down.download_files(type, folder_name)

    if files.empty?
      empty_notification(type)
    else
      Parser.parse(files, type)
    end
  end

  private
  def self.sent_notification(res)
    "Successfully Sent Shipment to Fosdick. Confirmation ##{res}"
  end

  def self.empty_notification(type)
    if type == 'ship'
      'There were no shipment result files available for download'
    else
      'There were no inventory files available'
    end
  end
end
