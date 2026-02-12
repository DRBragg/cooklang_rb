# frozen_string_literal: true

module BufferUtils
  def end_of_line?
    @buffer.peek(1) == "\n"
  end

  def end_of_buffer?
    @buffer.eos?
  end
end
