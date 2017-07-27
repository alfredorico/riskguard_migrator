# Gemas
require 'active_record'
require 'yaml'
require 'erb'
# Librerías
require "riskguard_migrator/conexion"
require "riskguard_migrator/version"
require "riskguard_migrator/riskguard_legacy"
require "riskguard_migrator/riskguard2"
require "riskguard_migrator/riskguard2/definicion_archivo_plano"
require "riskguard_migrator/riskguard2/tabla"
require "riskguard_migrator/riskguard2/tablas_migradas"
require "riskguard_migrator/riskguard2/tablas_para_cargar"
require "riskguard_migrator/migrator"

module RiskguardMigrator
  def self.ejecutar_migracion(parametros_migracion = {})
    Conexion.new(parametros_migracion).preparar
    Migrator.new(parametros_migracion).ejecutar_migracion
  end
end
