"""
This file was generated by the KCL auto-gen tool. DO NOT EDIT.
Editing this file might prove futile when you re-run the KCL auto-gen generate command.
"""
import k8s.apimachinery.pkg.apis.meta.v1


schema VPCEndpointService:
    r"""
    VPCEndpointService is the Schema for the VPCEndpointServices API. Provides a VPC Endpoint Service resource.

    Attributes
    ----------
    apiVersion : str, default is "ec2.aws.upbound.io/v1beta1", required
        APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    kind : str, default is "VPCEndpointService", required
        Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    metadata : v1.ObjectMeta, default is Undefined, optional
        metadata
    spec : Ec2AwsUpboundIoV1beta1VPCEndpointServiceSpec, default is Undefined, required
        spec
    status : Ec2AwsUpboundIoV1beta1VPCEndpointServiceStatus, default is Undefined, optional
        status
    """


    apiVersion: "ec2.aws.upbound.io/v1beta1" = "ec2.aws.upbound.io/v1beta1"

    kind: "VPCEndpointService" = "VPCEndpointService"

    metadata?: v1.ObjectMeta

    spec: Ec2AwsUpboundIoV1beta1VPCEndpointServiceSpec

    status?: Ec2AwsUpboundIoV1beta1VPCEndpointServiceStatus


schema Ec2AwsUpboundIoV1beta1VPCEndpointServiceSpec:
    r"""
    VPCEndpointServiceSpec defines the desired state of VPCEndpointService

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
    forProvider : Ec2AwsUpboundIoV1beta1VPCEndpointServiceSpecForProvider, default is Undefined, required
        for provider
    initProvider : Ec2AwsUpboundIoV1beta1VPCEndpointServiceSpecInitProvider, default is Undefined, optional
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
    providerConfigRef : Ec2AwsUpboundIoV1beta1VPCEndpointServiceSpecProviderConfigRef, default is Undefined, optional
        provider config ref
    publishConnectionDetailsTo : Ec2AwsUpboundIoV1beta1VPCEndpointServiceSpecPublishConnectionDetailsTo, default is Undefined, optional
        publish connection details to
    writeConnectionSecretToRef : Ec2AwsUpboundIoV1beta1VPCEndpointServiceSpecWriteConnectionSecretToRef, default is Undefined, optional
        write connection secret to ref
    """


    deletionPolicy?: "Orphan" | "Delete" = "Delete"

    forProvider: Ec2AwsUpboundIoV1beta1VPCEndpointServiceSpecForProvider

    initProvider?: Ec2AwsUpboundIoV1beta1VPCEndpointServiceSpecInitProvider

    managementPolicies?: [str] = ["*"]

    providerConfigRef?: Ec2AwsUpboundIoV1beta1VPCEndpointServiceSpecProviderConfigRef

    publishConnectionDetailsTo?: Ec2AwsUpboundIoV1beta1VPCEndpointServiceSpecPublishConnectionDetailsTo

    writeConnectionSecretToRef?: Ec2AwsUpboundIoV1beta1VPCEndpointServiceSpecWriteConnectionSecretToRef


schema Ec2AwsUpboundIoV1beta1VPCEndpointServiceSpecForProvider:
    r"""
    ec2 aws upbound io v1beta1 v p c endpoint service spec for provider

    Attributes
    ----------
    acceptanceRequired : bool, default is Undefined, optional
        Whether or not VPC endpoint connection requests to the service must be accepted by the service owner - true or false.
    gatewayLoadBalancerArns : [str], default is Undefined, optional
        Amazon Resource Names (ARNs) of one or more Gateway Load Balancers for the endpoint service.
    gatewayLoadBalancerArnsRefs : [Ec2AwsUpboundIoV1beta1VPCEndpointServiceSpecForProviderGatewayLoadBalancerArnsRefsItems0], default is Undefined, optional
        References to LB in elbv2 to populate gatewayLoadBalancerArns.
    gatewayLoadBalancerArnsSelector : Ec2AwsUpboundIoV1beta1VPCEndpointServiceSpecForProviderGatewayLoadBalancerArnsSelector, default is Undefined, optional
        gateway load balancer arns selector
    networkLoadBalancerArns : [str], default is Undefined, optional
        Amazon Resource Names (ARNs) of one or more Network Load Balancers for the endpoint service.
    networkLoadBalancerArnsRefs : [Ec2AwsUpboundIoV1beta1VPCEndpointServiceSpecForProviderNetworkLoadBalancerArnsRefsItems0], default is Undefined, optional
        References to LB in elbv2 to populate networkLoadBalancerArns.
    networkLoadBalancerArnsSelector : Ec2AwsUpboundIoV1beta1VPCEndpointServiceSpecForProviderNetworkLoadBalancerArnsSelector, default is Undefined, optional
        network load balancer arns selector
    privateDnsName : str, default is Undefined, optional
        The private DNS name for the service.
    region : str, default is Undefined, required
        Region is the region you'd like your resource to be created in.
    supportedIpAddressTypes : [str], default is Undefined, optional
        The supported IP address types. The possible values are ipv4 and ipv6.
    tags : {str:str}, default is Undefined, optional
        Key-value map of resource tags.
    """


    acceptanceRequired?: bool

    gatewayLoadBalancerArns?: [str]

    gatewayLoadBalancerArnsRefs?: [Ec2AwsUpboundIoV1beta1VPCEndpointServiceSpecForProviderGatewayLoadBalancerArnsRefsItems0]

    gatewayLoadBalancerArnsSelector?: Ec2AwsUpboundIoV1beta1VPCEndpointServiceSpecForProviderGatewayLoadBalancerArnsSelector

    networkLoadBalancerArns?: [str]

    networkLoadBalancerArnsRefs?: [Ec2AwsUpboundIoV1beta1VPCEndpointServiceSpecForProviderNetworkLoadBalancerArnsRefsItems0]

    networkLoadBalancerArnsSelector?: Ec2AwsUpboundIoV1beta1VPCEndpointServiceSpecForProviderNetworkLoadBalancerArnsSelector

    privateDnsName?: str

    region: str

    supportedIpAddressTypes?: [str]

    tags?: {str:str}


schema Ec2AwsUpboundIoV1beta1VPCEndpointServiceSpecForProviderGatewayLoadBalancerArnsRefsItems0:
    r"""
    A Reference to a named object.

    Attributes
    ----------
    name : str, default is Undefined, required
        Name of the referenced object.
    policy : Ec2AwsUpboundIoV1beta1VPCEndpointServiceSpecForProviderGatewayLoadBalancerArnsRefsItems0Policy, default is Undefined, optional
        policy
    """


    name: str

    policy?: Ec2AwsUpboundIoV1beta1VPCEndpointServiceSpecForProviderGatewayLoadBalancerArnsRefsItems0Policy


schema Ec2AwsUpboundIoV1beta1VPCEndpointServiceSpecForProviderGatewayLoadBalancerArnsRefsItems0Policy:
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


schema Ec2AwsUpboundIoV1beta1VPCEndpointServiceSpecForProviderGatewayLoadBalancerArnsSelector:
    r"""
    Selector for a list of LB in elbv2 to populate gatewayLoadBalancerArns.

    Attributes
    ----------
    matchControllerRef : bool, default is Undefined, optional
        MatchControllerRef ensures an object with the same controller reference
        as the selecting object is selected.
    matchLabels : {str:str}, default is Undefined, optional
        MatchLabels ensures an object with matching labels is selected.
    policy : Ec2AwsUpboundIoV1beta1VPCEndpointServiceSpecForProviderGatewayLoadBalancerArnsSelectorPolicy, default is Undefined, optional
        policy
    """


    matchControllerRef?: bool

    matchLabels?: {str:str}

    policy?: Ec2AwsUpboundIoV1beta1VPCEndpointServiceSpecForProviderGatewayLoadBalancerArnsSelectorPolicy


schema Ec2AwsUpboundIoV1beta1VPCEndpointServiceSpecForProviderGatewayLoadBalancerArnsSelectorPolicy:
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


schema Ec2AwsUpboundIoV1beta1VPCEndpointServiceSpecForProviderNetworkLoadBalancerArnsRefsItems0:
    r"""
    A Reference to a named object.

    Attributes
    ----------
    name : str, default is Undefined, required
        Name of the referenced object.
    policy : Ec2AwsUpboundIoV1beta1VPCEndpointServiceSpecForProviderNetworkLoadBalancerArnsRefsItems0Policy, default is Undefined, optional
        policy
    """


    name: str

    policy?: Ec2AwsUpboundIoV1beta1VPCEndpointServiceSpecForProviderNetworkLoadBalancerArnsRefsItems0Policy


schema Ec2AwsUpboundIoV1beta1VPCEndpointServiceSpecForProviderNetworkLoadBalancerArnsRefsItems0Policy:
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


schema Ec2AwsUpboundIoV1beta1VPCEndpointServiceSpecForProviderNetworkLoadBalancerArnsSelector:
    r"""
    Selector for a list of LB in elbv2 to populate networkLoadBalancerArns.

    Attributes
    ----------
    matchControllerRef : bool, default is Undefined, optional
        MatchControllerRef ensures an object with the same controller reference
        as the selecting object is selected.
    matchLabels : {str:str}, default is Undefined, optional
        MatchLabels ensures an object with matching labels is selected.
    policy : Ec2AwsUpboundIoV1beta1VPCEndpointServiceSpecForProviderNetworkLoadBalancerArnsSelectorPolicy, default is Undefined, optional
        policy
    """


    matchControllerRef?: bool

    matchLabels?: {str:str}

    policy?: Ec2AwsUpboundIoV1beta1VPCEndpointServiceSpecForProviderNetworkLoadBalancerArnsSelectorPolicy


schema Ec2AwsUpboundIoV1beta1VPCEndpointServiceSpecForProviderNetworkLoadBalancerArnsSelectorPolicy:
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


schema Ec2AwsUpboundIoV1beta1VPCEndpointServiceSpecInitProvider:
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
    acceptanceRequired : bool, default is Undefined, optional
        Whether or not VPC endpoint connection requests to the service must be accepted by the service owner - true or false.
    gatewayLoadBalancerArns : [str], default is Undefined, optional
        Amazon Resource Names (ARNs) of one or more Gateway Load Balancers for the endpoint service.
    gatewayLoadBalancerArnsRefs : [Ec2AwsUpboundIoV1beta1VPCEndpointServiceSpecInitProviderGatewayLoadBalancerArnsRefsItems0], default is Undefined, optional
        References to LB in elbv2 to populate gatewayLoadBalancerArns.
    gatewayLoadBalancerArnsSelector : Ec2AwsUpboundIoV1beta1VPCEndpointServiceSpecInitProviderGatewayLoadBalancerArnsSelector, default is Undefined, optional
        gateway load balancer arns selector
    networkLoadBalancerArns : [str], default is Undefined, optional
        Amazon Resource Names (ARNs) of one or more Network Load Balancers for the endpoint service.
    networkLoadBalancerArnsRefs : [Ec2AwsUpboundIoV1beta1VPCEndpointServiceSpecInitProviderNetworkLoadBalancerArnsRefsItems0], default is Undefined, optional
        References to LB in elbv2 to populate networkLoadBalancerArns.
    networkLoadBalancerArnsSelector : Ec2AwsUpboundIoV1beta1VPCEndpointServiceSpecInitProviderNetworkLoadBalancerArnsSelector, default is Undefined, optional
        network load balancer arns selector
    privateDnsName : str, default is Undefined, optional
        The private DNS name for the service.
    supportedIpAddressTypes : [str], default is Undefined, optional
        The supported IP address types. The possible values are ipv4 and ipv6.
    tags : {str:str}, default is Undefined, optional
        Key-value map of resource tags.
    """


    acceptanceRequired?: bool

    gatewayLoadBalancerArns?: [str]

    gatewayLoadBalancerArnsRefs?: [Ec2AwsUpboundIoV1beta1VPCEndpointServiceSpecInitProviderGatewayLoadBalancerArnsRefsItems0]

    gatewayLoadBalancerArnsSelector?: Ec2AwsUpboundIoV1beta1VPCEndpointServiceSpecInitProviderGatewayLoadBalancerArnsSelector

    networkLoadBalancerArns?: [str]

    networkLoadBalancerArnsRefs?: [Ec2AwsUpboundIoV1beta1VPCEndpointServiceSpecInitProviderNetworkLoadBalancerArnsRefsItems0]

    networkLoadBalancerArnsSelector?: Ec2AwsUpboundIoV1beta1VPCEndpointServiceSpecInitProviderNetworkLoadBalancerArnsSelector

    privateDnsName?: str

    supportedIpAddressTypes?: [str]

    tags?: {str:str}


schema Ec2AwsUpboundIoV1beta1VPCEndpointServiceSpecInitProviderGatewayLoadBalancerArnsRefsItems0:
    r"""
    A Reference to a named object.

    Attributes
    ----------
    name : str, default is Undefined, required
        Name of the referenced object.
    policy : Ec2AwsUpboundIoV1beta1VPCEndpointServiceSpecInitProviderGatewayLoadBalancerArnsRefsItems0Policy, default is Undefined, optional
        policy
    """


    name: str

    policy?: Ec2AwsUpboundIoV1beta1VPCEndpointServiceSpecInitProviderGatewayLoadBalancerArnsRefsItems0Policy


schema Ec2AwsUpboundIoV1beta1VPCEndpointServiceSpecInitProviderGatewayLoadBalancerArnsRefsItems0Policy:
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


schema Ec2AwsUpboundIoV1beta1VPCEndpointServiceSpecInitProviderGatewayLoadBalancerArnsSelector:
    r"""
    Selector for a list of LB in elbv2 to populate gatewayLoadBalancerArns.

    Attributes
    ----------
    matchControllerRef : bool, default is Undefined, optional
        MatchControllerRef ensures an object with the same controller reference
        as the selecting object is selected.
    matchLabels : {str:str}, default is Undefined, optional
        MatchLabels ensures an object with matching labels is selected.
    policy : Ec2AwsUpboundIoV1beta1VPCEndpointServiceSpecInitProviderGatewayLoadBalancerArnsSelectorPolicy, default is Undefined, optional
        policy
    """


    matchControllerRef?: bool

    matchLabels?: {str:str}

    policy?: Ec2AwsUpboundIoV1beta1VPCEndpointServiceSpecInitProviderGatewayLoadBalancerArnsSelectorPolicy


schema Ec2AwsUpboundIoV1beta1VPCEndpointServiceSpecInitProviderGatewayLoadBalancerArnsSelectorPolicy:
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


schema Ec2AwsUpboundIoV1beta1VPCEndpointServiceSpecInitProviderNetworkLoadBalancerArnsRefsItems0:
    r"""
    A Reference to a named object.

    Attributes
    ----------
    name : str, default is Undefined, required
        Name of the referenced object.
    policy : Ec2AwsUpboundIoV1beta1VPCEndpointServiceSpecInitProviderNetworkLoadBalancerArnsRefsItems0Policy, default is Undefined, optional
        policy
    """


    name: str

    policy?: Ec2AwsUpboundIoV1beta1VPCEndpointServiceSpecInitProviderNetworkLoadBalancerArnsRefsItems0Policy


schema Ec2AwsUpboundIoV1beta1VPCEndpointServiceSpecInitProviderNetworkLoadBalancerArnsRefsItems0Policy:
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


schema Ec2AwsUpboundIoV1beta1VPCEndpointServiceSpecInitProviderNetworkLoadBalancerArnsSelector:
    r"""
    Selector for a list of LB in elbv2 to populate networkLoadBalancerArns.

    Attributes
    ----------
    matchControllerRef : bool, default is Undefined, optional
        MatchControllerRef ensures an object with the same controller reference
        as the selecting object is selected.
    matchLabels : {str:str}, default is Undefined, optional
        MatchLabels ensures an object with matching labels is selected.
    policy : Ec2AwsUpboundIoV1beta1VPCEndpointServiceSpecInitProviderNetworkLoadBalancerArnsSelectorPolicy, default is Undefined, optional
        policy
    """


    matchControllerRef?: bool

    matchLabels?: {str:str}

    policy?: Ec2AwsUpboundIoV1beta1VPCEndpointServiceSpecInitProviderNetworkLoadBalancerArnsSelectorPolicy


schema Ec2AwsUpboundIoV1beta1VPCEndpointServiceSpecInitProviderNetworkLoadBalancerArnsSelectorPolicy:
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


schema Ec2AwsUpboundIoV1beta1VPCEndpointServiceSpecProviderConfigRef:
    r"""
    ProviderConfigReference specifies how the provider that will be used to
    create, observe, update, and delete this managed resource should be
    configured.

    Attributes
    ----------
    name : str, default is Undefined, required
        Name of the referenced object.
    policy : Ec2AwsUpboundIoV1beta1VPCEndpointServiceSpecProviderConfigRefPolicy, default is Undefined, optional
        policy
    """


    name: str

    policy?: Ec2AwsUpboundIoV1beta1VPCEndpointServiceSpecProviderConfigRefPolicy


schema Ec2AwsUpboundIoV1beta1VPCEndpointServiceSpecProviderConfigRefPolicy:
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


schema Ec2AwsUpboundIoV1beta1VPCEndpointServiceSpecPublishConnectionDetailsTo:
    r"""
    PublishConnectionDetailsTo specifies the connection secret config which
    contains a name, metadata and a reference to secret store config to
    which any connection details for this managed resource should be written.
    Connection details frequently include the endpoint, username,
    and password required to connect to the managed resource.

    Attributes
    ----------
    configRef : Ec2AwsUpboundIoV1beta1VPCEndpointServiceSpecPublishConnectionDetailsToConfigRef, default is Undefined, optional
        config ref
    metadata : Ec2AwsUpboundIoV1beta1VPCEndpointServiceSpecPublishConnectionDetailsToMetadata, default is Undefined, optional
        metadata
    name : str, default is Undefined, required
        Name is the name of the connection secret.
    """


    configRef?: Ec2AwsUpboundIoV1beta1VPCEndpointServiceSpecPublishConnectionDetailsToConfigRef

    metadata?: Ec2AwsUpboundIoV1beta1VPCEndpointServiceSpecPublishConnectionDetailsToMetadata

    name: str


schema Ec2AwsUpboundIoV1beta1VPCEndpointServiceSpecPublishConnectionDetailsToConfigRef:
    r"""
    SecretStoreConfigRef specifies which secret store config should be used
    for this ConnectionSecret.

    Attributes
    ----------
    name : str, default is Undefined, required
        Name of the referenced object.
    policy : Ec2AwsUpboundIoV1beta1VPCEndpointServiceSpecPublishConnectionDetailsToConfigRefPolicy, default is Undefined, optional
        policy
    """


    name: str

    policy?: Ec2AwsUpboundIoV1beta1VPCEndpointServiceSpecPublishConnectionDetailsToConfigRefPolicy


schema Ec2AwsUpboundIoV1beta1VPCEndpointServiceSpecPublishConnectionDetailsToConfigRefPolicy:
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


schema Ec2AwsUpboundIoV1beta1VPCEndpointServiceSpecPublishConnectionDetailsToMetadata:
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


schema Ec2AwsUpboundIoV1beta1VPCEndpointServiceSpecWriteConnectionSecretToRef:
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


schema Ec2AwsUpboundIoV1beta1VPCEndpointServiceStatus:
    r"""
    VPCEndpointServiceStatus defines the observed state of VPCEndpointService.

    Attributes
    ----------
    atProvider : Ec2AwsUpboundIoV1beta1VPCEndpointServiceStatusAtProvider, default is Undefined, optional
        at provider
    conditions : [Ec2AwsUpboundIoV1beta1VPCEndpointServiceStatusConditionsItems0], default is Undefined, optional
        Conditions of the resource.
    observedGeneration : int, default is Undefined, optional
        ObservedGeneration is the latest metadata.generation
        which resulted in either a ready state, or stalled due to error
        it can not recover from without human intervention.
    """


    atProvider?: Ec2AwsUpboundIoV1beta1VPCEndpointServiceStatusAtProvider

    conditions?: [Ec2AwsUpboundIoV1beta1VPCEndpointServiceStatusConditionsItems0]

    observedGeneration?: int


schema Ec2AwsUpboundIoV1beta1VPCEndpointServiceStatusAtProvider:
    r"""
    ec2 aws upbound io v1beta1 v p c endpoint service status at provider

    Attributes
    ----------
    acceptanceRequired : bool, default is Undefined, optional
        Whether or not VPC endpoint connection requests to the service must be accepted by the service owner - true or false.
    allowedPrincipals : [str], default is Undefined, optional
        The ARNs of one or more principals allowed to discover the endpoint service.
    arn : str, default is Undefined, optional
        The Amazon Resource Name (ARN) of the VPC endpoint service.
    availabilityZones : [str], default is Undefined, optional
        A set of Availability Zones in which the service is available.
    baseEndpointDnsNames : [str], default is Undefined, optional
        A set of DNS names for the service.
    gatewayLoadBalancerArns : [str], default is Undefined, optional
        Amazon Resource Names (ARNs) of one or more Gateway Load Balancers for the endpoint service.
    id : str, default is Undefined, optional
        The ID of the VPC endpoint service.
    managesVpcEndpoints : bool, default is Undefined, optional
        Whether or not the service manages its VPC endpoints - true or false.
    networkLoadBalancerArns : [str], default is Undefined, optional
        Amazon Resource Names (ARNs) of one or more Network Load Balancers for the endpoint service.
    privateDnsName : str, default is Undefined, optional
        The private DNS name for the service.
    privateDnsNameConfiguration : [Ec2AwsUpboundIoV1beta1VPCEndpointServiceStatusAtProviderPrivateDNSNameConfigurationItems0], default is Undefined, optional
        List of objects containing information about the endpoint service private DNS name configuration.
    serviceName : str, default is Undefined, optional
        The service name.
    serviceType : str, default is Undefined, optional
        The service type, Gateway or Interface.
    state : str, default is Undefined, optional
        The state of the VPC endpoint service.
    supportedIpAddressTypes : [str], default is Undefined, optional
        The supported IP address types. The possible values are ipv4 and ipv6.
    tags : {str:str}, default is Undefined, optional
        Key-value map of resource tags.
    tagsAll : {str:str}, default is Undefined, optional
        A map of tags assigned to the resource, including those inherited from the provider default_tags configuration block.
    """


    acceptanceRequired?: bool

    allowedPrincipals?: [str]

    arn?: str

    availabilityZones?: [str]

    baseEndpointDnsNames?: [str]

    gatewayLoadBalancerArns?: [str]

    id?: str

    managesVpcEndpoints?: bool

    networkLoadBalancerArns?: [str]

    privateDnsName?: str

    privateDnsNameConfiguration?: [Ec2AwsUpboundIoV1beta1VPCEndpointServiceStatusAtProviderPrivateDNSNameConfigurationItems0]

    serviceName?: str

    serviceType?: str

    state?: str

    supportedIpAddressTypes?: [str]

    tags?: {str:str}

    tagsAll?: {str:str}


schema Ec2AwsUpboundIoV1beta1VPCEndpointServiceStatusAtProviderPrivateDNSNameConfigurationItems0:
    r"""
    ec2 aws upbound io v1beta1 v p c endpoint service status at provider private DNS name configuration items0

    Attributes
    ----------
    name : str, default is Undefined, optional
        Name of the record subdomain the service provider needs to create.
    state : str, default is Undefined, optional
        The state of the VPC endpoint service.
    $type : str, default is Undefined, optional
        Endpoint service verification type, for example TXT.
    value : str, default is Undefined, optional
        Value the service provider adds to the private DNS name domain record before verification.
    """


    name?: str

    state?: str

    $type?: str

    value?: str


schema Ec2AwsUpboundIoV1beta1VPCEndpointServiceStatusConditionsItems0:
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


