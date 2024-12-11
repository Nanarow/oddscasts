class Content < ApplicationRecord
  belongs_to :contentable, polymorphic: true

  enum :state, { draft: 0, in_review: 1, published: 2 } do
    event :submit_for_review do
      transition draft: :in_review
    end

    event :approve do
      transition in_review: :published
    end

    event :reject do
      transition in_review: :draft
    end
  end
end
