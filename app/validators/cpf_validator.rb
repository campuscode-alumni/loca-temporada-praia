class CpfValidator < ActiveModel::EachValidator

  def validate_each(record, attribute, value)
    unless cpf_valid?(value)
      record.errors[attribute] << (options[:message] || "#{value} Inválido")
    end
  end

  private

  def blacklist
    %w[12345678909 11111111111 22222222222 33333333333 44444444444 55555555555 66666666666 77777777777 88888888888 99999999999 00000000000 12345678909]
  end

  def cpf_valid?(cpf)
    if cpf.length == 11 && blacklist.exclude?(cpf)
      cpf_algorithm cpf
    end
  end

  def cpf_algorithm(cpf)
    cpf = cpf.scan(/[0-9]/).collect{|x| x.to_i}
    if first_step(cpf) == cpf[9]
      return true if second_step(cpf) == cpf[10]
    end
  end

  def first_step(cpf)
    sum = 10*cpf[0]+9*cpf[1]+8*cpf[2]+7*cpf[3]+6*cpf[4]+5*cpf[5]+4*cpf[6]+3*cpf[7]+2*cpf[8]
    sum = sum - (11 * (sum/11))
    (sum == 0 or sum == 1) ? 0 : 11 - sum
  end

  def second_step(cpf)
    sum = cpf[0]*11+cpf[1]*10+cpf[2]*9+cpf[3]*8+cpf[4]*7+cpf[5]*6+cpf[6]*5+cpf[7]*4+cpf[8]*3+cpf[9]*2
    sum = sum - (11 * (sum/11))
    (sum == 0 or sum == 1) ? 0 : 11 - sum
  end
end
