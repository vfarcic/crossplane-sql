"""
This file was generated by the KCL auto-gen tool. DO NOT EDIT.
Editing this file might prove futile when you re-run the KCL auto-gen generate command.
"""
import k8s.apimachinery.pkg.apis.meta.v1


schema Configuration:
    r"""
    Configuration is the Schema for the Configurations API. Sets a PostgreSQL Configuration value on a PostgreSQL Server.

    Attributes
    ----------
    apiVersion : str, default is "dbforpostgresql.azure.upbound.io/v1beta1", required
        APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    kind : str, default is "Configuration", required
        Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    metadata : v1.ObjectMeta, default is Undefined, optional
        metadata
    spec : DbforpostgresqlAzureUpboundIoV1beta1ConfigurationSpec, default is Undefined, required
        spec
    status : DbforpostgresqlAzureUpboundIoV1beta1ConfigurationStatus, default is Undefined, optional
        status
    """


    apiVersion: "dbforpostgresql.azure.upbound.io/v1beta1" = "dbforpostgresql.azure.upbound.io/v1beta1"

    kind: "Configuration" = "Configuration"

    metadata?: v1.ObjectMeta

    spec: DbforpostgresqlAzureUpboundIoV1beta1ConfigurationSpec

    status?: DbforpostgresqlAzureUpboundIoV1beta1ConfigurationStatus


schema DbforpostgresqlAzureUpboundIoV1beta1ConfigurationSpec:
    r"""
    ConfigurationSpec defines the desired state of Configuration

    Attributes
    ----------
    deletionPolicy : str, default is "Delete", optional
        DeletionPolicy specifies what will happen to the underlying external
        when this managed resource is deleted - either "Delete" or "Orphan" the
        external resource.
        This field is planned to be deprecated in favor of the ManagementPolicies
        field in a future release. Currently, both could be set independently and
        non-default values would be honored if the feature flag is enabled.
        See the design doc for more information: https://github.com/crossplane/crossplane/blob/499895a25d1a1a0ba1604944ef98ac7a1a71f197/design/design-doc-observe-only-resources.md?plain=1#L223
    forProvider : DbforpostgresqlAzureUpboundIoV1beta1ConfigurationSpecForProvider, default is Undefined, required
        for provider
    initProvider : DbforpostgresqlAzureUpboundIoV1beta1ConfigurationSpecInitProvider, default is Undefined, optional
        init provider
    managementPolicies : [str], default is ["*"], optional
        THIS IS A BETA FIELD. It is on by default but can be opted out
        through a Crossplane feature flag.
        ManagementPolicies specify the array of actions Crossplane is allowed to
        take on the managed and external resources.
        This field is planned to replace the DeletionPolicy field in a future
        release. Currently, both could be set independently and non-default
        values would be honored if the feature flag is enabled. If both are
        custom, the DeletionPolicy field will be ignored.
        See the design doc for more information: https://github.com/crossplane/crossplane/blob/499895a25d1a1a0ba1604944ef98ac7a1a71f197/design/design-doc-observe-only-resources.md?plain=1#L223
        and this one: https://github.com/crossplane/crossplane/blob/444267e84783136daa93568b364a5f01228cacbe/design/one-pager-ignore-changes.md
    providerConfigRef : DbforpostgresqlAzureUpboundIoV1beta1ConfigurationSpecProviderConfigRef, default is Undefined, optional
        provider config ref
    publishConnectionDetailsTo : DbforpostgresqlAzureUpboundIoV1beta1ConfigurationSpecPublishConnectionDetailsTo, default is Undefined, optional
        publish connection details to
    writeConnectionSecretToRef : DbforpostgresqlAzureUpboundIoV1beta1ConfigurationSpecWriteConnectionSecretToRef, default is Undefined, optional
        write connection secret to ref
    """


    deletionPolicy?: "Orphan" | "Delete" = "Delete"

    forProvider: DbforpostgresqlAzureUpboundIoV1beta1ConfigurationSpecForProvider

    initProvider?: DbforpostgresqlAzureUpboundIoV1beta1ConfigurationSpecInitProvider

    managementPolicies?: [str] = ["*"]

    providerConfigRef?: DbforpostgresqlAzureUpboundIoV1beta1ConfigurationSpecProviderConfigRef

    publishConnectionDetailsTo?: DbforpostgresqlAzureUpboundIoV1beta1ConfigurationSpecPublishConnectionDetailsTo

    writeConnectionSecretToRef?: DbforpostgresqlAzureUpboundIoV1beta1ConfigurationSpecWriteConnectionSecretToRef


schema DbforpostgresqlAzureUpboundIoV1beta1ConfigurationSpecForProvider:
    r"""
    dbforpostgresql azure upbound io v1beta1 configuration spec for provider

    Attributes
    ----------
    name : str, default is Undefined, optional
        Specifies the name of the PostgreSQL Configuration, which needs to be a valid PostgreSQL configuration name. Changing this forces a new resource to be created.
    resourceGroupName : str, default is Undefined, optional
        The name of the resource group in which the PostgreSQL Server exists. Changing this forces a new resource to be created.
    resourceGroupNameRef : DbforpostgresqlAzureUpboundIoV1beta1ConfigurationSpecForProviderResourceGroupNameRef, default is Undefined, optional
        resource group name ref
    resourceGroupNameSelector : DbforpostgresqlAzureUpboundIoV1beta1ConfigurationSpecForProviderResourceGroupNameSelector, default is Undefined, optional
        resource group name selector
    serverName : str, default is Undefined, optional
        Specifies the name of the PostgreSQL Server. Changing this forces a new resource to be created.
    serverNameRef : DbforpostgresqlAzureUpboundIoV1beta1ConfigurationSpecForProviderServerNameRef, default is Undefined, optional
        server name ref
    serverNameSelector : DbforpostgresqlAzureUpboundIoV1beta1ConfigurationSpecForProviderServerNameSelector, default is Undefined, optional
        server name selector
    value : str, default is Undefined, optional
        Specifies the value of the PostgreSQL Configuration. See the PostgreSQL documentation for valid values. Changing this forces a new resource to be created.
    """


    name?: str

    resourceGroupName?: str

    resourceGroupNameRef?: DbforpostgresqlAzureUpboundIoV1beta1ConfigurationSpecForProviderResourceGroupNameRef

    resourceGroupNameSelector?: DbforpostgresqlAzureUpboundIoV1beta1ConfigurationSpecForProviderResourceGroupNameSelector

    serverName?: str

    serverNameRef?: DbforpostgresqlAzureUpboundIoV1beta1ConfigurationSpecForProviderServerNameRef

    serverNameSelector?: DbforpostgresqlAzureUpboundIoV1beta1ConfigurationSpecForProviderServerNameSelector

    value?: str


schema DbforpostgresqlAzureUpboundIoV1beta1ConfigurationSpecForProviderResourceGroupNameRef:
    r"""
    Reference to a ResourceGroup in azure to populate resourceGroupName.

    Attributes
    ----------
    name : str, default is Undefined, required
        Name of the referenced object.
    policy : DbforpostgresqlAzureUpboundIoV1beta1ConfigurationSpecForProviderResourceGroupNameRefPolicy, default is Undefined, optional
        policy
    """


    name: str

    policy?: DbforpostgresqlAzureUpboundIoV1beta1ConfigurationSpecForProviderResourceGroupNameRefPolicy


schema DbforpostgresqlAzureUpboundIoV1beta1ConfigurationSpecForProviderResourceGroupNameRefPolicy:
    r"""
    Policies for referencing.

    Attributes
    ----------
    resolution : str, default is "Required", optional
        Resolution specifies whether resolution of this reference is required.
        The default is 'Required', which means the reconcile will fail if the
        reference cannot be resolved. 'Optional' means this reference will be
        a no-op if it cannot be resolved.
    resolve : str, default is Undefined, optional
        Resolve specifies when this reference should be resolved. The default
        is 'IfNotPresent', which will attempt to resolve the reference only when
        the corresponding field is not present. Use 'Always' to resolve the
        reference on every reconcile.
    """


    resolution?: "Required" | "Optional" = "Required"

    resolve?: "Always" | "IfNotPresent"


schema DbforpostgresqlAzureUpboundIoV1beta1ConfigurationSpecForProviderResourceGroupNameSelector:
    r"""
    Selector for a ResourceGroup in azure to populate resourceGroupName.

    Attributes
    ----------
    matchControllerRef : bool, default is Undefined, optional
        MatchControllerRef ensures an object with the same controller reference
        as the selecting object is selected.
    matchLabels : {str:str}, default is Undefined, optional
        MatchLabels ensures an object with matching labels is selected.
    policy : DbforpostgresqlAzureUpboundIoV1beta1ConfigurationSpecForProviderResourceGroupNameSelectorPolicy, default is Undefined, optional
        policy
    """


    matchControllerRef?: bool

    matchLabels?: {str:str}

    policy?: DbforpostgresqlAzureUpboundIoV1beta1ConfigurationSpecForProviderResourceGroupNameSelectorPolicy


schema DbforpostgresqlAzureUpboundIoV1beta1ConfigurationSpecForProviderResourceGroupNameSelectorPolicy:
    r"""
    Policies for selection.

    Attributes
    ----------
    resolution : str, default is "Required", optional
        Resolution specifies whether resolution of this reference is required.
        The default is 'Required', which means the reconcile will fail if the
        reference cannot be resolved. 'Optional' means this reference will be
        a no-op if it cannot be resolved.
    resolve : str, default is Undefined, optional
        Resolve specifies when this reference should be resolved. The default
        is 'IfNotPresent', which will attempt to resolve the reference only when
        the corresponding field is not present. Use 'Always' to resolve the
        reference on every reconcile.
    """


    resolution?: "Required" | "Optional" = "Required"

    resolve?: "Always" | "IfNotPresent"


schema DbforpostgresqlAzureUpboundIoV1beta1ConfigurationSpecForProviderServerNameRef:
    r"""
    Reference to a Server in dbforpostgresql to populate serverName.

    Attributes
    ----------
    name : str, default is Undefined, required
        Name of the referenced object.
    policy : DbforpostgresqlAzureUpboundIoV1beta1ConfigurationSpecForProviderServerNameRefPolicy, default is Undefined, optional
        policy
    """


    name: str

    policy?: DbforpostgresqlAzureUpboundIoV1beta1ConfigurationSpecForProviderServerNameRefPolicy


schema DbforpostgresqlAzureUpboundIoV1beta1ConfigurationSpecForProviderServerNameRefPolicy:
    r"""
    Policies for referencing.

    Attributes
    ----------
    resolution : str, default is "Required", optional
        Resolution specifies whether resolution of this reference is required.
        The default is 'Required', which means the reconcile will fail if the
        reference cannot be resolved. 'Optional' means this reference will be
        a no-op if it cannot be resolved.
    resolve : str, default is Undefined, optional
        Resolve specifies when this reference should be resolved. The default
        is 'IfNotPresent', which will attempt to resolve the reference only when
        the corresponding field is not present. Use 'Always' to resolve the
        reference on every reconcile.
    """


    resolution?: "Required" | "Optional" = "Required"

    resolve?: "Always" | "IfNotPresent"


schema DbforpostgresqlAzureUpboundIoV1beta1ConfigurationSpecForProviderServerNameSelector:
    r"""
    Selector for a Server in dbforpostgresql to populate serverName.

    Attributes
    ----------
    matchControllerRef : bool, default is Undefined, optional
        MatchControllerRef ensures an object with the same controller reference
        as the selecting object is selected.
    matchLabels : {str:str}, default is Undefined, optional
        MatchLabels ensures an object with matching labels is selected.
    policy : DbforpostgresqlAzureUpboundIoV1beta1ConfigurationSpecForProviderServerNameSelectorPolicy, default is Undefined, optional
        policy
    """


    matchControllerRef?: bool

    matchLabels?: {str:str}

    policy?: DbforpostgresqlAzureUpboundIoV1beta1ConfigurationSpecForProviderServerNameSelectorPolicy


schema DbforpostgresqlAzureUpboundIoV1beta1ConfigurationSpecForProviderServerNameSelectorPolicy:
    r"""
    Policies for selection.

    Attributes
    ----------
    resolution : str, default is "Required", optional
        Resolution specifies whether resolution of this reference is required.
        The default is 'Required', which means the reconcile will fail if the
        reference cannot be resolved. 'Optional' means this reference will be
        a no-op if it cannot be resolved.
    resolve : str, default is Undefined, optional
        Resolve specifies when this reference should be resolved. The default
        is 'IfNotPresent', which will attempt to resolve the reference only when
        the corresponding field is not present. Use 'Always' to resolve the
        reference on every reconcile.
    """


    resolution?: "Required" | "Optional" = "Required"

    resolve?: "Always" | "IfNotPresent"


schema DbforpostgresqlAzureUpboundIoV1beta1ConfigurationSpecInitProvider:
    r"""
    THIS IS A BETA FIELD. It will be honored
    unless the Management Policies feature flag is disabled.
    InitProvider holds the same fields as ForProvider, with the exception
    of Identifier and other resource reference fields. The fields that are
    in InitProvider are merged into ForProvider when the resource is created.
    The same fields are also added to the terraform ignore_changes hook, to
    avoid updating them after creation. This is useful for fields that are
    required on creation, but we do not desire to update them after creation,
    for example because of an external controller is managing them, like an
    autoscaler.

    Attributes
    ----------
    name : str, default is Undefined, optional
        Specifies the name of the PostgreSQL Configuration, which needs to be a valid PostgreSQL configuration name. Changing this forces a new resource to be created.
    resourceGroupName : str, default is Undefined, optional
        The name of the resource group in which the PostgreSQL Server exists. Changing this forces a new resource to be created.
    resourceGroupNameRef : DbforpostgresqlAzureUpboundIoV1beta1ConfigurationSpecInitProviderResourceGroupNameRef, default is Undefined, optional
        resource group name ref
    resourceGroupNameSelector : DbforpostgresqlAzureUpboundIoV1beta1ConfigurationSpecInitProviderResourceGroupNameSelector, default is Undefined, optional
        resource group name selector
    serverName : str, default is Undefined, optional
        Specifies the name of the PostgreSQL Server. Changing this forces a new resource to be created.
    serverNameRef : DbforpostgresqlAzureUpboundIoV1beta1ConfigurationSpecInitProviderServerNameRef, default is Undefined, optional
        server name ref
    serverNameSelector : DbforpostgresqlAzureUpboundIoV1beta1ConfigurationSpecInitProviderServerNameSelector, default is Undefined, optional
        server name selector
    value : str, default is Undefined, optional
        Specifies the value of the PostgreSQL Configuration. See the PostgreSQL documentation for valid values. Changing this forces a new resource to be created.
    """


    name?: str

    resourceGroupName?: str

    resourceGroupNameRef?: DbforpostgresqlAzureUpboundIoV1beta1ConfigurationSpecInitProviderResourceGroupNameRef

    resourceGroupNameSelector?: DbforpostgresqlAzureUpboundIoV1beta1ConfigurationSpecInitProviderResourceGroupNameSelector

    serverName?: str

    serverNameRef?: DbforpostgresqlAzureUpboundIoV1beta1ConfigurationSpecInitProviderServerNameRef

    serverNameSelector?: DbforpostgresqlAzureUpboundIoV1beta1ConfigurationSpecInitProviderServerNameSelector

    value?: str


schema DbforpostgresqlAzureUpboundIoV1beta1ConfigurationSpecInitProviderResourceGroupNameRef:
    r"""
    Reference to a ResourceGroup in azure to populate resourceGroupName.

    Attributes
    ----------
    name : str, default is Undefined, required
        Name of the referenced object.
    policy : DbforpostgresqlAzureUpboundIoV1beta1ConfigurationSpecInitProviderResourceGroupNameRefPolicy, default is Undefined, optional
        policy
    """


    name: str

    policy?: DbforpostgresqlAzureUpboundIoV1beta1ConfigurationSpecInitProviderResourceGroupNameRefPolicy


schema DbforpostgresqlAzureUpboundIoV1beta1ConfigurationSpecInitProviderResourceGroupNameRefPolicy:
    r"""
    Policies for referencing.

    Attributes
    ----------
    resolution : str, default is "Required", optional
        Resolution specifies whether resolution of this reference is required.
        The default is 'Required', which means the reconcile will fail if the
        reference cannot be resolved. 'Optional' means this reference will be
        a no-op if it cannot be resolved.
    resolve : str, default is Undefined, optional
        Resolve specifies when this reference should be resolved. The default
        is 'IfNotPresent', which will attempt to resolve the reference only when
        the corresponding field is not present. Use 'Always' to resolve the
        reference on every reconcile.
    """


    resolution?: "Required" | "Optional" = "Required"

    resolve?: "Always" | "IfNotPresent"


schema DbforpostgresqlAzureUpboundIoV1beta1ConfigurationSpecInitProviderResourceGroupNameSelector:
    r"""
    Selector for a ResourceGroup in azure to populate resourceGroupName.

    Attributes
    ----------
    matchControllerRef : bool, default is Undefined, optional
        MatchControllerRef ensures an object with the same controller reference
        as the selecting object is selected.
    matchLabels : {str:str}, default is Undefined, optional
        MatchLabels ensures an object with matching labels is selected.
    policy : DbforpostgresqlAzureUpboundIoV1beta1ConfigurationSpecInitProviderResourceGroupNameSelectorPolicy, default is Undefined, optional
        policy
    """


    matchControllerRef?: bool

    matchLabels?: {str:str}

    policy?: DbforpostgresqlAzureUpboundIoV1beta1ConfigurationSpecInitProviderResourceGroupNameSelectorPolicy


schema DbforpostgresqlAzureUpboundIoV1beta1ConfigurationSpecInitProviderResourceGroupNameSelectorPolicy:
    r"""
    Policies for selection.

    Attributes
    ----------
    resolution : str, default is "Required", optional
        Resolution specifies whether resolution of this reference is required.
        The default is 'Required', which means the reconcile will fail if the
        reference cannot be resolved. 'Optional' means this reference will be
        a no-op if it cannot be resolved.
    resolve : str, default is Undefined, optional
        Resolve specifies when this reference should be resolved. The default
        is 'IfNotPresent', which will attempt to resolve the reference only when
        the corresponding field is not present. Use 'Always' to resolve the
        reference on every reconcile.
    """


    resolution?: "Required" | "Optional" = "Required"

    resolve?: "Always" | "IfNotPresent"


schema DbforpostgresqlAzureUpboundIoV1beta1ConfigurationSpecInitProviderServerNameRef:
    r"""
    Reference to a Server in dbforpostgresql to populate serverName.

    Attributes
    ----------
    name : str, default is Undefined, required
        Name of the referenced object.
    policy : DbforpostgresqlAzureUpboundIoV1beta1ConfigurationSpecInitProviderServerNameRefPolicy, default is Undefined, optional
        policy
    """


    name: str

    policy?: DbforpostgresqlAzureUpboundIoV1beta1ConfigurationSpecInitProviderServerNameRefPolicy


schema DbforpostgresqlAzureUpboundIoV1beta1ConfigurationSpecInitProviderServerNameRefPolicy:
    r"""
    Policies for referencing.

    Attributes
    ----------
    resolution : str, default is "Required", optional
        Resolution specifies whether resolution of this reference is required.
        The default is 'Required', which means the reconcile will fail if the
        reference cannot be resolved. 'Optional' means this reference will be
        a no-op if it cannot be resolved.
    resolve : str, default is Undefined, optional
        Resolve specifies when this reference should be resolved. The default
        is 'IfNotPresent', which will attempt to resolve the reference only when
        the corresponding field is not present. Use 'Always' to resolve the
        reference on every reconcile.
    """


    resolution?: "Required" | "Optional" = "Required"

    resolve?: "Always" | "IfNotPresent"


schema DbforpostgresqlAzureUpboundIoV1beta1ConfigurationSpecInitProviderServerNameSelector:
    r"""
    Selector for a Server in dbforpostgresql to populate serverName.

    Attributes
    ----------
    matchControllerRef : bool, default is Undefined, optional
        MatchControllerRef ensures an object with the same controller reference
        as the selecting object is selected.
    matchLabels : {str:str}, default is Undefined, optional
        MatchLabels ensures an object with matching labels is selected.
    policy : DbforpostgresqlAzureUpboundIoV1beta1ConfigurationSpecInitProviderServerNameSelectorPolicy, default is Undefined, optional
        policy
    """


    matchControllerRef?: bool

    matchLabels?: {str:str}

    policy?: DbforpostgresqlAzureUpboundIoV1beta1ConfigurationSpecInitProviderServerNameSelectorPolicy


schema DbforpostgresqlAzureUpboundIoV1beta1ConfigurationSpecInitProviderServerNameSelectorPolicy:
    r"""
    Policies for selection.

    Attributes
    ----------
    resolution : str, default is "Required", optional
        Resolution specifies whether resolution of this reference is required.
        The default is 'Required', which means the reconcile will fail if the
        reference cannot be resolved. 'Optional' means this reference will be
        a no-op if it cannot be resolved.
    resolve : str, default is Undefined, optional
        Resolve specifies when this reference should be resolved. The default
        is 'IfNotPresent', which will attempt to resolve the reference only when
        the corresponding field is not present. Use 'Always' to resolve the
        reference on every reconcile.
    """


    resolution?: "Required" | "Optional" = "Required"

    resolve?: "Always" | "IfNotPresent"


schema DbforpostgresqlAzureUpboundIoV1beta1ConfigurationSpecProviderConfigRef:
    r"""
    ProviderConfigReference specifies how the provider that will be used to
    create, observe, update, and delete this managed resource should be
    configured.

    Attributes
    ----------
    name : str, default is Undefined, required
        Name of the referenced object.
    policy : DbforpostgresqlAzureUpboundIoV1beta1ConfigurationSpecProviderConfigRefPolicy, default is Undefined, optional
        policy
    """


    name: str

    policy?: DbforpostgresqlAzureUpboundIoV1beta1ConfigurationSpecProviderConfigRefPolicy


schema DbforpostgresqlAzureUpboundIoV1beta1ConfigurationSpecProviderConfigRefPolicy:
    r"""
    Policies for referencing.

    Attributes
    ----------
    resolution : str, default is "Required", optional
        Resolution specifies whether resolution of this reference is required.
        The default is 'Required', which means the reconcile will fail if the
        reference cannot be resolved. 'Optional' means this reference will be
        a no-op if it cannot be resolved.
    resolve : str, default is Undefined, optional
        Resolve specifies when this reference should be resolved. The default
        is 'IfNotPresent', which will attempt to resolve the reference only when
        the corresponding field is not present. Use 'Always' to resolve the
        reference on every reconcile.
    """


    resolution?: "Required" | "Optional" = "Required"

    resolve?: "Always" | "IfNotPresent"


schema DbforpostgresqlAzureUpboundIoV1beta1ConfigurationSpecPublishConnectionDetailsTo:
    r"""
    PublishConnectionDetailsTo specifies the connection secret config which
    contains a name, metadata and a reference to secret store config to
    which any connection details for this managed resource should be written.
    Connection details frequently include the endpoint, username,
    and password required to connect to the managed resource.

    Attributes
    ----------
    configRef : DbforpostgresqlAzureUpboundIoV1beta1ConfigurationSpecPublishConnectionDetailsToConfigRef, default is Undefined, optional
        config ref
    metadata : DbforpostgresqlAzureUpboundIoV1beta1ConfigurationSpecPublishConnectionDetailsToMetadata, default is Undefined, optional
        metadata
    name : str, default is Undefined, required
        Name is the name of the connection secret.
    """


    configRef?: DbforpostgresqlAzureUpboundIoV1beta1ConfigurationSpecPublishConnectionDetailsToConfigRef

    metadata?: DbforpostgresqlAzureUpboundIoV1beta1ConfigurationSpecPublishConnectionDetailsToMetadata

    name: str


schema DbforpostgresqlAzureUpboundIoV1beta1ConfigurationSpecPublishConnectionDetailsToConfigRef:
    r"""
    SecretStoreConfigRef specifies which secret store config should be used
    for this ConnectionSecret.

    Attributes
    ----------
    name : str, default is Undefined, required
        Name of the referenced object.
    policy : DbforpostgresqlAzureUpboundIoV1beta1ConfigurationSpecPublishConnectionDetailsToConfigRefPolicy, default is Undefined, optional
        policy
    """


    name: str

    policy?: DbforpostgresqlAzureUpboundIoV1beta1ConfigurationSpecPublishConnectionDetailsToConfigRefPolicy


schema DbforpostgresqlAzureUpboundIoV1beta1ConfigurationSpecPublishConnectionDetailsToConfigRefPolicy:
    r"""
    Policies for referencing.

    Attributes
    ----------
    resolution : str, default is "Required", optional
        Resolution specifies whether resolution of this reference is required.
        The default is 'Required', which means the reconcile will fail if the
        reference cannot be resolved. 'Optional' means this reference will be
        a no-op if it cannot be resolved.
    resolve : str, default is Undefined, optional
        Resolve specifies when this reference should be resolved. The default
        is 'IfNotPresent', which will attempt to resolve the reference only when
        the corresponding field is not present. Use 'Always' to resolve the
        reference on every reconcile.
    """


    resolution?: "Required" | "Optional" = "Required"

    resolve?: "Always" | "IfNotPresent"


schema DbforpostgresqlAzureUpboundIoV1beta1ConfigurationSpecPublishConnectionDetailsToMetadata:
    r"""
    Metadata is the metadata for connection secret.

    Attributes
    ----------
    annotations : {str:str}, default is Undefined, optional
        Annotations are the annotations to be added to connection secret.
        - For Kubernetes secrets, this will be used as "metadata.annotations".
        - It is up to Secret Store implementation for others store types.
    labels : {str:str}, default is Undefined, optional
        Labels are the labels/tags to be added to connection secret.
        - For Kubernetes secrets, this will be used as "metadata.labels".
        - It is up to Secret Store implementation for others store types.
    $type : str, default is Undefined, optional
        Type is the SecretType for the connection secret.
        - Only valid for Kubernetes Secret Stores.
    """


    annotations?: {str:str}

    labels?: {str:str}

    $type?: str


schema DbforpostgresqlAzureUpboundIoV1beta1ConfigurationSpecWriteConnectionSecretToRef:
    r"""
    WriteConnectionSecretToReference specifies the namespace and name of a
    Secret to which any connection details for this managed resource should
    be written. Connection details frequently include the endpoint, username,
    and password required to connect to the managed resource.
    This field is planned to be replaced in a future release in favor of
    PublishConnectionDetailsTo. Currently, both could be set independently
    and connection details would be published to both without affecting
    each other.

    Attributes
    ----------
    name : str, default is Undefined, required
        Name of the secret.
    namespace : str, default is Undefined, required
        Namespace of the secret.
    """


    name: str

    namespace: str


schema DbforpostgresqlAzureUpboundIoV1beta1ConfigurationStatus:
    r"""
    ConfigurationStatus defines the observed state of Configuration.

    Attributes
    ----------
    atProvider : DbforpostgresqlAzureUpboundIoV1beta1ConfigurationStatusAtProvider, default is Undefined, optional
        at provider
    conditions : [DbforpostgresqlAzureUpboundIoV1beta1ConfigurationStatusConditionsItems0], default is Undefined, optional
        Conditions of the resource.
    observedGeneration : int, default is Undefined, optional
        ObservedGeneration is the latest metadata.generation
        which resulted in either a ready state, or stalled due to error
        it can not recover from without human intervention.
    """


    atProvider?: DbforpostgresqlAzureUpboundIoV1beta1ConfigurationStatusAtProvider

    conditions?: [DbforpostgresqlAzureUpboundIoV1beta1ConfigurationStatusConditionsItems0]

    observedGeneration?: int


schema DbforpostgresqlAzureUpboundIoV1beta1ConfigurationStatusAtProvider:
    r"""
    dbforpostgresql azure upbound io v1beta1 configuration status at provider

    Attributes
    ----------
    id : str, default is Undefined, optional
        The ID of the PostgreSQL Configuration.
    name : str, default is Undefined, optional
        Specifies the name of the PostgreSQL Configuration, which needs to be a valid PostgreSQL configuration name. Changing this forces a new resource to be created.
    resourceGroupName : str, default is Undefined, optional
        The name of the resource group in which the PostgreSQL Server exists. Changing this forces a new resource to be created.
    serverName : str, default is Undefined, optional
        Specifies the name of the PostgreSQL Server. Changing this forces a new resource to be created.
    value : str, default is Undefined, optional
        Specifies the value of the PostgreSQL Configuration. See the PostgreSQL documentation for valid values. Changing this forces a new resource to be created.
    """


    id?: str

    name?: str

    resourceGroupName?: str

    serverName?: str

    value?: str


schema DbforpostgresqlAzureUpboundIoV1beta1ConfigurationStatusConditionsItems0:
    r"""
    A Condition that may apply to a resource.

    Attributes
    ----------
    lastTransitionTime : str, default is Undefined, required
        LastTransitionTime is the last time this condition transitioned from one
        status to another.
    message : str, default is Undefined, optional
        A Message containing details about this condition's last transition from
        one status to another, if any.
    observedGeneration : int, default is Undefined, optional
        ObservedGeneration represents the .metadata.generation that the condition was set based upon.
        For instance, if .metadata.generation is currently 12, but the .status.conditions[x].observedGeneration is 9, the condition is out of date
        with respect to the current state of the instance.
    reason : str, default is Undefined, required
        A Reason for this condition's last transition from one status to another.
    status : str, default is Undefined, required
        Status of this condition; is it currently True, False, or Unknown?
    $type : str, default is Undefined, required
        Type of this condition. At most one of each condition type may apply to
        a resource at any point in time.
    """


    lastTransitionTime: str

    message?: str

    observedGeneration?: int

    reason: str

    status: str

    $type: str


