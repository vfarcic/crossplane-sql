Generate Mermaid diagram of resources based on the Crossplane Compositions in `package/compositions.yaml`? I am interested only in the `Kind` and `name` of resources.

Assume that `examples/aws-eso.yaml` is used to create Composite Resource.

Include all resources into the graph.

Use references like `matchControllerRef` and `providerConfigRef` to establish relations between resources. When you see those, it means that it is a child resource.

Do not put labels on relations. Use full resource name that combines `metadata.name`, `kind`, `api`.

Avoid duplicated references between resources.

If one resource depends on the other, there is no need to reference it to the Composite Resource at the top.

Paint the Composite Resource as blue, AWS, Google Cloud, and Azure resources should be orange and all other resources should be yellow.

Use `<br>` to separate lines.

Store the output in the `examples/aws-eso-diag.md` file. Overwrite the existing content in that file if there is any.

Format the content of the output file as follows.

1. Header "dot-sql"
2. Content of the `examples/aws-eso.yaml` file.
3. Mermaid diagram
