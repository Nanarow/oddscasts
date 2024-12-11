module Contentable
  extend ActiveSupport::Concern

  included do
    has_one_attached :cover

    has_one :content, as: :contentable, autosave: true, dependent: :destroy
    delegate :title, :description, to: :content, allow_nil: true

    after_initialize :ensure_content
    validate :profanity
  end

  def title=(value)
    ensure_content
    content.title = value
  end

  def description=(value)
    ensure_content
    content.description = value
  end

  private

  def profanity
    return if ProfanityFilter.regex.nil?

    if content.title.present? && content.title.match?(ProfanityFilter.regex)
      errors.add(:title, "contains inappropriate content")
    end

    if content.description.present? && content.description.match?(ProfanityFilter.regex)
      errors.add(:description, "contains inappropriate content")
    end
  end

  def ensure_content
    build_content if content.nil?
  end
end
