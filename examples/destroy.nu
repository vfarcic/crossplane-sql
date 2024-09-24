#!/usr/bin/env nu

def main [] {

    let hyperscaler = (open settings.yaml | get hyperscaler)

    (
        kubectl --namespace a-team delete
            --filename $"examples/($hyperscaler).yaml"
    )

    mut counter = 999; loop {
        $counter = ( kubectl get managed | detect columns | length )
        if $counter == 0 {
            break
        }
        print $"Waiting for ($counter) resources to be deleted..."
        sleep 10sec
    }

    open config.yaml
        | upsert spec.package "xpkg.upbound.io/devops-toolkit/dot-sql:v0.8.132"
        | save config.yaml --force

    kind delete cluster

    if $hyperscaler == "google" {

        let project_id = (
            open settings.yaml | get google.projectID
        )

        gcloud projects delete $project_id --quiet

    }

}
