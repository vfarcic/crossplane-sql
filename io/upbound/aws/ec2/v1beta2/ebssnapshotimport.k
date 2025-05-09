"""
This file was generated by the KCL auto-gen tool. DO NOT EDIT.
Editing this file might prove futile when you re-run the KCL auto-gen generate command.
"""
import k8s.apimachinery.pkg.apis.meta.v1


schema EBSSnapshotImport:
    r"""
    EBSSnapshotImport is the Schema for the EBSSnapshotImports API. Provides an elastic block storage snapshot import resource.

    Attributes
    ----------
    apiVersion : str, default is "ec2.aws.upbound.io/v1beta2", required
        APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    kind : str, default is "EBSSnapshotImport", required
        Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    metadata : v1.ObjectMeta, default is Undefined, optional
        metadata
    spec : Ec2AwsUpboundIoV1beta2EBSSnapshotImportSpec, default is Undefined, required
        spec
    status : Ec2AwsUpboundIoV1beta2EBSSnapshotImportStatus, default is Undefined, optional
        status
    """


    apiVersion: "ec2.aws.upbound.io/v1beta2" = "ec2.aws.upbound.io/v1beta2"

    kind: "EBSSnapshotImport" = "EBSSnapshotImport"

    metadata?: v1.ObjectMeta

    spec: Ec2AwsUpboundIoV1beta2EBSSnapshotImportSpec

    status?: Ec2AwsUpboundIoV1beta2EBSSnapshotImportStatus


schema Ec2AwsUpboundIoV1beta2EBSSnapshotImportSpec:
    r"""
    EBSSnapshotImportSpec defines the desired state of EBSSnapshotImport

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
    forProvider : Ec2AwsUpboundIoV1beta2EBSSnapshotImportSpecForProvider, default is Undefined, required
        for provider
    initProvider : Ec2AwsUpboundIoV1beta2EBSSnapshotImportSpecInitProvider, default is Undefined, optional
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
    providerConfigRef : Ec2AwsUpboundIoV1beta2EBSSnapshotImportSpecProviderConfigRef, default is Undefined, optional
        provider config ref
    publishConnectionDetailsTo : Ec2AwsUpboundIoV1beta2EBSSnapshotImportSpecPublishConnectionDetailsTo, default is Undefined, optional
        publish connection details to
    writeConnectionSecretToRef : Ec2AwsUpboundIoV1beta2EBSSnapshotImportSpecWriteConnectionSecretToRef, default is Undefined, optional
        write connection secret to ref
    """


    deletionPolicy?: "Orphan" | "Delete" = "Delete"

    forProvider: Ec2AwsUpboundIoV1beta2EBSSnapshotImportSpecForProvider

    initProvider?: Ec2AwsUpboundIoV1beta2EBSSnapshotImportSpecInitProvider

    managementPolicies?: [str] = ["*"]

    providerConfigRef?: Ec2AwsUpboundIoV1beta2EBSSnapshotImportSpecProviderConfigRef

    publishConnectionDetailsTo?: Ec2AwsUpboundIoV1beta2EBSSnapshotImportSpecPublishConnectionDetailsTo

    writeConnectionSecretToRef?: Ec2AwsUpboundIoV1beta2EBSSnapshotImportSpecWriteConnectionSecretToRef


schema Ec2AwsUpboundIoV1beta2EBSSnapshotImportSpecForProvider:
    r"""
    ec2 aws upbound io v1beta2 e b s snapshot import spec for provider

    Attributes
    ----------
    clientData : Ec2AwsUpboundIoV1beta2EBSSnapshotImportSpecForProviderClientData, default is Undefined, optional
        client data
    description : str, default is Undefined, optional
        The description string for the import snapshot task.
    diskContainer : Ec2AwsUpboundIoV1beta2EBSSnapshotImportSpecForProviderDiskContainer, default is Undefined, optional
        disk container
    encrypted : bool, default is Undefined, optional
        Specifies whether the destination snapshot of the imported image should be encrypted. The default KMS key for EBS is used unless you specify a non-default KMS key using KmsKeyId.
    kmsKeyId : str, default is Undefined, optional
        An identifier for the symmetric KMS key to use when creating the encrypted snapshot. This parameter is only required if you want to use a non-default KMS key; if this parameter is not specified, the default KMS key for EBS is used. If a KmsKeyId is specified, the Encrypted flag must also be set.
    kmsKeyIdRef : Ec2AwsUpboundIoV1beta2EBSSnapshotImportSpecForProviderKmsKeyIDRef, default is Undefined, optional
        kms key Id ref
    kmsKeyIdSelector : Ec2AwsUpboundIoV1beta2EBSSnapshotImportSpecForProviderKmsKeyIDSelector, default is Undefined, optional
        kms key Id selector
    permanentRestore : bool, default is Undefined, optional
        Indicates whether to permanently restore an archived snapshot.
    region : str, default is Undefined, required
        Region is the region you'd like your resource to be created in.
    roleName : str, default is Undefined, optional
        The name of the IAM Role the VM Import/Export service will assume. This role needs certain permissions. See https://docs.aws.amazon.com/vm-import/latest/userguide/vmie_prereqs.html#vmimport-role. Default: vmimport
    storageTier : str, default is Undefined, optional
        The name of the storage tier. Valid values are archive and standard. Default value is standard.
    tags : {str:str}, default is Undefined, optional
        Key-value map of resource tags.
    temporaryRestoreDays : float, default is Undefined, optional
        Specifies the number of days for which to temporarily restore an archived snapshot. Required for temporary restores only. The snapshot will be automatically re-archived after this period.
    """


    clientData?: Ec2AwsUpboundIoV1beta2EBSSnapshotImportSpecForProviderClientData

    description?: str

    diskContainer?: Ec2AwsUpboundIoV1beta2EBSSnapshotImportSpecForProviderDiskContainer

    encrypted?: bool

    kmsKeyId?: str

    kmsKeyIdRef?: Ec2AwsUpboundIoV1beta2EBSSnapshotImportSpecForProviderKmsKeyIDRef

    kmsKeyIdSelector?: Ec2AwsUpboundIoV1beta2EBSSnapshotImportSpecForProviderKmsKeyIDSelector

    permanentRestore?: bool

    region: str

    roleName?: str

    storageTier?: str

    tags?: {str:str}

    temporaryRestoreDays?: float


schema Ec2AwsUpboundIoV1beta2EBSSnapshotImportSpecForProviderClientData:
    r"""
    The client-specific data. Detailed below.

    Attributes
    ----------
    comment : str, default is Undefined, optional
        A user-defined comment about the disk upload.
    uploadEnd : str, default is Undefined, optional
        The time that the disk upload ends.
    uploadSize : float, default is Undefined, optional
        The size of the uploaded disk image, in GiB.
    uploadStart : str, default is Undefined, optional
        The time that the disk upload starts.
    """


    comment?: str

    uploadEnd?: str

    uploadSize?: float

    uploadStart?: str


schema Ec2AwsUpboundIoV1beta2EBSSnapshotImportSpecForProviderDiskContainer:
    r"""
    Information about the disk container. Detailed below.

    Attributes
    ----------
    description : str, default is Undefined, optional
        The description of the disk image being imported.
    format : str, default is Undefined, optional
        The format of the disk image being imported. One of VHD or VMDK.
    url : str, default is Undefined, optional
        The URL to the Amazon S3-based disk image being imported. It can either be a https URL (https://..) or an Amazon S3 URL (s3://..). One of url or user_bucket must be set.
    userBucket : Ec2AwsUpboundIoV1beta2EBSSnapshotImportSpecForProviderDiskContainerUserBucket, default is Undefined, optional
        user bucket
    """


    description?: str

    format?: str

    url?: str

    userBucket?: Ec2AwsUpboundIoV1beta2EBSSnapshotImportSpecForProviderDiskContainerUserBucket


schema Ec2AwsUpboundIoV1beta2EBSSnapshotImportSpecForProviderDiskContainerUserBucket:
    r"""
    The Amazon S3 bucket for the disk image. One of url or user_bucket must be set. Detailed below.

    Attributes
    ----------
    s3Bucket : str, default is Undefined, optional
        The name of the Amazon S3 bucket where the disk image is located.
    s3Key : str, default is Undefined, optional
        The file name of the disk image.
    """


    s3Bucket?: str

    s3Key?: str


schema Ec2AwsUpboundIoV1beta2EBSSnapshotImportSpecForProviderKmsKeyIDRef:
    r"""
    Reference to a Key in kms to populate kmsKeyId.

    Attributes
    ----------
    name : str, default is Undefined, required
        Name of the referenced object.
    policy : Ec2AwsUpboundIoV1beta2EBSSnapshotImportSpecForProviderKmsKeyIDRefPolicy, default is Undefined, optional
        policy
    """


    name: str

    policy?: Ec2AwsUpboundIoV1beta2EBSSnapshotImportSpecForProviderKmsKeyIDRefPolicy


schema Ec2AwsUpboundIoV1beta2EBSSnapshotImportSpecForProviderKmsKeyIDRefPolicy:
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


schema Ec2AwsUpboundIoV1beta2EBSSnapshotImportSpecForProviderKmsKeyIDSelector:
    r"""
    Selector for a Key in kms to populate kmsKeyId.

    Attributes
    ----------
    matchControllerRef : bool, default is Undefined, optional
        MatchControllerRef ensures an object with the same controller reference
        as the selecting object is selected.
    matchLabels : {str:str}, default is Undefined, optional
        MatchLabels ensures an object with matching labels is selected.
    policy : Ec2AwsUpboundIoV1beta2EBSSnapshotImportSpecForProviderKmsKeyIDSelectorPolicy, default is Undefined, optional
        policy
    """


    matchControllerRef?: bool

    matchLabels?: {str:str}

    policy?: Ec2AwsUpboundIoV1beta2EBSSnapshotImportSpecForProviderKmsKeyIDSelectorPolicy


schema Ec2AwsUpboundIoV1beta2EBSSnapshotImportSpecForProviderKmsKeyIDSelectorPolicy:
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


schema Ec2AwsUpboundIoV1beta2EBSSnapshotImportSpecInitProvider:
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
    clientData : Ec2AwsUpboundIoV1beta2EBSSnapshotImportSpecInitProviderClientData, default is Undefined, optional
        client data
    description : str, default is Undefined, optional
        The description string for the import snapshot task.
    diskContainer : Ec2AwsUpboundIoV1beta2EBSSnapshotImportSpecInitProviderDiskContainer, default is Undefined, optional
        disk container
    encrypted : bool, default is Undefined, optional
        Specifies whether the destination snapshot of the imported image should be encrypted. The default KMS key for EBS is used unless you specify a non-default KMS key using KmsKeyId.
    kmsKeyId : str, default is Undefined, optional
        An identifier for the symmetric KMS key to use when creating the encrypted snapshot. This parameter is only required if you want to use a non-default KMS key; if this parameter is not specified, the default KMS key for EBS is used. If a KmsKeyId is specified, the Encrypted flag must also be set.
    kmsKeyIdRef : Ec2AwsUpboundIoV1beta2EBSSnapshotImportSpecInitProviderKmsKeyIDRef, default is Undefined, optional
        kms key Id ref
    kmsKeyIdSelector : Ec2AwsUpboundIoV1beta2EBSSnapshotImportSpecInitProviderKmsKeyIDSelector, default is Undefined, optional
        kms key Id selector
    permanentRestore : bool, default is Undefined, optional
        Indicates whether to permanently restore an archived snapshot.
    roleName : str, default is Undefined, optional
        The name of the IAM Role the VM Import/Export service will assume. This role needs certain permissions. See https://docs.aws.amazon.com/vm-import/latest/userguide/vmie_prereqs.html#vmimport-role. Default: vmimport
    storageTier : str, default is Undefined, optional
        The name of the storage tier. Valid values are archive and standard. Default value is standard.
    tags : {str:str}, default is Undefined, optional
        Key-value map of resource tags.
    temporaryRestoreDays : float, default is Undefined, optional
        Specifies the number of days for which to temporarily restore an archived snapshot. Required for temporary restores only. The snapshot will be automatically re-archived after this period.
    """


    clientData?: Ec2AwsUpboundIoV1beta2EBSSnapshotImportSpecInitProviderClientData

    description?: str

    diskContainer?: Ec2AwsUpboundIoV1beta2EBSSnapshotImportSpecInitProviderDiskContainer

    encrypted?: bool

    kmsKeyId?: str

    kmsKeyIdRef?: Ec2AwsUpboundIoV1beta2EBSSnapshotImportSpecInitProviderKmsKeyIDRef

    kmsKeyIdSelector?: Ec2AwsUpboundIoV1beta2EBSSnapshotImportSpecInitProviderKmsKeyIDSelector

    permanentRestore?: bool

    roleName?: str

    storageTier?: str

    tags?: {str:str}

    temporaryRestoreDays?: float


schema Ec2AwsUpboundIoV1beta2EBSSnapshotImportSpecInitProviderClientData:
    r"""
    The client-specific data. Detailed below.

    Attributes
    ----------
    comment : str, default is Undefined, optional
        A user-defined comment about the disk upload.
    uploadEnd : str, default is Undefined, optional
        The time that the disk upload ends.
    uploadSize : float, default is Undefined, optional
        The size of the uploaded disk image, in GiB.
    uploadStart : str, default is Undefined, optional
        The time that the disk upload starts.
    """


    comment?: str

    uploadEnd?: str

    uploadSize?: float

    uploadStart?: str


schema Ec2AwsUpboundIoV1beta2EBSSnapshotImportSpecInitProviderDiskContainer:
    r"""
    Information about the disk container. Detailed below.

    Attributes
    ----------
    description : str, default is Undefined, optional
        The description of the disk image being imported.
    format : str, default is Undefined, optional
        The format of the disk image being imported. One of VHD or VMDK.
    url : str, default is Undefined, optional
        The URL to the Amazon S3-based disk image being imported. It can either be a https URL (https://..) or an Amazon S3 URL (s3://..). One of url or user_bucket must be set.
    userBucket : Ec2AwsUpboundIoV1beta2EBSSnapshotImportSpecInitProviderDiskContainerUserBucket, default is Undefined, optional
        user bucket
    """


    description?: str

    format?: str

    url?: str

    userBucket?: Ec2AwsUpboundIoV1beta2EBSSnapshotImportSpecInitProviderDiskContainerUserBucket


schema Ec2AwsUpboundIoV1beta2EBSSnapshotImportSpecInitProviderDiskContainerUserBucket:
    r"""
    The Amazon S3 bucket for the disk image. One of url or user_bucket must be set. Detailed below.

    Attributes
    ----------
    s3Bucket : str, default is Undefined, optional
        The name of the Amazon S3 bucket where the disk image is located.
    s3Key : str, default is Undefined, optional
        The file name of the disk image.
    """


    s3Bucket?: str

    s3Key?: str


schema Ec2AwsUpboundIoV1beta2EBSSnapshotImportSpecInitProviderKmsKeyIDRef:
    r"""
    Reference to a Key in kms to populate kmsKeyId.

    Attributes
    ----------
    name : str, default is Undefined, required
        Name of the referenced object.
    policy : Ec2AwsUpboundIoV1beta2EBSSnapshotImportSpecInitProviderKmsKeyIDRefPolicy, default is Undefined, optional
        policy
    """


    name: str

    policy?: Ec2AwsUpboundIoV1beta2EBSSnapshotImportSpecInitProviderKmsKeyIDRefPolicy


schema Ec2AwsUpboundIoV1beta2EBSSnapshotImportSpecInitProviderKmsKeyIDRefPolicy:
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


schema Ec2AwsUpboundIoV1beta2EBSSnapshotImportSpecInitProviderKmsKeyIDSelector:
    r"""
    Selector for a Key in kms to populate kmsKeyId.

    Attributes
    ----------
    matchControllerRef : bool, default is Undefined, optional
        MatchControllerRef ensures an object with the same controller reference
        as the selecting object is selected.
    matchLabels : {str:str}, default is Undefined, optional
        MatchLabels ensures an object with matching labels is selected.
    policy : Ec2AwsUpboundIoV1beta2EBSSnapshotImportSpecInitProviderKmsKeyIDSelectorPolicy, default is Undefined, optional
        policy
    """


    matchControllerRef?: bool

    matchLabels?: {str:str}

    policy?: Ec2AwsUpboundIoV1beta2EBSSnapshotImportSpecInitProviderKmsKeyIDSelectorPolicy


schema Ec2AwsUpboundIoV1beta2EBSSnapshotImportSpecInitProviderKmsKeyIDSelectorPolicy:
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


schema Ec2AwsUpboundIoV1beta2EBSSnapshotImportSpecProviderConfigRef:
    r"""
    ProviderConfigReference specifies how the provider that will be used to
    create, observe, update, and delete this managed resource should be
    configured.

    Attributes
    ----------
    name : str, default is Undefined, required
        Name of the referenced object.
    policy : Ec2AwsUpboundIoV1beta2EBSSnapshotImportSpecProviderConfigRefPolicy, default is Undefined, optional
        policy
    """


    name: str

    policy?: Ec2AwsUpboundIoV1beta2EBSSnapshotImportSpecProviderConfigRefPolicy


schema Ec2AwsUpboundIoV1beta2EBSSnapshotImportSpecProviderConfigRefPolicy:
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


schema Ec2AwsUpboundIoV1beta2EBSSnapshotImportSpecPublishConnectionDetailsTo:
    r"""
    PublishConnectionDetailsTo specifies the connection secret config which
    contains a name, metadata and a reference to secret store config to
    which any connection details for this managed resource should be written.
    Connection details frequently include the endpoint, username,
    and password required to connect to the managed resource.

    Attributes
    ----------
    configRef : Ec2AwsUpboundIoV1beta2EBSSnapshotImportSpecPublishConnectionDetailsToConfigRef, default is Undefined, optional
        config ref
    metadata : Ec2AwsUpboundIoV1beta2EBSSnapshotImportSpecPublishConnectionDetailsToMetadata, default is Undefined, optional
        metadata
    name : str, default is Undefined, required
        Name is the name of the connection secret.
    """


    configRef?: Ec2AwsUpboundIoV1beta2EBSSnapshotImportSpecPublishConnectionDetailsToConfigRef

    metadata?: Ec2AwsUpboundIoV1beta2EBSSnapshotImportSpecPublishConnectionDetailsToMetadata

    name: str


schema Ec2AwsUpboundIoV1beta2EBSSnapshotImportSpecPublishConnectionDetailsToConfigRef:
    r"""
    SecretStoreConfigRef specifies which secret store config should be used
    for this ConnectionSecret.

    Attributes
    ----------
    name : str, default is Undefined, required
        Name of the referenced object.
    policy : Ec2AwsUpboundIoV1beta2EBSSnapshotImportSpecPublishConnectionDetailsToConfigRefPolicy, default is Undefined, optional
        policy
    """


    name: str

    policy?: Ec2AwsUpboundIoV1beta2EBSSnapshotImportSpecPublishConnectionDetailsToConfigRefPolicy


schema Ec2AwsUpboundIoV1beta2EBSSnapshotImportSpecPublishConnectionDetailsToConfigRefPolicy:
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


schema Ec2AwsUpboundIoV1beta2EBSSnapshotImportSpecPublishConnectionDetailsToMetadata:
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


schema Ec2AwsUpboundIoV1beta2EBSSnapshotImportSpecWriteConnectionSecretToRef:
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


schema Ec2AwsUpboundIoV1beta2EBSSnapshotImportStatus:
    r"""
    EBSSnapshotImportStatus defines the observed state of EBSSnapshotImport.

    Attributes
    ----------
    atProvider : Ec2AwsUpboundIoV1beta2EBSSnapshotImportStatusAtProvider, default is Undefined, optional
        at provider
    conditions : [Ec2AwsUpboundIoV1beta2EBSSnapshotImportStatusConditionsItems0], default is Undefined, optional
        Conditions of the resource.
    observedGeneration : int, default is Undefined, optional
        ObservedGeneration is the latest metadata.generation
        which resulted in either a ready state, or stalled due to error
        it can not recover from without human intervention.
    """


    atProvider?: Ec2AwsUpboundIoV1beta2EBSSnapshotImportStatusAtProvider

    conditions?: [Ec2AwsUpboundIoV1beta2EBSSnapshotImportStatusConditionsItems0]

    observedGeneration?: int


schema Ec2AwsUpboundIoV1beta2EBSSnapshotImportStatusAtProvider:
    r"""
    ec2 aws upbound io v1beta2 e b s snapshot import status at provider

    Attributes
    ----------
    arn : str, default is Undefined, optional
        Amazon Resource Name (ARN) of the EBS Snapshot.
    clientData : Ec2AwsUpboundIoV1beta2EBSSnapshotImportStatusAtProviderClientData, default is Undefined, optional
        client data
    dataEncryptionKeyId : str, default is Undefined, optional
        The data encryption key identifier for the snapshot.
    description : str, default is Undefined, optional
        The description string for the import snapshot task.
    diskContainer : Ec2AwsUpboundIoV1beta2EBSSnapshotImportStatusAtProviderDiskContainer, default is Undefined, optional
        disk container
    encrypted : bool, default is Undefined, optional
        Specifies whether the destination snapshot of the imported image should be encrypted. The default KMS key for EBS is used unless you specify a non-default KMS key using KmsKeyId.
    id : str, default is Undefined, optional
        The snapshot ID (e.g., snap-59fcb34e).
    kmsKeyId : str, default is Undefined, optional
        An identifier for the symmetric KMS key to use when creating the encrypted snapshot. This parameter is only required if you want to use a non-default KMS key; if this parameter is not specified, the default KMS key for EBS is used. If a KmsKeyId is specified, the Encrypted flag must also be set.
    outpostArn : str, default is Undefined, optional
        Amazon Resource Name (ARN) of the EBS Snapshot.
    ownerAlias : str, default is Undefined, optional
        Value from an Amazon-maintained list (amazon, aws-marketplace, microsoft) of snapshot owners.
    ownerId : str, default is Undefined, optional
        The AWS account ID of the EBS snapshot owner.
    permanentRestore : bool, default is Undefined, optional
        Indicates whether to permanently restore an archived snapshot.
    roleName : str, default is Undefined, optional
        The name of the IAM Role the VM Import/Export service will assume. This role needs certain permissions. See https://docs.aws.amazon.com/vm-import/latest/userguide/vmie_prereqs.html#vmimport-role. Default: vmimport
    storageTier : str, default is Undefined, optional
        The name of the storage tier. Valid values are archive and standard. Default value is standard.
    tags : {str:str}, default is Undefined, optional
        Key-value map of resource tags.
    tagsAll : {str:str}, default is Undefined, optional
        A map of tags assigned to the resource, including those inherited from the provider default_tags configuration block.
    temporaryRestoreDays : float, default is Undefined, optional
        Specifies the number of days for which to temporarily restore an archived snapshot. Required for temporary restores only. The snapshot will be automatically re-archived after this period.
    volumeId : str, default is Undefined, optional
        The snapshot ID (e.g., snap-59fcb34e).
    volumeSize : float, default is Undefined, optional
        The size of the drive in GiBs.
    """


    arn?: str

    clientData?: Ec2AwsUpboundIoV1beta2EBSSnapshotImportStatusAtProviderClientData

    dataEncryptionKeyId?: str

    description?: str

    diskContainer?: Ec2AwsUpboundIoV1beta2EBSSnapshotImportStatusAtProviderDiskContainer

    encrypted?: bool

    id?: str

    kmsKeyId?: str

    outpostArn?: str

    ownerAlias?: str

    ownerId?: str

    permanentRestore?: bool

    roleName?: str

    storageTier?: str

    tags?: {str:str}

    tagsAll?: {str:str}

    temporaryRestoreDays?: float

    volumeId?: str

    volumeSize?: float


schema Ec2AwsUpboundIoV1beta2EBSSnapshotImportStatusAtProviderClientData:
    r"""
    The client-specific data. Detailed below.

    Attributes
    ----------
    comment : str, default is Undefined, optional
        A user-defined comment about the disk upload.
    uploadEnd : str, default is Undefined, optional
        The time that the disk upload ends.
    uploadSize : float, default is Undefined, optional
        The size of the uploaded disk image, in GiB.
    uploadStart : str, default is Undefined, optional
        The time that the disk upload starts.
    """


    comment?: str

    uploadEnd?: str

    uploadSize?: float

    uploadStart?: str


schema Ec2AwsUpboundIoV1beta2EBSSnapshotImportStatusAtProviderDiskContainer:
    r"""
    Information about the disk container. Detailed below.

    Attributes
    ----------
    description : str, default is Undefined, optional
        The description of the disk image being imported.
    format : str, default is Undefined, optional
        The format of the disk image being imported. One of VHD or VMDK.
    url : str, default is Undefined, optional
        The URL to the Amazon S3-based disk image being imported. It can either be a https URL (https://..) or an Amazon S3 URL (s3://..). One of url or user_bucket must be set.
    userBucket : Ec2AwsUpboundIoV1beta2EBSSnapshotImportStatusAtProviderDiskContainerUserBucket, default is Undefined, optional
        user bucket
    """


    description?: str

    format?: str

    url?: str

    userBucket?: Ec2AwsUpboundIoV1beta2EBSSnapshotImportStatusAtProviderDiskContainerUserBucket


schema Ec2AwsUpboundIoV1beta2EBSSnapshotImportStatusAtProviderDiskContainerUserBucket:
    r"""
    The Amazon S3 bucket for the disk image. One of url or user_bucket must be set. Detailed below.

    Attributes
    ----------
    s3Bucket : str, default is Undefined, optional
        The name of the Amazon S3 bucket where the disk image is located.
    s3Key : str, default is Undefined, optional
        The file name of the disk image.
    """


    s3Bucket?: str

    s3Key?: str


schema Ec2AwsUpboundIoV1beta2EBSSnapshotImportStatusConditionsItems0:
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


