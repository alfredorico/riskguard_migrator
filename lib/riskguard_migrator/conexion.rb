module RiskguardMigrator
  class Conexion
    def initialize(parametros={})
      #@yaml = YAML.load(ERB.new(File.read(File.expand_path("../../../config/database.yml", __FILE__))).result)
      @db1 = 'riskguard_legacy' #Indistinto de como se llame a base de datos, usara este nombre key interno
      @db2 = 'riskguard2'
      raise "Debe definir la variable de entorno RAILS_ENV" unless ENV['RAILS_ENV']
      @ambiente = ENV['RAILS_ENV']
      @db_riskguard_legacy = parametros[:db_riskguard_legacy] || "riskguard_#{@ambiente}"
      @usuario_riskguard_legacy = parametros[:usuario_riskguard_legacy] || 'riskguard'
      @password_riskguard_legacy = parametros[:password_riskguard_legacy] || 'riskguard'
      @yaml = {
        @db1 => {
          @ambiente => {"adapter"=>"postgresql", "encoding"=>"unicode", "username"=>@usuario_riskguard_legacy, "password"=>@password_riskguard_legacy, "host"=>"localhost", "port"=>5432, "pool"=>5, "database"=>@db_riskguard_legacy}
        },
        @db2 => {
          @ambiente => {"adapter"=>"postgresql", "encoding"=>"unicode", "username"=>"riskguard", "password"=>"riskguard", "host"=>"localhost", "port"=>5432, "pool"=>5, "database"=>"riskguard2_#{@ambiente}"}
        }
      }
    end

    def preparar
      ActiveRecord::Base.configurations[@db1] = configuracion_db1
      ActiveRecord::Base.configurations[@db2] = configuracion_db2
      RiskguardLegacy.establish_connection(:riskguard_legacy)
      Riskguard2.establish_connection(:riskguard2)
    end

    def configuracion_db1
       @yaml[@db1][ambiente]
    end

    def configuracion_db2
       @yaml[@db2][ambiente]
    end

    def ambiente
      @ambiente
    end
  end
end
#RiskguardMigrator::Conexion.new.preparar
