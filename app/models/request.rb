class Request < ActiveRecord::Base

  belongs_to :user
  attr_accessible :address, :price, :status, :is_phone, :user_id

  validates :address, :status, :user_id, :presence => true
  validates_numericality_of :price, :allow_blank => true

  EM_PROCESSAMENTO = 'P'
  APROVADO = 'A'
  RECUSADO = 'R'

  def statusAsText
    if self.status == EM_PROCESSAMENTO
      'Em Processamento'
    elsif self.status == APROVADO
      'Aprovado'
    elsif self.status == RECUSADO
      'Recusado'
    end
  end

end