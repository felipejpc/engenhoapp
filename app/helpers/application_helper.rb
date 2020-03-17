module ApplicationHelper
  def contentful
    @client ||= Contentful::Client.new(
        access_token: ENV['e1FcWyWu3oEn08XxHZvUHohTxRq06T2fP7wWBQFVn5g'],
        space: ENV['h0hn2pnr1nct'],
        dynamic_entries: :auto,
        raise_errors: true
    )
  end
end
