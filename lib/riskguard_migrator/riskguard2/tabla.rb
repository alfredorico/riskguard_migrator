module RiskguardMigrator
  class Riskguard2::Tabla

    attr_reader :nombre_tabla

    def initialize(nombre_tabla, verificar_si_fue_insertada = true)
      @nombre_tabla = nombre_tabla
      @verificar_si_fue_insertada = verificar_si_fue_insertada
      @equivalencia_tablas = Hash.new{|h,k| k }.merge! ({
         'users' => 'usuarios',
         'rr_controles' => 'ro_controles',
         'rn_controles' => 'ro_controles',
         'rn_mitigantes' => 'rn_controles_mitigantes',
         'rr_mitigantes' => 'rr_controles_mitigantes',
         'rn_frecuencias' => 'ro_frecuencias',
         'rr_frecuencias' => 'ro_frecuencias',
         'rn_niveles_riesgos' => 'ro_niveles_riesgos',
         'rr_niveles_riesgos' => 'ro_niveles_riesgos',
         'rn_impactos'  => 'ro_impactos',
         'rr_impactos' => 'ro_impactos',
         'rn_frecuencias_rn_impactos' => 'ro_frecuencias_ro_impactos',
         'rr_frecuencias_rr_impactos' => 'ro_frecuencias_ro_impactos',
         'fechas_cargadas' => 'cargas_exitosas',
         'definiciones_archivos_planos' => 'proceso_de_carga_archivos'
      })
    end

    # La tabla en Riskguard2
    def tabla
      @nombre_tabla
    end

    # Las columnas en Riskguard2
    def columnas
      case tabla
      when 'users'
        'id,login,nombre_usuario, activo,email,encrypted_password,reset_password_token,reset_password_sent_at,remember_created_at,sign_in_count,current_sign_in_at,last_sign_in_at,current_sign_in_ip,last_sign_in_ip,password_salt,failed_attempts,unlock_token,locked_at,password_changed_at,created_at,updated_at,tc_dependencia_codigo,tc_unidad_codigo,tc_area_codigo,observacion'
      when 'tc_estados'
        'id,codigo,nombre,created_at,updated_at'
      when 'tc_agencias'
        'id,codigo,nombre,tc_estado_codigo,tc_tipo_agencia_codigo,tc_region_codigo,estatus_agencia_activa,created_at,updated_at'
      when 'rn_registros_riesgos'
        columnas_comunes + ',user_id'
      when 'rr_registros_riesgos'
        columnas_comunes + ',user_id'
      when 'ro_frecuencias_ro_impactos'
        'id,valor,ro_frecuencia_id,ro_impacto_id'
      when 'rn_frecuencias_rn_impactos'
        'id, valor, rn_frecuencia_id, rn_impacto_id'
      when 'rr_frecuencias_rr_impactos'
        'id, valor, rr_frecuencia_id, rr_impacto_id'
      when 'rn_mitigantes'
        'id, descripcion, procedimiento, recurso, fecha_ejecucion, mandatorio, costo_implantacion, programa_gestion, comentarios_responsable, sugerencias_riesgo, observaciones, rn_detalle_riesgo_id, rn_control_id, created_at, updated_at, ro_tipo_mitigante_id, ro_tipo_control_fase_id, ro_tipo_control_frecuencia_id, ro_tipo_control_implementacion_id, ro_tipo_control_reduccion_id, ro_tipo_control_diseno_id, tc_dependencia_codigo'
      when 'rr_mitigantes'
        'id, descripcion, procedimiento, recurso, fecha_ejecucion, mandatorio, programa_gestion, comentarios_responsable, sugerencias_riesgo, observaciones, rr_detalle_riesgo_id, rr_control_id, created_at, updated_at, ro_tipo_mitigante_id, ro_tipo_control_fase_id, ro_tipo_control_frecuencia_id, ro_tipo_control_implementacion_id, ro_tipo_control_reduccion_id, ro_tipo_control_diseno_id, tc_dependencia_codigo'
      when 'rn_detalles_riesgos'
        columnas_comunes + ',rn_frecuencia_id,rn_nivel_riesgo_id,rn_impacto_id'
      when 'rr_detalles_riesgos'
        columnas_comunes + ',rr_frecuencia_id,rr_nivel_riesgo_id,rr_impacto_id'
      when 'rr_registros_riesgos'
        columnas_comunes + ',codigo,user_id'
      when 'rr_seguimientos'
        columnas_comunes + ',rr_mitigante_id'
      when 'rn_seguimientos'
        columnas_comunes + ',rn_mitigante_id'
      when 'rr_detalles_riesgos_residuales'
        columnas_comunes + ',rr_frecuencia_id,rr_nivel_riesgo_id,rr_impacto_id'
      when 'rn_detalles_riesgos_residuales'
        columnas_comunes + ',rn_frecuencia_id,rn_nivel_riesgo_id,rn_impacto_id'
      when 'fechas_cargadas'
        columnas_comunes
      else

        columnas_comunes
      end
    end

    # La tabla en Riskguard Legacy
    def tabla_legacy
      @equivalencia_tablas[@nombre_tabla]
    end

    def columnas_legacy
      case tabla_legacy
      when 'usuarios'
        'id,nombre_usuario,nombre,activo,email,encrypted_password,reset_password_token,reset_password_sent_at,remember_created_at,sign_in_count,current_sign_in_at,last_sign_in_at,current_sign_in_ip,last_sign_in_ip,password_salt,failed_attempts,unlock_token,locked_at,password_changed_at,created_at,updated_at,tc_dependencia_codigo,tc_unidad_codigo,tc_area_codigo,observacion'
      when 'tc_estados'
        'id,id,nombre,created_at,updated_at'
      when 'tc_agencias'
        'id,codigo,nombre,tc_estado_id,tc_tipo_agencia_codigo,tc_region_codigo,estatus_agencia_activa,created_at,updated_at'
      when 'rn_registros_riesgos'
        columnas_comunes + ',1'
      when 'rr_registros_riesgos'
        columnas_comunes + ',1'
      when 'ro_frecuencias_ro_impactos'
        'id,valor,ro_frecuencia_id,ro_impacto_id'
      when 'rn_controles_mitigantes'
        "id,descripcion, procedimiento, recurso, fecha_ejecucion, mandatorio, 0, programa_gestion, '', '', '', rn_detalle_riesgo_id, rn_control_id, created_at, updated_at, 1 , 1, 1, 1, 1, 1, tc_dependencia_codigo"
      when 'rr_controles_mitigantes'
        "id, descripcion, procedimiento, recurso, fecha_ejecucion, mandatorio, programa_gestion, '', '', '', rr_detalle_riesgo_id, rr_control_id, created_at, updated_at, 1 , 1, 1, 1, 1, 1, tc_dependencia_codigo"
      when 'rn_detalles_riesgos'
        columnas_comunes + ',ro_frecuencia_id,ro_nivel_riesgo_id,ro_impacto_id'
       when 'rr_detalles_riesgos'
        columnas_comunes + ',ro_frecuencia_id,ro_nivel_riesgo_id,ro_impacto_id'
      when 'rr_seguimientos'
        columnas_comunes + ',rr_control_mitigante_id'
      when 'rn_seguimientos'
        columnas_comunes + ',rn_control_mitigante_id'
      when 'rr_detalles_riesgos_residuales'
        columnas_comunes + ',ro_frecuencia_id,ro_nivel_riesgo_id,ro_impacto_id'
      when 'rn_detalles_riesgos_residuales'
        columnas_comunes + ',ro_frecuencia_id,ro_nivel_riesgo_id,ro_impacto_id'
      when 'cargas_exitosas'
        columnas_comunes
      else
        # Para el resto de tablas
        columnas_comunes
      end.gsub(/user_id/,'usuario_id')
    end

    def columnas_comunes
      _columnas_legacy = RiskguardLegacy.columnas(tabla_legacy)
      _columnas_legacy.gsub!(/usuario_id/,'user_id')
      _columnas = Riskguard2.columnas(tabla)
      (_columnas.split(',').sort & _columnas_legacy.split(',').sort).join(',')
    end

    def sh_migracion_tabla
     <<-CADENA
     psql -U riskguard -h localhost #{RiskguardMigrator::RiskguardLegacy.connection.current_database} -c "COPY ( select #{columnas_legacy} from #{tabla_legacy}) to STDOUT  DELIMITER '|' CSV HEADER ENCODING 'utf-8'" | \
     psql -U riskguard -h localhost #{RiskguardMigrator::Riskguard2.connection.current_database} -c "
     BEGIN;
     SET CONSTRAINTS ALL DEFERRED;
     DELETE FROM #{tabla};
     COPY #{tabla}(#{columnas}) from STDIN DELIMITER '|' CSV HEADER ENCODING 'utf-8';
     #{sql_actualizar_secuencia}
     COMMIT;
     "
     CADENA
    end

    def migrar
      if RiskguardLegacy.existe_tabla?(tabla_legacy) and !tabla_fue_cargada?
        puts '---------------------------------------------------------------------------'
        print "#{tabla} ... "
        `#{sh_migracion_tabla}`
        if $?.exitstatus == 0
          Riskguard2::TablasMigradas.create!(tabla: tabla)
          print "[Ok]"
          puts ""
        else
          puts "[ERROR]"
          puts ">> COLUMAS_LEGACY: #{columnas_legacy}"
          puts ">> COLUMAS_NUEVAS: #{columnas}"
          exit(1)
        end
      end
    end

    def sql_actualizar_secuencia
      columnas.split(',').include?('id') ? "SELECT setval('#{tabla}_id_seq', COALESCE((SELECT MAX(id)+1 FROM #{tabla}), 1), false);" : ""
    end

    def tabla_fue_cargada?
      unless Riskguard2.connection.table_exists? 'r2_tablas_migradas'
        Riskguard2.connection.execute <<-SQL
        CREATE TABLE r2_tablas_migradas(
          tabla text,
          created_at timestamp with time zone default now()
        )
        SQL
      end
      @verificar_si_fue_insertada and Riskguard2::TablasMigradas.find_by(tabla: tabla)
    end

  end
end
