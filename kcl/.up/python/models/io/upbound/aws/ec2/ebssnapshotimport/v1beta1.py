# generated by datamodel-codegen:
#   filename:  workdir/ec2_aws_upbound_io_v1beta1_ebssnapshotimport.yaml

from __future__ import annotations

from enum import Enum
from typing import Dict, List, Optional

from pydantic import AwareDatetime, BaseModel, Field

from .....k8s.apimachinery.pkg.apis.meta import v1


class DeletionPolicy(Enum):
    Orphan = 'Orphan'
    Delete = 'Delete'


class ClientDatum(BaseModel):
    comment: Optional[str] = None
    """
    A user-defined comment about the disk upload.
    """
    uploadEnd: Optional[str] = None
    """
    The time that the disk upload ends.
    """
    uploadSize: Optional[float] = None
    """
    The size of the uploaded disk image, in GiB.
    """
    uploadStart: Optional[str] = None
    """
    The time that the disk upload starts.
    """


class UserBucketItem(BaseModel):
    s3Bucket: Optional[str] = None
    """
    The name of the Amazon S3 bucket where the disk image is located.
    """
    s3Key: Optional[str] = None
    """
    The file name of the disk image.
    """


class DiskContainerItem(BaseModel):
    description: Optional[str] = None
    """
    The description of the disk image being imported.
    """
    format: Optional[str] = None
    """
    The format of the disk image being imported. One of VHD or VMDK.
    """
    url: Optional[str] = None
    """
    The URL to the Amazon S3-based disk image being imported. It can either be a https URL (https://..) or an Amazon S3 URL (s3://..). One of url or user_bucket must be set.
    """
    userBucket: Optional[List[UserBucketItem]] = None
    """
    The Amazon S3 bucket for the disk image. One of url or user_bucket must be set. Detailed below.
    """


class Resolution(Enum):
    Required = 'Required'
    Optional = 'Optional'


class Resolve(Enum):
    Always = 'Always'
    IfNotPresent = 'IfNotPresent'


class Policy(BaseModel):
    resolution: Optional[Resolution] = 'Required'
    """
    Resolution specifies whether resolution of this reference is required.
    The default is 'Required', which means the reconcile will fail if the
    reference cannot be resolved. 'Optional' means this reference will be
    a no-op if it cannot be resolved.
    """
    resolve: Optional[Resolve] = None
    """
    Resolve specifies when this reference should be resolved. The default
    is 'IfNotPresent', which will attempt to resolve the reference only when
    the corresponding field is not present. Use 'Always' to resolve the
    reference on every reconcile.
    """


class KmsKeyIdRef(BaseModel):
    name: str
    """
    Name of the referenced object.
    """
    policy: Optional[Policy] = None
    """
    Policies for referencing.
    """


class KmsKeyIdSelector(BaseModel):
    matchControllerRef: Optional[bool] = None
    """
    MatchControllerRef ensures an object with the same controller reference
    as the selecting object is selected.
    """
    matchLabels: Optional[Dict[str, str]] = None
    """
    MatchLabels ensures an object with matching labels is selected.
    """
    policy: Optional[Policy] = None
    """
    Policies for selection.
    """


class ForProvider(BaseModel):
    clientData: Optional[List[ClientDatum]] = None
    """
    The client-specific data. Detailed below.
    """
    description: Optional[str] = None
    """
    The description string for the import snapshot task.
    """
    diskContainer: Optional[List[DiskContainerItem]] = None
    """
    Information about the disk container. Detailed below.
    """
    encrypted: Optional[bool] = None
    """
    Specifies whether the destination snapshot of the imported image should be encrypted. The default KMS key for EBS is used unless you specify a non-default KMS key using KmsKeyId.
    """
    kmsKeyId: Optional[str] = None
    """
    An identifier for the symmetric KMS key to use when creating the encrypted snapshot. This parameter is only required if you want to use a non-default KMS key; if this parameter is not specified, the default KMS key for EBS is used. If a KmsKeyId is specified, the Encrypted flag must also be set.
    """
    kmsKeyIdRef: Optional[KmsKeyIdRef] = None
    """
    Reference to a Key in kms to populate kmsKeyId.
    """
    kmsKeyIdSelector: Optional[KmsKeyIdSelector] = None
    """
    Selector for a Key in kms to populate kmsKeyId.
    """
    permanentRestore: Optional[bool] = None
    """
    Indicates whether to permanently restore an archived snapshot.
    """
    region: str
    """
    Region is the region you'd like your resource to be created in.
    """
    roleName: Optional[str] = None
    """
    The name of the IAM Role the VM Import/Export service will assume. This role needs certain permissions. See https://docs.aws.amazon.com/vm-import/latest/userguide/vmie_prereqs.html#vmimport-role. Default: vmimport
    """
    storageTier: Optional[str] = None
    """
    The name of the storage tier. Valid values are archive and standard. Default value is standard.
    """
    tags: Optional[Dict[str, str]] = None
    """
    Key-value map of resource tags.
    """
    temporaryRestoreDays: Optional[float] = None
    """
    Specifies the number of days for which to temporarily restore an archived snapshot. Required for temporary restores only. The snapshot will be automatically re-archived after this period.
    """


class InitProvider(BaseModel):
    clientData: Optional[List[ClientDatum]] = None
    """
    The client-specific data. Detailed below.
    """
    description: Optional[str] = None
    """
    The description string for the import snapshot task.
    """
    diskContainer: Optional[List[DiskContainerItem]] = None
    """
    Information about the disk container. Detailed below.
    """
    encrypted: Optional[bool] = None
    """
    Specifies whether the destination snapshot of the imported image should be encrypted. The default KMS key for EBS is used unless you specify a non-default KMS key using KmsKeyId.
    """
    kmsKeyId: Optional[str] = None
    """
    An identifier for the symmetric KMS key to use when creating the encrypted snapshot. This parameter is only required if you want to use a non-default KMS key; if this parameter is not specified, the default KMS key for EBS is used. If a KmsKeyId is specified, the Encrypted flag must also be set.
    """
    kmsKeyIdRef: Optional[KmsKeyIdRef] = None
    """
    Reference to a Key in kms to populate kmsKeyId.
    """
    kmsKeyIdSelector: Optional[KmsKeyIdSelector] = None
    """
    Selector for a Key in kms to populate kmsKeyId.
    """
    permanentRestore: Optional[bool] = None
    """
    Indicates whether to permanently restore an archived snapshot.
    """
    roleName: Optional[str] = None
    """
    The name of the IAM Role the VM Import/Export service will assume. This role needs certain permissions. See https://docs.aws.amazon.com/vm-import/latest/userguide/vmie_prereqs.html#vmimport-role. Default: vmimport
    """
    storageTier: Optional[str] = None
    """
    The name of the storage tier. Valid values are archive and standard. Default value is standard.
    """
    tags: Optional[Dict[str, str]] = None
    """
    Key-value map of resource tags.
    """
    temporaryRestoreDays: Optional[float] = None
    """
    Specifies the number of days for which to temporarily restore an archived snapshot. Required for temporary restores only. The snapshot will be automatically re-archived after this period.
    """


class ManagementPolicy(Enum):
    Observe = 'Observe'
    Create = 'Create'
    Update = 'Update'
    Delete = 'Delete'
    LateInitialize = 'LateInitialize'
    field_ = '*'


class ProviderConfigRef(BaseModel):
    name: str
    """
    Name of the referenced object.
    """
    policy: Optional[Policy] = None
    """
    Policies for referencing.
    """


class ConfigRef(BaseModel):
    name: str
    """
    Name of the referenced object.
    """
    policy: Optional[Policy] = None
    """
    Policies for referencing.
    """


class Metadata(BaseModel):
    annotations: Optional[Dict[str, str]] = None
    """
    Annotations are the annotations to be added to connection secret.
    - For Kubernetes secrets, this will be used as "metadata.annotations".
    - It is up to Secret Store implementation for others store types.
    """
    labels: Optional[Dict[str, str]] = None
    """
    Labels are the labels/tags to be added to connection secret.
    - For Kubernetes secrets, this will be used as "metadata.labels".
    - It is up to Secret Store implementation for others store types.
    """
    type: Optional[str] = None
    """
    Type is the SecretType for the connection secret.
    - Only valid for Kubernetes Secret Stores.
    """


class PublishConnectionDetailsTo(BaseModel):
    configRef: Optional[ConfigRef] = Field(
        default_factory=lambda: ConfigRef.model_validate({'name': 'default'})
    )
    """
    SecretStoreConfigRef specifies which secret store config should be used
    for this ConnectionSecret.
    """
    metadata: Optional[Metadata] = None
    """
    Metadata is the metadata for connection secret.
    """
    name: str
    """
    Name is the name of the connection secret.
    """


class WriteConnectionSecretToRef(BaseModel):
    name: str
    """
    Name of the secret.
    """
    namespace: str
    """
    Namespace of the secret.
    """


class Spec(BaseModel):
    deletionPolicy: Optional[DeletionPolicy] = 'Delete'
    """
    DeletionPolicy specifies what will happen to the underlying external
    when this managed resource is deleted - either "Delete" or "Orphan" the
    external resource.
    This field is planned to be deprecated in favor of the ManagementPolicies
    field in a future release. Currently, both could be set independently and
    non-default values would be honored if the feature flag is enabled.
    See the design doc for more information: https://github.com/crossplane/crossplane/blob/499895a25d1a1a0ba1604944ef98ac7a1a71f197/design/design-doc-observe-only-resources.md?plain=1#L223
    """
    forProvider: ForProvider
    initProvider: Optional[InitProvider] = None
    """
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
    """
    managementPolicies: Optional[List[ManagementPolicy]] = ['*']
    """
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
    """
    providerConfigRef: Optional[ProviderConfigRef] = Field(
        default_factory=lambda: ProviderConfigRef.model_validate({'name': 'default'})
    )
    """
    ProviderConfigReference specifies how the provider that will be used to
    create, observe, update, and delete this managed resource should be
    configured.
    """
    publishConnectionDetailsTo: Optional[PublishConnectionDetailsTo] = None
    """
    PublishConnectionDetailsTo specifies the connection secret config which
    contains a name, metadata and a reference to secret store config to
    which any connection details for this managed resource should be written.
    Connection details frequently include the endpoint, username,
    and password required to connect to the managed resource.
    """
    writeConnectionSecretToRef: Optional[WriteConnectionSecretToRef] = None
    """
    WriteConnectionSecretToReference specifies the namespace and name of a
    Secret to which any connection details for this managed resource should
    be written. Connection details frequently include the endpoint, username,
    and password required to connect to the managed resource.
    This field is planned to be replaced in a future release in favor of
    PublishConnectionDetailsTo. Currently, both could be set independently
    and connection details would be published to both without affecting
    each other.
    """


class AtProvider(BaseModel):
    arn: Optional[str] = None
    """
    Amazon Resource Name (ARN) of the EBS Snapshot.
    """
    clientData: Optional[List[ClientDatum]] = None
    """
    The client-specific data. Detailed below.
    """
    dataEncryptionKeyId: Optional[str] = None
    """
    The data encryption key identifier for the snapshot.
    """
    description: Optional[str] = None
    """
    The description string for the import snapshot task.
    """
    diskContainer: Optional[List[DiskContainerItem]] = None
    """
    Information about the disk container. Detailed below.
    """
    encrypted: Optional[bool] = None
    """
    Specifies whether the destination snapshot of the imported image should be encrypted. The default KMS key for EBS is used unless you specify a non-default KMS key using KmsKeyId.
    """
    id: Optional[str] = None
    """
    The snapshot ID (e.g., snap-59fcb34e).
    """
    kmsKeyId: Optional[str] = None
    """
    An identifier for the symmetric KMS key to use when creating the encrypted snapshot. This parameter is only required if you want to use a non-default KMS key; if this parameter is not specified, the default KMS key for EBS is used. If a KmsKeyId is specified, the Encrypted flag must also be set.
    """
    outpostArn: Optional[str] = None
    """
    Amazon Resource Name (ARN) of the EBS Snapshot.
    """
    ownerAlias: Optional[str] = None
    """
    Value from an Amazon-maintained list (amazon, aws-marketplace, microsoft) of snapshot owners.
    """
    ownerId: Optional[str] = None
    """
    The AWS account ID of the EBS snapshot owner.
    """
    permanentRestore: Optional[bool] = None
    """
    Indicates whether to permanently restore an archived snapshot.
    """
    roleName: Optional[str] = None
    """
    The name of the IAM Role the VM Import/Export service will assume. This role needs certain permissions. See https://docs.aws.amazon.com/vm-import/latest/userguide/vmie_prereqs.html#vmimport-role. Default: vmimport
    """
    storageTier: Optional[str] = None
    """
    The name of the storage tier. Valid values are archive and standard. Default value is standard.
    """
    tags: Optional[Dict[str, str]] = None
    """
    Key-value map of resource tags.
    """
    tagsAll: Optional[Dict[str, str]] = None
    """
    A map of tags assigned to the resource, including those inherited from the provider default_tags configuration block.
    """
    temporaryRestoreDays: Optional[float] = None
    """
    Specifies the number of days for which to temporarily restore an archived snapshot. Required for temporary restores only. The snapshot will be automatically re-archived after this period.
    """
    volumeId: Optional[str] = None
    """
    The snapshot ID (e.g., snap-59fcb34e).
    """
    volumeSize: Optional[float] = None
    """
    The size of the drive in GiBs.
    """


class Condition(BaseModel):
    lastTransitionTime: AwareDatetime
    """
    LastTransitionTime is the last time this condition transitioned from one
    status to another.
    """
    message: Optional[str] = None
    """
    A Message containing details about this condition's last transition from
    one status to another, if any.
    """
    observedGeneration: Optional[int] = None
    """
    ObservedGeneration represents the .metadata.generation that the condition was set based upon.
    For instance, if .metadata.generation is currently 12, but the .status.conditions[x].observedGeneration is 9, the condition is out of date
    with respect to the current state of the instance.
    """
    reason: str
    """
    A Reason for this condition's last transition from one status to another.
    """
    status: str
    """
    Status of this condition; is it currently True, False, or Unknown?
    """
    type: str
    """
    Type of this condition. At most one of each condition type may apply to
    a resource at any point in time.
    """


class Status(BaseModel):
    atProvider: Optional[AtProvider] = None
    conditions: Optional[List[Condition]] = None
    """
    Conditions of the resource.
    """
    observedGeneration: Optional[int] = None
    """
    ObservedGeneration is the latest metadata.generation
    which resulted in either a ready state, or stalled due to error
    it can not recover from without human intervention.
    """


class EBSSnapshotImport(BaseModel):
    apiVersion: Optional[str] = None
    """
    APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    """
    kind: Optional[str] = None
    """
    Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    """
    metadata: Optional[v1.ObjectMeta] = None
    """
    Standard object's metadata. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata
    """
    spec: Spec
    """
    EBSSnapshotImportSpec defines the desired state of EBSSnapshotImport
    """
    status: Optional[Status] = None
    """
    EBSSnapshotImportStatus defines the observed state of EBSSnapshotImport.
    """


class EBSSnapshotImportList(BaseModel):
    apiVersion: Optional[str] = None
    """
    APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    """
    items: List[EBSSnapshotImport]
    """
    List of ebssnapshotimports. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md
    """
    kind: Optional[str] = None
    """
    Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    """
    metadata: Optional[v1.ListMeta] = None
    """
    Standard list metadata. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    """