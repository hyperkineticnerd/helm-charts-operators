{{/*
Create the name of the credential secret
*/}}
{{- define "external-dns-operator.credentialName" -}}
{{ lower .Values.provider.type }}-credentials
{{- end }}


{{/*
Create the ExternalDNS Provider structure
*/}}
{{- define "external-dns-operator.provider" -}}
provider:
  type: {{ .Values.provider.type }}
  {{- include "external-dns-operator.provider.cloudflare" . }}
{{- end }}


{{/*
Create the Cloudflare Provider structure
*/}}
{{- define "external-dns-operator.provider.cloudflare" -}}
{{- if eq .Values.provider.type "Cloudflare" }}
cloudflare:
  credentials:
    name: {{ include "external-dns-operator.credentialName" . }}
{{- end }}
{{- end }}


{{/*
Create the ExternalDNS zones structure
*/}}
{{- define "external-dns-operator.zones" -}}
zones:
{{- toYaml .Values.provider.zones | nindent 2}}
{{- end }}


{{/*
Create the ExternalDNS sources structure
*/}}
{{- define "external-dns-operator.source" -}}
source:
  type: Service
  service:
    serviceType: 
      - NodePort
{{- include "external-dns-operator.hostnameAnnotation" . | nindent 2 }}
{{- end }}


{{/*
Set the ExternalDNS Source hostnameAnnotation
*/}}
{{- define "external-dns-operator.hostnameAnnotation" -}}
hostnameAnnotation: Allow
{{- end }}
