require 'csv'

def clean(input, output, email)
  File.open(output, 'w') do |file|
    CSV.foreach(input, { col_sep: "\t", headers: true, return_headers: true, quote_char: "\x00"}) do |row|
      unless row.header_row?
        row['Email'] = email
      end
      file.write(row.to_csv({col_sep: "\t"}))
      # puts row.to_csv({col_sep: "\t"})
    end
  end
end
