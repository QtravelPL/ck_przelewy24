module CkPrzelewy24
  module ApplicationHelper

    def p24_request_path transaction_params
      CkPrzelewy24::GetP24RequestPath.new(transaction_params).call
    end
  end
end
