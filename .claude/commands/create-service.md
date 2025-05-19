Create Kubernetes manifests:

Follow these general guidelines:

- Show on the screen only information related to user input (the questions and the options).
- When asking user question, ask the user one question at a time.
- Ask only questions based on the CRD schema and limit them to `metadata.name`, `metadata.namespace`, and `spec`.
- Take into the account previous choices when presenting questions.
- Include any additional information you think the user might find useful (e.g., the available regions of the provider, PostgreSQL versions available in the selected provider, etc.). Use your internal knowledge base for that (do not try to discover it from the cluster).
- If the input is not mandatory, instruct the user to type `skip` if it is text input or, if they are presented with options, to select the `skip` option.
- Check the Composition to see whether values for some field are restricted and need to be specific.
- When you ask for the Namespace, give the user the option to select one of the existing Namespaces. Include only Namespaces that contain the word `team`.
- Always use `spec.crossplane.compositionSelector.matchLabels` to select the Composition in the manifest you are generating.
- Do not include parts of the manifest that are optional and the user did not choose any value.
- Use Context7 MCP to find Crossplane information you might need.
- Make a plan how you are going to execute the steps.
- Ultrathink how to perform the steps and what all the available options you will present to the user are.
- Use colors and icons to make outputs easier to read.
- If asked to provide Ingress Class, detect available Ingress Classes and present a list. If there is only one Ingress Class, do not ask the user which one to use but populate the value automatically.
- Always present multiple choices as numbered lists.
- Always use full API to retrieve, get, or describe resources.
- Explain each choice given to the user in detail.

Follow these steps:

1. Discover all the Custom Resources a user can create in that Kubernetes cluster.
2. Limit it to CRDs with the API `devopstoolkitseries.com` and include only Claims. Those CRDs were created by Crossplane Compositions.
3. Output numbered list of Composite Resources a user can create and ask them to select one of them. Ensure that all Compositions for a given CRD (Composite Resource Definition) are presented.
4. Based on the selected Composite Resource, ask the user for information you might need to generate YAML manifest that can be used to create that resource. Ensure that the user can select any of the Compositions within the selected Configuration. Present all parameters (including sub-parameters) to the user.
5. After you gather all the information you might need, generate the manifest and ask the user for the path where to save it.
6. Generate the combination of labels that match those available in Compositions so that the correct one is selected.
7. If the user selected to work with `SQL`, after creating the manifest, ask the user for the password they would like to assign to that database. The password should be stored in the Secret manifest with the key `password`. If the user selected UpCloud provider, there is no need to create the secret.
8. If the user selected to work with `SQL`, create the Kubernetes secret with that password in the same Namespace. The name of the secret should be the same as the name of the Composite resource with the addition of `-password` suffix.
9. Ask the user whether they would like to create a pull request with manifests or apply those manifests directly to the cluster.
