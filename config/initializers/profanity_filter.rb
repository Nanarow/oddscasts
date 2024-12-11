module ProfanityFilter
  @regex = nil

  def self.regex
    @regex
  end

  def self.load
    @regex = build_regex(load_patterns)
  end

  private

  def self.load_patterns
    file_path = Rails.root.join("config", "bad_words.txt")
    File.readlines(file_path).map(&:strip)
  rescue Errno::ENOENT
    Rails.logger.warn("ProfanityFilter: Bad words file not found. Profanity filtering disabled.")
    []
  end

  def self.build_regex(patterns)
    return nil if patterns.empty?

    Regexp.new("(?:#{patterns.join('|')})", Regexp::IGNORECASE)
  end
end

Rails.application.config.after_initialize do
  ProfanityFilter.load
end
