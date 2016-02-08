json.array!(@category_reports) do |category_report|
  json.extract! category_report, :id
  json.url category_report_url(category_report, format: :json)
end
