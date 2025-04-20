Composite resource is in `REPLACE_COMPOSITE_RESOURCE`.

Crossplane Compositions are stored in `package/compositions.yaml`.

Assume that Composite Resource is applied and that Crossplane selects the correct Composition and composes resources.

Think hard how you will generate Mermaid diagram.

Generate Mermaid diagram of resources based on the Crossplane Compositions. I am interested only in `kind`, `apiVersion`, and `name` of resources.

Include all resources into the diagram.

Use references like `matchControllerRef` and `providerConfigRef` to establish relations between resources. When you see those, it means that it is a dependency.

If you cannot find a dependency of some resource, assume that it depends on the Composite resource (the top resource).

Do not put labels on relations. Use full resource name that combines `metadata.name`, `kind`, `api`.

Avoid duplicated references between resources.

If one resource depends on the other, there is no need to reference it to the Composite Resource at the top.

Paint the Composite Resource as blue, AWS, Google Cloud, and Azure resources should be dark orange and all other resources should be purple.

Use `<br>` to separate lines.

Store the output in the file with the same as the Composite Resource but with the `diag-` prefix. Overwrite the existing content in that file if there is any.

Format the content of the output file as follows.

1. Header "dot-sql"
2. Content of the Composite Resource.
3. Mermaid diagram

Test that it renders correctly. Feel free to use https://mermaid.live if that helps testing.
