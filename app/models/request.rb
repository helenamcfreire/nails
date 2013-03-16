class Request < ActiveRecord::Base

  belongs_to :user
  attr_accessible :address, :price, :status, :isPhone, :user_id

  EM_PROCESSAMENTO = 'P'
  APROVADO = 'A'
  RECUSADO = 'R'

  def statusAsText
      if self.status == 'P'
        'Em Processamento'
      elsif self.status == 'A'
        'Aprovado'
      elsif self.status == 'R'
        'Recusado'
      end
  end


end
