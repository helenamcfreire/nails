class Request < ActiveRecord::Base

  belongs_to :user
  attr_accessible :address, :price, :status, :is_phone, :user_id

  validates :address, :status, :user_id, :presence => true
  validates_numericality_of :price, :allow_blank => true
  validate :has_requests_being_processed?
  validate :is_price_blank?

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


  def has_requests_being_processed?
      @requests_being_processed = Request.all :include => [:user], :conditions => ['users.id = ? AND status = ?', User.current_user.id, EM_PROCESSAMENTO]
      self.errors.add :base, 'Oh ow..voce ja tem um pedido sendo processado.' if @requests_being_processed.any?
  end

  def is_price_blank?
    self.errors.add :base, 'Oh ow..voce precisa informar um valor antes de aprovar.' if self.status == APROVADO && self.price.blank?
  end

end