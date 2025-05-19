Observe the status of Kubernetes resources:

Follow these general guidelines:

- When asking user question, ask the user one question at a time.
- Use Context7 MCP to find Crossplane information you might need.
- Make a plan how you are going to execute the steps.
- Ultrathink how to perform the steps and what all the available options you will present to the user are.
- Assume that the user is not aware of all the details of the resources managed by the service they want to observe but would like to know the overal status and potential issues of that service.
- Use colors and icons to make outputs easier to read.
- Always present multiple choices as numbered lists.
- Always use full API to retrieve, get, or describe resources.

Follow these steps:

1. Discover all the Custom Resources created in that Kubernetes cluster. Include only those created as Crossplane Composite Resources with the API `devopstoolkitseries.com` and only Claims. They respresent services users consume.
2. Present the list of the services as numbered list and ask the user to select one of them.
3. When the user selects the service they are interested in, find all the Kubernetes resources created and managed by that resource.
4. Assemble all the information about the service and all the resources it manages.
5. Show only the service overview and ask the user whether they would like to see more detailed information.
