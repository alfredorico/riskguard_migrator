module RiskguardMigrator
  class Migrator

    def initialize(parametros_migracion = {})
      @tablas_para_cargar = Riskguard2::TablasParaCargar.new(parametros_migracion)
    end

    def ejecutar_migracion
      @tablas_para_cargar.listado_tablas_para_cargar.each do |tabla|
        tabla.migrar
      end
      # Hooks postmigracion
      Riskguard2.connection.execute <<-SQL
        -- 1er Hook:
        UPDATE definiciones_archivos_planos
        SET columnas = REPLACE (columnas, 'tc_estado_id', 'tc_estado_codigo')
        WHERE prefijo = 'TCAG';
        -- 2do Hook:
        UPDATE definiciones_archivos_planos
        SET columnas = REPLACE (columnas, 'fecha_snapshot', 'created_at')
        WHERE prefijo = 'RCGA';
        -- 2do Hook:
        UPDATE definiciones_archivos_planos
        SET tipo_carga = 'INCREMENTAL'
        WHERE prefijo = 'RCCG';
      SQL
    end

  end
end
