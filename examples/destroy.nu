#!/usr/bin/env nu

def main [] {

    let hyperscaler = (open settings.yaml | get hyperscaler)

    (
        kubectl --namespace infra delete
            --filename $"examples/($hyperscaler).yaml"
    )

    mut counter = 999; loop {
        $counter = (
            kubectl get managed
                | grep -v "database.postgresql.sql.crossplane.io"
                | grep -v "NAME"
                | lines
                | length
        )
        if $counter == 0 {
            break
        }
        print $"Waiting for ($counter) resources to be deleted..."
        sleep 10sec
    }

    kind delete cluster

    if $hyperscaler == "google" {

        let project_id = (
            open settings.yaml | get google.projectID
        )

        gcloud projects delete $project_id --quiet

    }

}
