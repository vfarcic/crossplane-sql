#!/usr/bin/env nu

def --env "main apply ack" [
] {

    let password = (
        aws ecr-public get-login-password --region us-east-1
    )
    
    (
        helm registry login --username AWS --password $password 
            public.ecr.aws
    )

    let controllers = [
        {name: "ec2", version: "1.3.7"},
        {name: "rds", version: "1.4.14"},
    ]
    for controller in $controllers {
        (
            helm upgrade --install
                $"ack-($controller.name)-controller"
                oci://public.ecr.aws/aws-controllers-k8s/($controller.name)-chart
                $"--version=($controller.version)"
                --create-namespace --namespace ack-system
                --set aws.region=us-east-1
        )
    }

}
