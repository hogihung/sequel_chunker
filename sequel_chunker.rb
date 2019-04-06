module SequelChunker

  CHUNK_LIMIT = (ENV['RACK_ENV'] == 'production') ? 50 : 5

  def extract_count(qry_result)
    count = 0

    qry_result.each do |key, value|
      count += key[:count]
    end

    count
  end

  def process_chunked_qry(records, qry_stmt)
    result_set = []

    return result_set if qry_stmt.nil? || records.empty?

    while records.count > 0 do
      chunk = records.pop(CHUNK_LIMIT)

      # If our chunk isn't big enough, fill it in with NULLs
      chunk.fill(nil,chunk.length,CHUNK_LIMIT) if chunk.length < CHUNK_LIMIT

      # Convert an array of values into a hash: {:p1 => "value1", :p2 => "value2", ... :pN => "valueN}
      chunk = Hash[(1..CHUNK_LIMIT).map { |i| ('p'+i.to_s).to_sym }.zip(chunk)]

      result_set += qry_stmt.call(:select, chunk)
    end
    result_set
  end

  def qry_in_clause
    return @qry_in_clause if instance_variable_defined?(:@qry_in_clause)
    @qry_in_clause = ( 1..CHUNK_LIMIT).map { |i| ":p#{i}" }.join(',')
  end

  def qry_placeholders
    return @qry_placeholders if instance_variable_defined?(:@qry_placeholders)
    @qry_placeholders = Hash[(1..CHUNK_LIMIT).map { |i| ["p#{i}".to_sym, "$p#{i}".to_sym ]}]
  end

end

