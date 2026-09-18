{{- define "stream-orchestrator.image" -}}
{{- $root := index . 0 -}}
{{- $image := index . 1 -}}
{{- if and (hasKey $image "useGlobalRegistry") (not $image.useGlobalRegistry) -}}
{{ printf "%s:%s" $image.repository $image.tag }}
{{- else if contains "/" $image.repository -}}
{{ printf "%s:%s" $image.repository $image.tag }}
{{- else -}}
{{ printf "%s/%s:%s" $root.Values.global.imageRegistry $image.repository $image.tag }}
{{- end -}}
{{- end -}}

{{- define "stream-orchestrator.orchestratorNamespace" -}}
{{ .Values.namespaces.orchestrator }}
{{- end -}}

{{- define "stream-orchestrator.streamingNamespace" -}}
{{ .Values.namespaces.streaming }}
{{- end -}}

{{- define "stream-orchestrator.monitoringNamespace" -}}
{{ .Values.namespaces.monitoring }}
{{- end -}}

{{- define "stream-orchestrator.dbSecretName" -}}
{{- if .Values.database.external.existingSecret -}}
{{ .Values.database.external.existingSecret }}
{{- else -}}
orchestrator-secrets
{{- end -}}
{{- end -}}

{{- define "stream-orchestrator.dbSecretKey" -}}
{{- if .Values.database.external.existingSecret -}}
{{ .Values.database.external.existingSecretKey }}
{{- else -}}
DB_URL
{{- end -}}
{{- end -}}

{{- define "stream-orchestrator.rabbitmqSecretName" -}}
{{- if .Values.rabbitmqConnection.external.existingSecret -}}
{{ .Values.rabbitmqConnection.external.existingSecret }}
{{- else -}}
orchestrator-secrets
{{- end -}}
{{- end -}}

{{- define "stream-orchestrator.rabbitmqSecretKey" -}}
{{- if .Values.rabbitmqConnection.external.existingSecret -}}
{{ .Values.rabbitmqConnection.external.existingSecretKey }}
{{- else -}}
RABBITMQ_URL
{{- end -}}
{{- end -}}

{{- define "stream-orchestrator.dbUrl" -}}
{{- if .Values.postgresql.enabled -}}
{{ printf "postgres://%s:%s@postgresql.%s.svc.%s:5432/%s?sslmode=disable" .Values.postgresql.auth.username .Values.postgresql.auth.password .Values.namespaces.orchestrator .Values.global.clusterDomain .Values.postgresql.auth.database }}
{{- else if .Values.database.external.url -}}
{{ .Values.database.external.url }}
{{- end -}}
{{- end -}}

{{- define "stream-orchestrator.rabbitmqUrl" -}}
{{- if .Values.rabbitmq.enabled -}}
{{ printf "amqp://%s:%s@rabbitmq.%s.svc.%s:5672/" .Values.rabbitmq.auth.username .Values.rabbitmq.auth.password .Values.namespaces.orchestrator .Values.global.clusterDomain }}
{{- else if .Values.rabbitmqConnection.external.url -}}
{{ .Values.rabbitmqConnection.external.url }}
{{- end -}}
{{- end -}}
