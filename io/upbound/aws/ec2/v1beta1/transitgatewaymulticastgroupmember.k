"""
This file was generated by the KCL auto-gen tool. DO NOT EDIT.
Editing this file might prove futile when you re-run the KCL auto-gen generate command.
"""
import k8s.apimachinery.pkg.apis.meta.v1


schema TransitGatewayMulticastGroupMember:
    r"""
    TransitGatewayMulticastGroupMember is the Schema for the TransitGatewayMulticastGroupMembers API. Manages an EC2 Transit Gateway Multicast Group Member

    Attributes
    ----------
    apiVersion : str, default is "ec2.aws.upbound.io/v1beta1", required
        APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    kind : str, default is "TransitGatewayMulticastGroupMember", required
        Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    metadata : v1.ObjectMeta, default is Undefined, optional
        metadata
    spec : Ec2AwsUpboundIoV1beta1TransitGatewayMulticastGroupMemberSpec, default is Undefined, required
        spec
    status : Ec2AwsUpboundIoV1beta1TransitGatewayMulticastGroupMemberStatus, default is Undefined, optional
        status
    """


    apiVersion: "ec2.aws.upbound.io/v1beta1" = "ec2.aws.upbound.io/v1beta1"

    kind: "TransitGatewayMulticastGroupMember" = "TransitGatewayMulticastGroupMember"

    metadata?: v1.ObjectMeta

    spec: Ec2AwsUpboundIoV1beta1TransitGatewayMulticastGroupMemberSpec

    status?: Ec2AwsUpboundIoV1beta1TransitGatewayMulticastGroupMemberStatus


schema Ec2AwsUpboundIoV1beta1TransitGatewayMulticastGroupMemberSpec:
    r"""
    TransitGatewayMulticastGroupMemberSpec defines the desired state of TransitGatewayMulticastGroupMember

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
    forProvider : Ec2AwsUpboundIoV1beta1TransitGatewayMulticastGroupMemberSpecForProvider, default is Undefined, required
        for provider
    initProvider : Ec2AwsUpboundIoV1beta1TransitGatewayMulticastGroupMemberSpecInitProvider, default is Undefined, optional
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
    providerConfigRef : Ec2AwsUpboundIoV1beta1TransitGatewayMulticastGroupMemberSpecProviderConfigRef, default is Undefined, optional
        provider config ref
    publishConnectionDetailsTo : Ec2AwsUpboundIoV1beta1TransitGatewayMulticastGroupMemberSpecPublishConnectionDetailsTo, default is Undefined, optional
        publish connection details to
    writeConnectionSecretToRef : Ec2AwsUpboundIoV1beta1TransitGatewayMulticastGroupMemberSpecWriteConnectionSecretToRef, default is Undefined, optional
        write connection secret to ref
    """


    deletionPolicy?: "Orphan" | "Delete" = "Delete"

    forProvider: Ec2AwsUpboundIoV1beta1TransitGatewayMulticastGroupMemberSpecForProvider

    initProvider?: Ec2AwsUpboundIoV1beta1TransitGatewayMulticastGroupMemberSpecInitProvider

    managementPolicies?: [str] = ["*"]

    providerConfigRef?: Ec2AwsUpboundIoV1beta1TransitGatewayMulticastGroupMemberSpecProviderConfigRef

    publishConnectionDetailsTo?: Ec2AwsUpboundIoV1beta1TransitGatewayMulticastGroupMemberSpecPublishConnectionDetailsTo

    writeConnectionSecretToRef?: Ec2AwsUpboundIoV1beta1TransitGatewayMulticastGroupMemberSpecWriteConnectionSecretToRef


schema Ec2AwsUpboundIoV1beta1TransitGatewayMulticastGroupMemberSpecForProvider:
    r"""
    ec2 aws upbound io v1beta1 transit gateway multicast group member spec for provider

    Attributes
    ----------
    groupIpAddress : str, default is Undefined, optional
        The IP address assigned to the transit gateway multicast group.
    networkInterfaceId : str, default is Undefined, optional
        The group members' network interface ID to register with the transit gateway multicast group.
    networkInterfaceIdRef : Ec2AwsUpboundIoV1beta1TransitGatewayMulticastGroupMemberSpecForProviderNetworkInterfaceIDRef, default is Undefined, optional
        network interface Id ref
    networkInterfaceIdSelector : Ec2AwsUpboundIoV1beta1TransitGatewayMulticastGroupMemberSpecForProviderNetworkInterfaceIDSelector, default is Undefined, optional
        network interface Id selector
    region : str, default is Undefined, required
        Region is the region you'd like your resource to be created in.
    transitGatewayMulticastDomainId : str, default is Undefined, optional
        The ID of the transit gateway multicast domain.
    transitGatewayMulticastDomainIdRef : Ec2AwsUpboundIoV1beta1TransitGatewayMulticastGroupMemberSpecForProviderTransitGatewayMulticastDomainIDRef, default is Undefined, optional
        transit gateway multicast domain Id ref
    transitGatewayMulticastDomainIdSelector : Ec2AwsUpboundIoV1beta1TransitGatewayMulticastGroupMemberSpecForProviderTransitGatewayMulticastDomainIDSelector, default is Undefined, optional
        transit gateway multicast domain Id selector
    """


    groupIpAddress?: str

    networkInterfaceId?: str

    networkInterfaceIdRef?: Ec2AwsUpboundIoV1beta1TransitGatewayMulticastGroupMemberSpecForProviderNetworkInterfaceIDRef

    networkInterfaceIdSelector?: Ec2AwsUpboundIoV1beta1TransitGatewayMulticastGroupMemberSpecForProviderNetworkInterfaceIDSelector

    region: str

    transitGatewayMulticastDomainId?: str

    transitGatewayMulticastDomainIdRef?: Ec2AwsUpboundIoV1beta1TransitGatewayMulticastGroupMemberSpecForProviderTransitGatewayMulticastDomainIDRef

    transitGatewayMulticastDomainIdSelector?: Ec2AwsUpboundIoV1beta1TransitGatewayMulticastGroupMemberSpecForProviderTransitGatewayMulticastDomainIDSelector


schema Ec2AwsUpboundIoV1beta1TransitGatewayMulticastGroupMemberSpecForProviderNetworkInterfaceIDRef:
    r"""
    Reference to a NetworkInterface in ec2 to populate networkInterfaceId.

    Attributes
    ----------
    name : str, default is Undefined, required
        Name of the referenced object.
    policy : Ec2AwsUpboundIoV1beta1TransitGatewayMulticastGroupMemberSpecForProviderNetworkInterfaceIDRefPolicy, default is Undefined, optional
        policy
    """


    name: str

    policy?: Ec2AwsUpboundIoV1beta1TransitGatewayMulticastGroupMemberSpecForProviderNetworkInterfaceIDRefPolicy


schema Ec2AwsUpboundIoV1beta1TransitGatewayMulticastGroupMemberSpecForProviderNetworkInterfaceIDRefPolicy:
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


schema Ec2AwsUpboundIoV1beta1TransitGatewayMulticastGroupMemberSpecForProviderNetworkInterfaceIDSelector:
    r"""
    Selector for a NetworkInterface in ec2 to populate networkInterfaceId.

    Attributes
    ----------
    matchControllerRef : bool, default is Undefined, optional
        MatchControllerRef ensures an object with the same controller reference
        as the selecting object is selected.
    matchLabels : {str:str}, default is Undefined, optional
        MatchLabels ensures an object with matching labels is selected.
    policy : Ec2AwsUpboundIoV1beta1TransitGatewayMulticastGroupMemberSpecForProviderNetworkInterfaceIDSelectorPolicy, default is Undefined, optional
        policy
    """


    matchControllerRef?: bool

    matchLabels?: {str:str}

    policy?: Ec2AwsUpboundIoV1beta1TransitGatewayMulticastGroupMemberSpecForProviderNetworkInterfaceIDSelectorPolicy


schema Ec2AwsUpboundIoV1beta1TransitGatewayMulticastGroupMemberSpecForProviderNetworkInterfaceIDSelectorPolicy:
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


schema Ec2AwsUpboundIoV1beta1TransitGatewayMulticastGroupMemberSpecForProviderTransitGatewayMulticastDomainIDRef:
    r"""
    Reference to a TransitGatewayMulticastDomain in ec2 to populate transitGatewayMulticastDomainId.

    Attributes
    ----------
    name : str, default is Undefined, required
        Name of the referenced object.
    policy : Ec2AwsUpboundIoV1beta1TransitGatewayMulticastGroupMemberSpecForProviderTransitGatewayMulticastDomainIDRefPolicy, default is Undefined, optional
        policy
    """


    name: str

    policy?: Ec2AwsUpboundIoV1beta1TransitGatewayMulticastGroupMemberSpecForProviderTransitGatewayMulticastDomainIDRefPolicy


schema Ec2AwsUpboundIoV1beta1TransitGatewayMulticastGroupMemberSpecForProviderTransitGatewayMulticastDomainIDRefPolicy:
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


schema Ec2AwsUpboundIoV1beta1TransitGatewayMulticastGroupMemberSpecForProviderTransitGatewayMulticastDomainIDSelector:
    r"""
    Selector for a TransitGatewayMulticastDomain in ec2 to populate transitGatewayMulticastDomainId.

    Attributes
    ----------
    matchControllerRef : bool, default is Undefined, optional
        MatchControllerRef ensures an object with the same controller reference
        as the selecting object is selected.
    matchLabels : {str:str}, default is Undefined, optional
        MatchLabels ensures an object with matching labels is selected.
    policy : Ec2AwsUpboundIoV1beta1TransitGatewayMulticastGroupMemberSpecForProviderTransitGatewayMulticastDomainIDSelectorPolicy, default is Undefined, optional
        policy
    """


    matchControllerRef?: bool

    matchLabels?: {str:str}

    policy?: Ec2AwsUpboundIoV1beta1TransitGatewayMulticastGroupMemberSpecForProviderTransitGatewayMulticastDomainIDSelectorPolicy


schema Ec2AwsUpboundIoV1beta1TransitGatewayMulticastGroupMemberSpecForProviderTransitGatewayMulticastDomainIDSelectorPolicy:
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


schema Ec2AwsUpboundIoV1beta1TransitGatewayMulticastGroupMemberSpecInitProvider:
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
    groupIpAddress : str, default is Undefined, optional
        The IP address assigned to the transit gateway multicast group.
    networkInterfaceId : str, default is Undefined, optional
        The group members' network interface ID to register with the transit gateway multicast group.
    networkInterfaceIdRef : Ec2AwsUpboundIoV1beta1TransitGatewayMulticastGroupMemberSpecInitProviderNetworkInterfaceIDRef, default is Undefined, optional
        network interface Id ref
    networkInterfaceIdSelector : Ec2AwsUpboundIoV1beta1TransitGatewayMulticastGroupMemberSpecInitProviderNetworkInterfaceIDSelector, default is Undefined, optional
        network interface Id selector
    transitGatewayMulticastDomainId : str, default is Undefined, optional
        The ID of the transit gateway multicast domain.
    transitGatewayMulticastDomainIdRef : Ec2AwsUpboundIoV1beta1TransitGatewayMulticastGroupMemberSpecInitProviderTransitGatewayMulticastDomainIDRef, default is Undefined, optional
        transit gateway multicast domain Id ref
    transitGatewayMulticastDomainIdSelector : Ec2AwsUpboundIoV1beta1TransitGatewayMulticastGroupMemberSpecInitProviderTransitGatewayMulticastDomainIDSelector, default is Undefined, optional
        transit gateway multicast domain Id selector
    """


    groupIpAddress?: str

    networkInterfaceId?: str

    networkInterfaceIdRef?: Ec2AwsUpboundIoV1beta1TransitGatewayMulticastGroupMemberSpecInitProviderNetworkInterfaceIDRef

    networkInterfaceIdSelector?: Ec2AwsUpboundIoV1beta1TransitGatewayMulticastGroupMemberSpecInitProviderNetworkInterfaceIDSelector

    transitGatewayMulticastDomainId?: str

    transitGatewayMulticastDomainIdRef?: Ec2AwsUpboundIoV1beta1TransitGatewayMulticastGroupMemberSpecInitProviderTransitGatewayMulticastDomainIDRef

    transitGatewayMulticastDomainIdSelector?: Ec2AwsUpboundIoV1beta1TransitGatewayMulticastGroupMemberSpecInitProviderTransitGatewayMulticastDomainIDSelector


schema Ec2AwsUpboundIoV1beta1TransitGatewayMulticastGroupMemberSpecInitProviderNetworkInterfaceIDRef:
    r"""
    Reference to a NetworkInterface in ec2 to populate networkInterfaceId.

    Attributes
    ----------
    name : str, default is Undefined, required
        Name of the referenced object.
    policy : Ec2AwsUpboundIoV1beta1TransitGatewayMulticastGroupMemberSpecInitProviderNetworkInterfaceIDRefPolicy, default is Undefined, optional
        policy
    """


    name: str

    policy?: Ec2AwsUpboundIoV1beta1TransitGatewayMulticastGroupMemberSpecInitProviderNetworkInterfaceIDRefPolicy


schema Ec2AwsUpboundIoV1beta1TransitGatewayMulticastGroupMemberSpecInitProviderNetworkInterfaceIDRefPolicy:
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


schema Ec2AwsUpboundIoV1beta1TransitGatewayMulticastGroupMemberSpecInitProviderNetworkInterfaceIDSelector:
    r"""
    Selector for a NetworkInterface in ec2 to populate networkInterfaceId.

    Attributes
    ----------
    matchControllerRef : bool, default is Undefined, optional
        MatchControllerRef ensures an object with the same controller reference
        as the selecting object is selected.
    matchLabels : {str:str}, default is Undefined, optional
        MatchLabels ensures an object with matching labels is selected.
    policy : Ec2AwsUpboundIoV1beta1TransitGatewayMulticastGroupMemberSpecInitProviderNetworkInterfaceIDSelectorPolicy, default is Undefined, optional
        policy
    """


    matchControllerRef?: bool

    matchLabels?: {str:str}

    policy?: Ec2AwsUpboundIoV1beta1TransitGatewayMulticastGroupMemberSpecInitProviderNetworkInterfaceIDSelectorPolicy


schema Ec2AwsUpboundIoV1beta1TransitGatewayMulticastGroupMemberSpecInitProviderNetworkInterfaceIDSelectorPolicy:
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


schema Ec2AwsUpboundIoV1beta1TransitGatewayMulticastGroupMemberSpecInitProviderTransitGatewayMulticastDomainIDRef:
    r"""
    Reference to a TransitGatewayMulticastDomain in ec2 to populate transitGatewayMulticastDomainId.

    Attributes
    ----------
    name : str, default is Undefined, required
        Name of the referenced object.
    policy : Ec2AwsUpboundIoV1beta1TransitGatewayMulticastGroupMemberSpecInitProviderTransitGatewayMulticastDomainIDRefPolicy, default is Undefined, optional
        policy
    """


    name: str

    policy?: Ec2AwsUpboundIoV1beta1TransitGatewayMulticastGroupMemberSpecInitProviderTransitGatewayMulticastDomainIDRefPolicy


schema Ec2AwsUpboundIoV1beta1TransitGatewayMulticastGroupMemberSpecInitProviderTransitGatewayMulticastDomainIDRefPolicy:
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


schema Ec2AwsUpboundIoV1beta1TransitGatewayMulticastGroupMemberSpecInitProviderTransitGatewayMulticastDomainIDSelector:
    r"""
    Selector for a TransitGatewayMulticastDomain in ec2 to populate transitGatewayMulticastDomainId.

    Attributes
    ----------
    matchControllerRef : bool, default is Undefined, optional
        MatchControllerRef ensures an object with the same controller reference
        as the selecting object is selected.
    matchLabels : {str:str}, default is Undefined, optional
        MatchLabels ensures an object with matching labels is selected.
    policy : Ec2AwsUpboundIoV1beta1TransitGatewayMulticastGroupMemberSpecInitProviderTransitGatewayMulticastDomainIDSelectorPolicy, default is Undefined, optional
        policy
    """


    matchControllerRef?: bool

    matchLabels?: {str:str}

    policy?: Ec2AwsUpboundIoV1beta1TransitGatewayMulticastGroupMemberSpecInitProviderTransitGatewayMulticastDomainIDSelectorPolicy


schema Ec2AwsUpboundIoV1beta1TransitGatewayMulticastGroupMemberSpecInitProviderTransitGatewayMulticastDomainIDSelectorPolicy:
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


schema Ec2AwsUpboundIoV1beta1TransitGatewayMulticastGroupMemberSpecProviderConfigRef:
    r"""
    ProviderConfigReference specifies how the provider that will be used to
    create, observe, update, and delete this managed resource should be
    configured.

    Attributes
    ----------
    name : str, default is Undefined, required
        Name of the referenced object.
    policy : Ec2AwsUpboundIoV1beta1TransitGatewayMulticastGroupMemberSpecProviderConfigRefPolicy, default is Undefined, optional
        policy
    """


    name: str

    policy?: Ec2AwsUpboundIoV1beta1TransitGatewayMulticastGroupMemberSpecProviderConfigRefPolicy


schema Ec2AwsUpboundIoV1beta1TransitGatewayMulticastGroupMemberSpecProviderConfigRefPolicy:
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


schema Ec2AwsUpboundIoV1beta1TransitGatewayMulticastGroupMemberSpecPublishConnectionDetailsTo:
    r"""
    PublishConnectionDetailsTo specifies the connection secret config which
    contains a name, metadata and a reference to secret store config to
    which any connection details for this managed resource should be written.
    Connection details frequently include the endpoint, username,
    and password required to connect to the managed resource.

    Attributes
    ----------
    configRef : Ec2AwsUpboundIoV1beta1TransitGatewayMulticastGroupMemberSpecPublishConnectionDetailsToConfigRef, default is Undefined, optional
        config ref
    metadata : Ec2AwsUpboundIoV1beta1TransitGatewayMulticastGroupMemberSpecPublishConnectionDetailsToMetadata, default is Undefined, optional
        metadata
    name : str, default is Undefined, required
        Name is the name of the connection secret.
    """


    configRef?: Ec2AwsUpboundIoV1beta1TransitGatewayMulticastGroupMemberSpecPublishConnectionDetailsToConfigRef

    metadata?: Ec2AwsUpboundIoV1beta1TransitGatewayMulticastGroupMemberSpecPublishConnectionDetailsToMetadata

    name: str


schema Ec2AwsUpboundIoV1beta1TransitGatewayMulticastGroupMemberSpecPublishConnectionDetailsToConfigRef:
    r"""
    SecretStoreConfigRef specifies which secret store config should be used
    for this ConnectionSecret.

    Attributes
    ----------
    name : str, default is Undefined, required
        Name of the referenced object.
    policy : Ec2AwsUpboundIoV1beta1TransitGatewayMulticastGroupMemberSpecPublishConnectionDetailsToConfigRefPolicy, default is Undefined, optional
        policy
    """


    name: str

    policy?: Ec2AwsUpboundIoV1beta1TransitGatewayMulticastGroupMemberSpecPublishConnectionDetailsToConfigRefPolicy


schema Ec2AwsUpboundIoV1beta1TransitGatewayMulticastGroupMemberSpecPublishConnectionDetailsToConfigRefPolicy:
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


schema Ec2AwsUpboundIoV1beta1TransitGatewayMulticastGroupMemberSpecPublishConnectionDetailsToMetadata:
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


schema Ec2AwsUpboundIoV1beta1TransitGatewayMulticastGroupMemberSpecWriteConnectionSecretToRef:
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


schema Ec2AwsUpboundIoV1beta1TransitGatewayMulticastGroupMemberStatus:
    r"""
    TransitGatewayMulticastGroupMemberStatus defines the observed state of TransitGatewayMulticastGroupMember.

    Attributes
    ----------
    atProvider : Ec2AwsUpboundIoV1beta1TransitGatewayMulticastGroupMemberStatusAtProvider, default is Undefined, optional
        at provider
    conditions : [Ec2AwsUpboundIoV1beta1TransitGatewayMulticastGroupMemberStatusConditionsItems0], default is Undefined, optional
        Conditions of the resource.
    observedGeneration : int, default is Undefined, optional
        ObservedGeneration is the latest metadata.generation
        which resulted in either a ready state, or stalled due to error
        it can not recover from without human intervention.
    """


    atProvider?: Ec2AwsUpboundIoV1beta1TransitGatewayMulticastGroupMemberStatusAtProvider

    conditions?: [Ec2AwsUpboundIoV1beta1TransitGatewayMulticastGroupMemberStatusConditionsItems0]

    observedGeneration?: int


schema Ec2AwsUpboundIoV1beta1TransitGatewayMulticastGroupMemberStatusAtProvider:
    r"""
    ec2 aws upbound io v1beta1 transit gateway multicast group member status at provider

    Attributes
    ----------
    groupIpAddress : str, default is Undefined, optional
        The IP address assigned to the transit gateway multicast group.
    id : str, default is Undefined, optional
        EC2 Transit Gateway Multicast Group Member identifier.
    networkInterfaceId : str, default is Undefined, optional
        The group members' network interface ID to register with the transit gateway multicast group.
    transitGatewayMulticastDomainId : str, default is Undefined, optional
        The ID of the transit gateway multicast domain.
    """


    groupIpAddress?: str

    id?: str

    networkInterfaceId?: str

    transitGatewayMulticastDomainId?: str


schema Ec2AwsUpboundIoV1beta1TransitGatewayMulticastGroupMemberStatusConditionsItems0:
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


