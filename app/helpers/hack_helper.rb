module HackHelper
  def prepend_characters(string, character, size)
    "#{character*size}#{string}"
  end

  def append_characters(string, character, size)
    "#{string}#{character*size}"
  end
end
