"""
This file was generated by the KCL auto-gen tool. DO NOT EDIT.
Editing this file might prove futile when you re-run the KCL auto-gen generate command.
"""
import k8s.apimachinery.pkg.apis.meta.v1


schema NetworkACL:
    r"""
    NetworkACL is the Schema for the NetworkACLs API. Provides an network ACL resource.

    Attributes
    ----------
    apiVersion : str, default is "ec2.aws.upbound.io/v1beta1", required
        APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    kind : str, default is "NetworkACL", required
        Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    metadata : v1.ObjectMeta, default is Undefined, optional
        metadata
    spec : Ec2AwsUpboundIoV1beta1NetworkACLSpec, default is Undefined, required
        spec
    status : Ec2AwsUpboundIoV1beta1NetworkACLStatus, default is Undefined, optional
        status
    """


    apiVersion: "ec2.aws.upbound.io/v1beta1" = "ec2.aws.upbound.io/v1beta1"

    kind: "NetworkACL" = "NetworkACL"

    metadata?: v1.ObjectMeta

    spec: Ec2AwsUpboundIoV1beta1NetworkACLSpec

    status?: Ec2AwsUpboundIoV1beta1NetworkACLStatus


schema Ec2AwsUpboundIoV1beta1NetworkACLSpec:
    r"""
    NetworkACLSpec defines the desired state of NetworkACL

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
    forProvider : Ec2AwsUpboundIoV1beta1NetworkACLSpecForProvider, default is Undefined, required
        for provider
    initProvider : Ec2AwsUpboundIoV1beta1NetworkACLSpecInitProvider, default is Undefined, optional
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
    providerConfigRef : Ec2AwsUpboundIoV1beta1NetworkACLSpecProviderConfigRef, default is Undefined, optional
        provider config ref
    publishConnectionDetailsTo : Ec2AwsUpboundIoV1beta1NetworkACLSpecPublishConnectionDetailsTo, default is Undefined, optional
        publish connection details to
    writeConnectionSecretToRef : Ec2AwsUpboundIoV1beta1NetworkACLSpecWriteConnectionSecretToRef, default is Undefined, optional
        write connection secret to ref
    """


    deletionPolicy?: "Orphan" | "Delete" = "Delete"

    forProvider: Ec2AwsUpboundIoV1beta1NetworkACLSpecForProvider

    initProvider?: Ec2AwsUpboundIoV1beta1NetworkACLSpecInitProvider

    managementPolicies?: [str] = ["*"]

    providerConfigRef?: Ec2AwsUpboundIoV1beta1NetworkACLSpecProviderConfigRef

    publishConnectionDetailsTo?: Ec2AwsUpboundIoV1beta1NetworkACLSpecPublishConnectionDetailsTo

    writeConnectionSecretToRef?: Ec2AwsUpboundIoV1beta1NetworkACLSpecWriteConnectionSecretToRef


schema Ec2AwsUpboundIoV1beta1NetworkACLSpecForProvider:
    r"""
    ec2 aws upbound io v1beta1 network ACL spec for provider

    Attributes
    ----------
    region : str, default is Undefined, required
        Region is the region you'd like your resource to be created in.
    subnetIdRefs : [Ec2AwsUpboundIoV1beta1NetworkACLSpecForProviderSubnetIDRefsItems0], default is Undefined, optional
        References to Subnet in ec2 to populate subnetIds.
    subnetIdSelector : Ec2AwsUpboundIoV1beta1NetworkACLSpecForProviderSubnetIDSelector, default is Undefined, optional
        subnet Id selector
    subnetIds : [str], default is Undefined, optional
        A list of Subnet IDs to apply the ACL to
    tags : {str:str}, default is Undefined, optional
        Key-value map of resource tags.
    vpcId : str, default is Undefined, optional
        The ID of the associated VPC.
    vpcIdRef : Ec2AwsUpboundIoV1beta1NetworkACLSpecForProviderVpcIDRef, default is Undefined, optional
        vpc Id ref
    vpcIdSelector : Ec2AwsUpboundIoV1beta1NetworkACLSpecForProviderVpcIDSelector, default is Undefined, optional
        vpc Id selector
    """


    region: str

    subnetIdRefs?: [Ec2AwsUpboundIoV1beta1NetworkACLSpecForProviderSubnetIDRefsItems0]

    subnetIdSelector?: Ec2AwsUpboundIoV1beta1NetworkACLSpecForProviderSubnetIDSelector

    subnetIds?: [str]

    tags?: {str:str}

    vpcId?: str

    vpcIdRef?: Ec2AwsUpboundIoV1beta1NetworkACLSpecForProviderVpcIDRef

    vpcIdSelector?: Ec2AwsUpboundIoV1beta1NetworkACLSpecForProviderVpcIDSelector


schema Ec2AwsUpboundIoV1beta1NetworkACLSpecForProviderSubnetIDRefsItems0:
    r"""
    A Reference to a named object.

    Attributes
    ----------
    name : str, default is Undefined, required
        Name of the referenced object.
    policy : Ec2AwsUpboundIoV1beta1NetworkACLSpecForProviderSubnetIDRefsItems0Policy, default is Undefined, optional
        policy
    """


    name: str

    policy?: Ec2AwsUpboundIoV1beta1NetworkACLSpecForProviderSubnetIDRefsItems0Policy


schema Ec2AwsUpboundIoV1beta1NetworkACLSpecForProviderSubnetIDRefsItems0Policy:
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


schema Ec2AwsUpboundIoV1beta1NetworkACLSpecForProviderSubnetIDSelector:
    r"""
    Selector for a list of Subnet in ec2 to populate subnetIds.

    Attributes
    ----------
    matchControllerRef : bool, default is Undefined, optional
        MatchControllerRef ensures an object with the same controller reference
        as the selecting object is selected.
    matchLabels : {str:str}, default is Undefined, optional
        MatchLabels ensures an object with matching labels is selected.
    policy : Ec2AwsUpboundIoV1beta1NetworkACLSpecForProviderSubnetIDSelectorPolicy, default is Undefined, optional
        policy
    """


    matchControllerRef?: bool

    matchLabels?: {str:str}

    policy?: Ec2AwsUpboundIoV1beta1NetworkACLSpecForProviderSubnetIDSelectorPolicy


schema Ec2AwsUpboundIoV1beta1NetworkACLSpecForProviderSubnetIDSelectorPolicy:
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


schema Ec2AwsUpboundIoV1beta1NetworkACLSpecForProviderVpcIDRef:
    r"""
    Reference to a VPC in ec2 to populate vpcId.

    Attributes
    ----------
    name : str, default is Undefined, required
        Name of the referenced object.
    policy : Ec2AwsUpboundIoV1beta1NetworkACLSpecForProviderVpcIDRefPolicy, default is Undefined, optional
        policy
    """


    name: str

    policy?: Ec2AwsUpboundIoV1beta1NetworkACLSpecForProviderVpcIDRefPolicy


schema Ec2AwsUpboundIoV1beta1NetworkACLSpecForProviderVpcIDRefPolicy:
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


schema Ec2AwsUpboundIoV1beta1NetworkACLSpecForProviderVpcIDSelector:
    r"""
    Selector for a VPC in ec2 to populate vpcId.

    Attributes
    ----------
    matchControllerRef : bool, default is Undefined, optional
        MatchControllerRef ensures an object with the same controller reference
        as the selecting object is selected.
    matchLabels : {str:str}, default is Undefined, optional
        MatchLabels ensures an object with matching labels is selected.
    policy : Ec2AwsUpboundIoV1beta1NetworkACLSpecForProviderVpcIDSelectorPolicy, default is Undefined, optional
        policy
    """


    matchControllerRef?: bool

    matchLabels?: {str:str}

    policy?: Ec2AwsUpboundIoV1beta1NetworkACLSpecForProviderVpcIDSelectorPolicy


schema Ec2AwsUpboundIoV1beta1NetworkACLSpecForProviderVpcIDSelectorPolicy:
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


schema Ec2AwsUpboundIoV1beta1NetworkACLSpecInitProvider:
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
    subnetIdRefs : [Ec2AwsUpboundIoV1beta1NetworkACLSpecInitProviderSubnetIDRefsItems0], default is Undefined, optional
        References to Subnet in ec2 to populate subnetIds.
    subnetIdSelector : Ec2AwsUpboundIoV1beta1NetworkACLSpecInitProviderSubnetIDSelector, default is Undefined, optional
        subnet Id selector
    subnetIds : [str], default is Undefined, optional
        A list of Subnet IDs to apply the ACL to
    tags : {str:str}, default is Undefined, optional
        Key-value map of resource tags.
    vpcId : str, default is Undefined, optional
        The ID of the associated VPC.
    vpcIdRef : Ec2AwsUpboundIoV1beta1NetworkACLSpecInitProviderVpcIDRef, default is Undefined, optional
        vpc Id ref
    vpcIdSelector : Ec2AwsUpboundIoV1beta1NetworkACLSpecInitProviderVpcIDSelector, default is Undefined, optional
        vpc Id selector
    """


    subnetIdRefs?: [Ec2AwsUpboundIoV1beta1NetworkACLSpecInitProviderSubnetIDRefsItems0]

    subnetIdSelector?: Ec2AwsUpboundIoV1beta1NetworkACLSpecInitProviderSubnetIDSelector

    subnetIds?: [str]

    tags?: {str:str}

    vpcId?: str

    vpcIdRef?: Ec2AwsUpboundIoV1beta1NetworkACLSpecInitProviderVpcIDRef

    vpcIdSelector?: Ec2AwsUpboundIoV1beta1NetworkACLSpecInitProviderVpcIDSelector


schema Ec2AwsUpboundIoV1beta1NetworkACLSpecInitProviderSubnetIDRefsItems0:
    r"""
    A Reference to a named object.

    Attributes
    ----------
    name : str, default is Undefined, required
        Name of the referenced object.
    policy : Ec2AwsUpboundIoV1beta1NetworkACLSpecInitProviderSubnetIDRefsItems0Policy, default is Undefined, optional
        policy
    """


    name: str

    policy?: Ec2AwsUpboundIoV1beta1NetworkACLSpecInitProviderSubnetIDRefsItems0Policy


schema Ec2AwsUpboundIoV1beta1NetworkACLSpecInitProviderSubnetIDRefsItems0Policy:
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


schema Ec2AwsUpboundIoV1beta1NetworkACLSpecInitProviderSubnetIDSelector:
    r"""
    Selector for a list of Subnet in ec2 to populate subnetIds.

    Attributes
    ----------
    matchControllerRef : bool, default is Undefined, optional
        MatchControllerRef ensures an object with the same controller reference
        as the selecting object is selected.
    matchLabels : {str:str}, default is Undefined, optional
        MatchLabels ensures an object with matching labels is selected.
    policy : Ec2AwsUpboundIoV1beta1NetworkACLSpecInitProviderSubnetIDSelectorPolicy, default is Undefined, optional
        policy
    """


    matchControllerRef?: bool

    matchLabels?: {str:str}

    policy?: Ec2AwsUpboundIoV1beta1NetworkACLSpecInitProviderSubnetIDSelectorPolicy


schema Ec2AwsUpboundIoV1beta1NetworkACLSpecInitProviderSubnetIDSelectorPolicy:
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


schema Ec2AwsUpboundIoV1beta1NetworkACLSpecInitProviderVpcIDRef:
    r"""
    Reference to a VPC in ec2 to populate vpcId.

    Attributes
    ----------
    name : str, default is Undefined, required
        Name of the referenced object.
    policy : Ec2AwsUpboundIoV1beta1NetworkACLSpecInitProviderVpcIDRefPolicy, default is Undefined, optional
        policy
    """


    name: str

    policy?: Ec2AwsUpboundIoV1beta1NetworkACLSpecInitProviderVpcIDRefPolicy


schema Ec2AwsUpboundIoV1beta1NetworkACLSpecInitProviderVpcIDRefPolicy:
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


schema Ec2AwsUpboundIoV1beta1NetworkACLSpecInitProviderVpcIDSelector:
    r"""
    Selector for a VPC in ec2 to populate vpcId.

    Attributes
    ----------
    matchControllerRef : bool, default is Undefined, optional
        MatchControllerRef ensures an object with the same controller reference
        as the selecting object is selected.
    matchLabels : {str:str}, default is Undefined, optional
        MatchLabels ensures an object with matching labels is selected.
    policy : Ec2AwsUpboundIoV1beta1NetworkACLSpecInitProviderVpcIDSelectorPolicy, default is Undefined, optional
        policy
    """


    matchControllerRef?: bool

    matchLabels?: {str:str}

    policy?: Ec2AwsUpboundIoV1beta1NetworkACLSpecInitProviderVpcIDSelectorPolicy


schema Ec2AwsUpboundIoV1beta1NetworkACLSpecInitProviderVpcIDSelectorPolicy:
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


schema Ec2AwsUpboundIoV1beta1NetworkACLSpecProviderConfigRef:
    r"""
    ProviderConfigReference specifies how the provider that will be used to
    create, observe, update, and delete this managed resource should be
    configured.

    Attributes
    ----------
    name : str, default is Undefined, required
        Name of the referenced object.
    policy : Ec2AwsUpboundIoV1beta1NetworkACLSpecProviderConfigRefPolicy, default is Undefined, optional
        policy
    """


    name: str

    policy?: Ec2AwsUpboundIoV1beta1NetworkACLSpecProviderConfigRefPolicy


schema Ec2AwsUpboundIoV1beta1NetworkACLSpecProviderConfigRefPolicy:
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


schema Ec2AwsUpboundIoV1beta1NetworkACLSpecPublishConnectionDetailsTo:
    r"""
    PublishConnectionDetailsTo specifies the connection secret config which
    contains a name, metadata and a reference to secret store config to
    which any connection details for this managed resource should be written.
    Connection details frequently include the endpoint, username,
    and password required to connect to the managed resource.

    Attributes
    ----------
    configRef : Ec2AwsUpboundIoV1beta1NetworkACLSpecPublishConnectionDetailsToConfigRef, default is Undefined, optional
        config ref
    metadata : Ec2AwsUpboundIoV1beta1NetworkACLSpecPublishConnectionDetailsToMetadata, default is Undefined, optional
        metadata
    name : str, default is Undefined, required
        Name is the name of the connection secret.
    """


    configRef?: Ec2AwsUpboundIoV1beta1NetworkACLSpecPublishConnectionDetailsToConfigRef

    metadata?: Ec2AwsUpboundIoV1beta1NetworkACLSpecPublishConnectionDetailsToMetadata

    name: str


schema Ec2AwsUpboundIoV1beta1NetworkACLSpecPublishConnectionDetailsToConfigRef:
    r"""
    SecretStoreConfigRef specifies which secret store config should be used
    for this ConnectionSecret.

    Attributes
    ----------
    name : str, default is Undefined, required
        Name of the referenced object.
    policy : Ec2AwsUpboundIoV1beta1NetworkACLSpecPublishConnectionDetailsToConfigRefPolicy, default is Undefined, optional
        policy
    """


    name: str

    policy?: Ec2AwsUpboundIoV1beta1NetworkACLSpecPublishConnectionDetailsToConfigRefPolicy


schema Ec2AwsUpboundIoV1beta1NetworkACLSpecPublishConnectionDetailsToConfigRefPolicy:
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


schema Ec2AwsUpboundIoV1beta1NetworkACLSpecPublishConnectionDetailsToMetadata:
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


schema Ec2AwsUpboundIoV1beta1NetworkACLSpecWriteConnectionSecretToRef:
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


schema Ec2AwsUpboundIoV1beta1NetworkACLStatus:
    r"""
    NetworkACLStatus defines the observed state of NetworkACL.

    Attributes
    ----------
    atProvider : Ec2AwsUpboundIoV1beta1NetworkACLStatusAtProvider, default is Undefined, optional
        at provider
    conditions : [Ec2AwsUpboundIoV1beta1NetworkACLStatusConditionsItems0], default is Undefined, optional
        Conditions of the resource.
    observedGeneration : int, default is Undefined, optional
        ObservedGeneration is the latest metadata.generation
        which resulted in either a ready state, or stalled due to error
        it can not recover from without human intervention.
    """


    atProvider?: Ec2AwsUpboundIoV1beta1NetworkACLStatusAtProvider

    conditions?: [Ec2AwsUpboundIoV1beta1NetworkACLStatusConditionsItems0]

    observedGeneration?: int


schema Ec2AwsUpboundIoV1beta1NetworkACLStatusAtProvider:
    r"""
    ec2 aws upbound io v1beta1 network ACL status at provider

    Attributes
    ----------
    arn : str, default is Undefined, optional
        The ARN of the network ACL
    egress : [Ec2AwsUpboundIoV1beta1NetworkACLStatusAtProviderEgressItems0], default is Undefined, optional
        Specifies an egress rule. Parameters defined below.
        This argument is processed in attribute-as-blocks mode.
    id : str, default is Undefined, optional
        The ID of the network ACL
    ingress : [Ec2AwsUpboundIoV1beta1NetworkACLStatusAtProviderIngressItems0], default is Undefined, optional
        Specifies an ingress rule. Parameters defined below.
        This argument is processed in attribute-as-blocks mode.
    ownerId : str, default is Undefined, optional
        The ID of the AWS account that owns the network ACL.
    subnetIds : [str], default is Undefined, optional
        A list of Subnet IDs to apply the ACL to
    tags : {str:str}, default is Undefined, optional
        Key-value map of resource tags.
    tagsAll : {str:str}, default is Undefined, optional
        A map of tags assigned to the resource, including those inherited from the provider default_tags configuration block.
    vpcId : str, default is Undefined, optional
        The ID of the associated VPC.
    """


    arn?: str

    egress?: [Ec2AwsUpboundIoV1beta1NetworkACLStatusAtProviderEgressItems0]

    id?: str

    ingress?: [Ec2AwsUpboundIoV1beta1NetworkACLStatusAtProviderIngressItems0]

    ownerId?: str

    subnetIds?: [str]

    tags?: {str:str}

    tagsAll?: {str:str}

    vpcId?: str


schema Ec2AwsUpboundIoV1beta1NetworkACLStatusAtProviderEgressItems0:
    r"""
    ec2 aws upbound io v1beta1 network ACL status at provider egress items0

    Attributes
    ----------
    action : str, default is Undefined, optional
        The action to take.
    cidrBlock : str, default is Undefined, optional
        The CIDR block to match. This must be a
        valid network mask.
    fromPort : float, default is Undefined, optional
        The from port to match.
    icmpCode : float, default is Undefined, optional
        The ICMP type code to be used. Default 0.
    icmpType : float, default is Undefined, optional
        The ICMP type to be used. Default 0.
    ipv6CidrBlock : str, default is Undefined, optional
        The IPv6 CIDR block.
    $protocol : str, default is Undefined, optional
        The protocol to match. If using the -1 'all'
        protocol, you must specify a from and to port of 0.
    ruleNo : float, default is Undefined, optional
        The rule number. Used for ordering.
    toPort : float, default is Undefined, optional
        The to port to match.
    """


    action?: str

    cidrBlock?: str

    fromPort?: float

    icmpCode?: float

    icmpType?: float

    ipv6CidrBlock?: str

    $protocol?: str

    ruleNo?: float

    toPort?: float


schema Ec2AwsUpboundIoV1beta1NetworkACLStatusAtProviderIngressItems0:
    r"""
    ec2 aws upbound io v1beta1 network ACL status at provider ingress items0

    Attributes
    ----------
    action : str, default is Undefined, optional
        The action to take.
    cidrBlock : str, default is Undefined, optional
        The CIDR block to match. This must be a
        valid network mask.
    fromPort : float, default is Undefined, optional
        The from port to match.
    icmpCode : float, default is Undefined, optional
        The ICMP type code to be used. Default 0.
    icmpType : float, default is Undefined, optional
        The ICMP type to be used. Default 0.
    ipv6CidrBlock : str, default is Undefined, optional
        The IPv6 CIDR block.
    $protocol : str, default is Undefined, optional
        The protocol to match. If using the -1 'all'
        protocol, you must specify a from and to port of 0.
    ruleNo : float, default is Undefined, optional
        The rule number. Used for ordering.
    toPort : float, default is Undefined, optional
        The to port to match.
    """


    action?: str

    cidrBlock?: str

    fromPort?: float

    icmpCode?: float

    icmpType?: float

    ipv6CidrBlock?: str

    $protocol?: str

    ruleNo?: float

    toPort?: float


schema Ec2AwsUpboundIoV1beta1NetworkACLStatusConditionsItems0:
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


