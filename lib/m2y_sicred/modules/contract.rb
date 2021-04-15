module M2ySicred
  class Contract < Base
    # POST /api/Contrato/{codEmpresa}/{cpf}/cliente
    def self.register_client(body)
      company_code_path = "/#{body[:empresa]}/"
      post(base_url + CONTRACT_PATH + company_code_path + body[:cpf] + CLIENT_PATH, body)
    end

     # GET /api/Contrato/{codEmpresa}/{cpf}/cliente
     def self.get_client(company_code, cpf)
      company_code_path = "/#{company_code}/"
      get(base_url + CONTRACT_PATH + company_code_path + cpf + CLIENT_PATH)
    end
  end
end