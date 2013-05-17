require 'csv'
require 'set'

def show(input, field)
  fields = Set.new

  CSV.foreach(input, { col_sep: "\t", headers: true, return_headers: false, quote_char: "\x00"}) do |row|
    fields.add(row[field])
  end

  puts "#{fields.size} unique value(s) of #{field}, which are"
  fields.each do |value| puts value end
end
