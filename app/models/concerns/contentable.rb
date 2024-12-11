module Contentable
  extend ActiveSupport::Concern

  included do
    has_one_attached :cover

    has_one :content, as: :contentable, dependent: :destroy
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
    if ProfanityFilter::Base.profane?(title)
      errors.add :title, "is rude"
    end
  end

  def ensure_content
    build_content if content.nil?
  end
end
