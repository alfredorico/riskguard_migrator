module RiskguardMigrator
  class RiskguardLegacy < ActiveRecord::Base
    self.abstract_class = true
    #establish_connection(:riskguard_legacy)

    def self.tablas
      connection.tables
    end

    def self.columnas(nombre_tabla)
      if existe_tabla?(nombre_tabla)
        connection.columns(nombre_tabla).map(&:name).sort.join(',')
      else
        ""
      end
    end

    def self.existe_tabla?(nombre_tabla)
      connection.table_exists?(nombre_tabla)
    end

  end
end
