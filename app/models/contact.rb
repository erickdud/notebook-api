class Contact < ApplicationRecord
  belongs_to :kind
  has_many :phones

  accepts_nested_attributes_for :phones, allow_destroy: true

  def as_json(_options = {})
    hash = super(except: %i[created_at updated_at kind_id id])
    hash[:birthdate] = birthdate_formatted_ptbr
    hash[:kind] = kind.description
    hash[:phones] = phones.as_json(only: %i[number])
    hash
  end

  private

  def birthdate_formatted_ptbr
    I18n.localize(birthdate) unless birthdate.blank?
  end

  def locale_to_ptbr
    I18n.locale = :pt_BR
  end
end
