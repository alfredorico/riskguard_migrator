module RiskguardMigrator
  class Riskguard2 < ActiveRecord::Base
    self.abstract_class = true   

    def self.tablas
      connection.tables
    end

    def self.columnas(nombre_tabla)
      if connection.table_exists?(nombre_tabla)
        connection.columns(nombre_tabla).map(&:name).sort.join(',')
      else
        ""
      end

    end

  end
end
