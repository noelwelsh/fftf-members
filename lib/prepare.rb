require 'csv'

def prepare(input, output)

  # Fields in order we extract and write them to the output file
  #
  # Syntax:
  # - String -- use value of field with this name
  # - Literal -- use this value
  # - nil -- use null as the value
  # - Array of string -- concatentate these fields to form the value
  fields = [
            'supporter_KEY', 'Email', 'First_Name', 'Last_Name',
            'Cell_Phone', 'Phone',
            ['Street', 'Street_2', 'Street_3'], 'City',
            nil, # Country ISO
            'Date_Created', 'Last_Modified',
            11, # is_member
            nil, nil, # encrypted_password and password_salt
            nil, nil, # reset_password_token and reset_password_sent_at
            nil, # remember_created_at
            nil, nil, nil, nil, nil, # sign_in_count, current_sign_in_at, last_sign_in_at, current_sign_in_ip, last_sign_in_ip
            nil, # deleted_at
            0, # is_admin
            'Source_Details', nil, # updated_by
            0, # is_volunteer
            0.6, # random
            1, # movement_id (thecatman movement)
            1, # language_id (en)
            'Zip',
            1, # join_email_sent
            1, # name_safe
            'Source',
             0, # permanently_unsubscribed,
             nil #state
           ]

  # Encode for output as CSV
  def encode(value)
    case
    when value.is_a?(String)
      if value.empty?
        'NULL'
      else
        # Quote \ with \\
        str1 = value.gsub('\\'){'\\\\'}
        # Quote " with \"
        '"' + str1.gsub('"'){'\\"'} + '"'
      end
    when value.nil?
      'NULL'
    else
      value.to_s
    end
  end

  def eval(field, row)
    case
    when field.is_a?(String)
      row[field]
    when field.is_a?(Numeric)
      field
    when field.is_a?(NilClass)
      nil
    when field.is_a?(Array)
      (field.map { |f| row[f] }).join(' ')
    end
  end

  File.open(output, 'w') do |file|
    CSV.foreach(input, { col_sep: "\t", headers: true, return_headers: false, quote_char: "\x00"}) do |row|
      output_row = (fields.map {|f| encode(eval(f, row)) }).to_csv({ quote_char: "\x00", force_quotes: false, col_sep: "\t" })
      file.write output_row
    end
  end
end
