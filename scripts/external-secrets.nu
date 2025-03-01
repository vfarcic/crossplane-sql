#!/usr/bin/env nu

def "main apply external_secrets" [
    provider: string            # Supported values: `google`
    --google_project_id: string # Used only if `provider` is `google`
] {

    (
        helm repo add external-secrets
            https://charts.external-secrets.io
    )

    helm repo update

    (
        helm upgrade --install
            external-secrets external-secrets/external-secrets
            --namespace external-secrets --create-namespace
            --wait
    )

    if $provider == "google" {

        {
            apiVersion: "external-secrets.io/v1beta1"
            kind: "ClusterSecretStore"
            metadata: {
                name: "google"
            }
            spec: {
                provider: {
                    gcpsm: {
                        auth: {
                            secretRef: {
                                secretAccessKeySecretRef: {
                                    name: "gcp-creds"
                                    key: "creds"
                                    namespace: "crossplane-system"
                                }
                            }
                        }
                        projectID: $google_project_id
                    }
                }
            }
        } | to yaml |
            kubectl apply --filename -

            start $"https://console.developers.google.com/apis/api/secretmanager.googleapis.com/overview?project=($google_project_id)"
            
            print $"
(ansi yellow_bold)ENABLE(ansi reset) the API.
Press the (ansi yellow_bold)enter key(ansi reset) to continue.
"
            input

    }

}
