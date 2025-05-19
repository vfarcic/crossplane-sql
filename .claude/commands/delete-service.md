Delete Kubernetes services:

Follow these general guidelines:

- Show on the screen only information related to user input (the questions and the options).
- When asking user question, ask the user one question at a time.
- Take into the account previous choices when presenting questions.
- Use Context7 MCP to find Crossplane information you might need.
- Make a plan how you are going to execute the steps.
- Ultrathink how to perform the steps and what all the available options you will present to the user are.
- Use colors and icons to make outputs easier to read.
- Always present multiple choices as numbered lists.
- Always use full API to retrieve, get, or describe resources.

Follow these steps:

1. Discover all the Custom Resources currently running in Kubernetes cluster in any of the Namespaces.
2. Limit it to Custom Resources with the API `devopstoolkitseries.com` and include only Claims. Those CRDs were created by Crossplane Compositions.
3. Find manifests in the project that match those Custom Resources.
4. Offer the user numbered list of Custom Resources they can delete through those manifests. Allow the user to select multiple resources.
5. Offer the user to see all the resources that will be removed if those Custom Resources will be deleted. The user can choose to skip seeing those resources.
9. Ask the user whether they would like to delete the manifest and create a pull request or to delete it directly through `kubectl delete`.