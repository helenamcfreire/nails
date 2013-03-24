class Request < ActiveRecord::Base

  belongs_to :user
  belongs_to :local
  attr_accessible :address, :number, :complement, :price, :status, :is_phone, :user_id, :local_id, :payment

  validates :address, :number, :complement, :status, :user_id, :local_id, :presence => true
  validates :price, :payment,   :presence => true, :if => :is_approved?
  validates_numericality_of :price, :greater_than => 0, :less_than => 100, :allow_blank => true
  validates_numericality_of :number, :complement
  validate :has_requests_being_processed?

  EM_PROCESSAMENTO = 'P'
  APROVADO = 'A'
  RECUSADO = 'R'

  def statusAsText
    if self.status == EM_PROCESSAMENTO
      I18n.t('processamento')
    elsif self.status == APROVADO
      I18n.t('aprovado')
    elsif self.status == RECUSADO
      I18n.t('recusado')
    end
  end

  EM_DINHEIRO = 'D'
  CARTAO = 'C'

  def paymentAsText
    if self.payment == EM_DINHEIRO
      I18n.t('em_dinheiro')
    elsif self.payment == CARTAO
      I18n.t('cartao')
    end
  end

  def has_requests_being_processed?
    @requests_being_processed = Request.all :include => [:user], :conditions => ['users.id = ? AND status = ?', User.current_user.id, EM_PROCESSAMENTO]
    self.errors.add :base, I18n.t('ja_tem_pedido_sendo_processado') if @requests_being_processed.any?
  end

  def is_approved?
    self.status == APROVADO
  end

end