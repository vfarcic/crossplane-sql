# generated by datamodel-codegen:
#   filename:  workdir/ec2_aws_upbound_io_v1beta1_ami.yaml

from __future__ import annotations

from enum import Enum
from typing import Dict, List, Optional

from pydantic import AwareDatetime, BaseModel, Field

from .....k8s.apimachinery.pkg.apis.meta import v1


class DeletionPolicy(Enum):
    Orphan = 'Orphan'
    Delete = 'Delete'


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


class SnapshotIdRef(BaseModel):
    name: str
    """
    Name of the referenced object.
    """
    policy: Optional[Policy] = None
    """
    Policies for referencing.
    """


class SnapshotIdSelector(BaseModel):
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


class EbsBlockDeviceItem(BaseModel):
    deleteOnTermination: Optional[bool] = None
    """
    Boolean controlling whether the EBS volumes created to
    support each created instance will be deleted once that instance is terminated.
    """
    deviceName: Optional[str] = None
    """
    Path at which the device is exposed to created instances.
    """
    encrypted: Optional[bool] = None
    """
    Boolean controlling whether the created EBS volumes will be encrypted. Can't be used with snapshot_id.
    """
    iops: Optional[float] = None
    """
    Number of I/O operations per second the
    created volumes will support.
    """
    outpostArn: Optional[str] = None
    """
    ARN of the Outpost on which the snapshot is stored.
    """
    snapshotId: Optional[str] = None
    """
    ID of an EBS snapshot that will be used to initialize the created
    EBS volumes. If set, the volume_size attribute must be at least as large as the referenced
    snapshot.
    """
    snapshotIdRef: Optional[SnapshotIdRef] = None
    """
    Reference to a EBSSnapshot in ec2 to populate snapshotId.
    """
    snapshotIdSelector: Optional[SnapshotIdSelector] = None
    """
    Selector for a EBSSnapshot in ec2 to populate snapshotId.
    """
    throughput: Optional[float] = None
    """
    Throughput that the EBS volume supports, in MiB/s. Only valid for volume_type of gp3.
    """
    volumeSize: Optional[float] = None
    """
    Size of created volumes in GiB.
    If snapshot_id is set and volume_size is omitted then the volume will have the same size
    as the selected snapshot.
    """
    volumeType: Optional[str] = None
    """
    Type of EBS volume to create. Can be standard, gp2, gp3, io1, io2, sc1 or st1 (Default: standard).
    """


class EphemeralBlockDeviceItem(BaseModel):
    deviceName: Optional[str] = None
    """
    Path at which the device is exposed to created instances.
    """
    virtualName: Optional[str] = None
    """
    Name for the ephemeral device, of the form "ephemeralN" where
    N is a volume number starting from zero.
    """


class ForProvider(BaseModel):
    architecture: Optional[str] = None
    """
    Machine architecture for created instances. Defaults to "x86_64".
    """
    bootMode: Optional[str] = None
    """
    Boot mode of the AMI. For more information, see Boot modes in the Amazon Elastic Compute Cloud User Guide.
    """
    deprecationTime: Optional[str] = None
    """
    Date and time to deprecate the AMI. If you specified a value for seconds, Amazon EC2 rounds the seconds to the nearest minute. Valid values: RFC3339 time string (YYYY-MM-DDTHH:MM:SSZ)
    """
    description: Optional[str] = None
    """
    Longer, human-readable description for the AMI.
    """
    ebsBlockDevice: Optional[List[EbsBlockDeviceItem]] = None
    """
    Nested block describing an EBS block device that should be
    attached to created instances. The structure of this block is described below.
    """
    enaSupport: Optional[bool] = None
    """
    Whether enhanced networking with ENA is enabled. Defaults to false.
    """
    ephemeralBlockDevice: Optional[List[EphemeralBlockDeviceItem]] = None
    """
    Nested block describing an ephemeral block device that
    should be attached to created instances. The structure of this block is described below.
    """
    imageLocation: Optional[str] = None
    """
    Path to an S3 object containing an image manifest, e.g., created
    by the ec2-upload-bundle command in the EC2 command line tools.
    """
    imdsSupport: Optional[str] = None
    """
    If EC2 instances started from this image should require the use of the Instance Metadata Service V2 (IMDSv2), set this argument to v2.0. For more information, see Configure instance metadata options for new instances.
    """
    kernelId: Optional[str] = None
    """
    ID of the kernel image (AKI) that will be used as the paravirtual
    kernel in created instances.
    """
    name: Optional[str] = None
    """
    Region-unique name for the AMI.
    """
    ramdiskId: Optional[str] = None
    """
    ID of an initrd image (ARI) that will be used when booting the
    created instances.
    """
    region: str
    """
    Region is the region you'd like your resource to be created in.
    """
    rootDeviceName: Optional[str] = None
    """
    Name of the root device (for example, /dev/sda1, or /dev/xvda).
    """
    sriovNetSupport: Optional[str] = None
    """
    When set to "simple" (the default), enables enhanced networking
    for created instances. No other value is supported at this time.
    """
    tags: Optional[Dict[str, str]] = None
    """
    Key-value map of resource tags.
    """
    tpmSupport: Optional[str] = None
    """
    If the image is configured for NitroTPM support, the value is v2.0. For more information, see NitroTPM in the Amazon Elastic Compute Cloud User Guide.
    """
    virtualizationType: Optional[str] = None
    """
    Keyword to choose what virtualization mode created instances
    will use. Can be either "paravirtual" (the default) or "hvm". The choice of virtualization type
    changes the set of further arguments that are required, as described below.
    """


class InitProvider(BaseModel):
    architecture: Optional[str] = None
    """
    Machine architecture for created instances. Defaults to "x86_64".
    """
    bootMode: Optional[str] = None
    """
    Boot mode of the AMI. For more information, see Boot modes in the Amazon Elastic Compute Cloud User Guide.
    """
    deprecationTime: Optional[str] = None
    """
    Date and time to deprecate the AMI. If you specified a value for seconds, Amazon EC2 rounds the seconds to the nearest minute. Valid values: RFC3339 time string (YYYY-MM-DDTHH:MM:SSZ)
    """
    description: Optional[str] = None
    """
    Longer, human-readable description for the AMI.
    """
    ebsBlockDevice: Optional[List[EbsBlockDeviceItem]] = None
    """
    Nested block describing an EBS block device that should be
    attached to created instances. The structure of this block is described below.
    """
    enaSupport: Optional[bool] = None
    """
    Whether enhanced networking with ENA is enabled. Defaults to false.
    """
    ephemeralBlockDevice: Optional[List[EphemeralBlockDeviceItem]] = None
    """
    Nested block describing an ephemeral block device that
    should be attached to created instances. The structure of this block is described below.
    """
    imageLocation: Optional[str] = None
    """
    Path to an S3 object containing an image manifest, e.g., created
    by the ec2-upload-bundle command in the EC2 command line tools.
    """
    imdsSupport: Optional[str] = None
    """
    If EC2 instances started from this image should require the use of the Instance Metadata Service V2 (IMDSv2), set this argument to v2.0. For more information, see Configure instance metadata options for new instances.
    """
    kernelId: Optional[str] = None
    """
    ID of the kernel image (AKI) that will be used as the paravirtual
    kernel in created instances.
    """
    name: Optional[str] = None
    """
    Region-unique name for the AMI.
    """
    ramdiskId: Optional[str] = None
    """
    ID of an initrd image (ARI) that will be used when booting the
    created instances.
    """
    rootDeviceName: Optional[str] = None
    """
    Name of the root device (for example, /dev/sda1, or /dev/xvda).
    """
    sriovNetSupport: Optional[str] = None
    """
    When set to "simple" (the default), enables enhanced networking
    for created instances. No other value is supported at this time.
    """
    tags: Optional[Dict[str, str]] = None
    """
    Key-value map of resource tags.
    """
    tpmSupport: Optional[str] = None
    """
    If the image is configured for NitroTPM support, the value is v2.0. For more information, see NitroTPM in the Amazon Elastic Compute Cloud User Guide.
    """
    virtualizationType: Optional[str] = None
    """
    Keyword to choose what virtualization mode created instances
    will use. Can be either "paravirtual" (the default) or "hvm". The choice of virtualization type
    changes the set of further arguments that are required, as described below.
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


class EbsBlockDeviceItemModel(BaseModel):
    deleteOnTermination: Optional[bool] = None
    """
    Boolean controlling whether the EBS volumes created to
    support each created instance will be deleted once that instance is terminated.
    """
    deviceName: Optional[str] = None
    """
    Path at which the device is exposed to created instances.
    """
    encrypted: Optional[bool] = None
    """
    Boolean controlling whether the created EBS volumes will be encrypted. Can't be used with snapshot_id.
    """
    iops: Optional[float] = None
    """
    Number of I/O operations per second the
    created volumes will support.
    """
    outpostArn: Optional[str] = None
    """
    ARN of the Outpost on which the snapshot is stored.
    """
    snapshotId: Optional[str] = None
    """
    ID of an EBS snapshot that will be used to initialize the created
    EBS volumes. If set, the volume_size attribute must be at least as large as the referenced
    snapshot.
    """
    throughput: Optional[float] = None
    """
    Throughput that the EBS volume supports, in MiB/s. Only valid for volume_type of gp3.
    """
    volumeSize: Optional[float] = None
    """
    Size of created volumes in GiB.
    If snapshot_id is set and volume_size is omitted then the volume will have the same size
    as the selected snapshot.
    """
    volumeType: Optional[str] = None
    """
    Type of EBS volume to create. Can be standard, gp2, gp3, io1, io2, sc1 or st1 (Default: standard).
    """


class AtProvider(BaseModel):
    architecture: Optional[str] = None
    """
    Machine architecture for created instances. Defaults to "x86_64".
    """
    arn: Optional[str] = None
    """
    ARN of the AMI.
    """
    bootMode: Optional[str] = None
    """
    Boot mode of the AMI. For more information, see Boot modes in the Amazon Elastic Compute Cloud User Guide.
    """
    deprecationTime: Optional[str] = None
    """
    Date and time to deprecate the AMI. If you specified a value for seconds, Amazon EC2 rounds the seconds to the nearest minute. Valid values: RFC3339 time string (YYYY-MM-DDTHH:MM:SSZ)
    """
    description: Optional[str] = None
    """
    Longer, human-readable description for the AMI.
    """
    ebsBlockDevice: Optional[List[EbsBlockDeviceItemModel]] = None
    """
    Nested block describing an EBS block device that should be
    attached to created instances. The structure of this block is described below.
    """
    enaSupport: Optional[bool] = None
    """
    Whether enhanced networking with ENA is enabled. Defaults to false.
    """
    ephemeralBlockDevice: Optional[List[EphemeralBlockDeviceItem]] = None
    """
    Nested block describing an ephemeral block device that
    should be attached to created instances. The structure of this block is described below.
    """
    hypervisor: Optional[str] = None
    """
    Hypervisor type of the image.
    """
    id: Optional[str] = None
    """
    ID of the created AMI.
    """
    imageLocation: Optional[str] = None
    """
    Path to an S3 object containing an image manifest, e.g., created
    by the ec2-upload-bundle command in the EC2 command line tools.
    """
    imageOwnerAlias: Optional[str] = None
    """
    AWS account alias (for example, amazon, self) or the AWS account ID of the AMI owner.
    """
    imageType: Optional[str] = None
    """
    Type of image.
    """
    imdsSupport: Optional[str] = None
    """
    If EC2 instances started from this image should require the use of the Instance Metadata Service V2 (IMDSv2), set this argument to v2.0. For more information, see Configure instance metadata options for new instances.
    """
    kernelId: Optional[str] = None
    """
    ID of the kernel image (AKI) that will be used as the paravirtual
    kernel in created instances.
    """
    manageEbsSnapshots: Optional[bool] = None
    name: Optional[str] = None
    """
    Region-unique name for the AMI.
    """
    ownerId: Optional[str] = None
    """
    AWS account ID of the image owner.
    """
    platform: Optional[str] = None
    """
    This value is set to windows for Windows AMIs; otherwise, it is blank.
    """
    platformDetails: Optional[str] = None
    """
    Platform details associated with the billing code of the AMI.
    """
    public: Optional[bool] = None
    """
    Whether the image has public launch permissions.
    """
    ramdiskId: Optional[str] = None
    """
    ID of an initrd image (ARI) that will be used when booting the
    created instances.
    """
    rootDeviceName: Optional[str] = None
    """
    Name of the root device (for example, /dev/sda1, or /dev/xvda).
    """
    rootSnapshotId: Optional[str] = None
    """
    Snapshot ID for the root volume (for EBS-backed AMIs)
    """
    sriovNetSupport: Optional[str] = None
    """
    When set to "simple" (the default), enables enhanced networking
    for created instances. No other value is supported at this time.
    """
    tags: Optional[Dict[str, str]] = None
    """
    Key-value map of resource tags.
    """
    tagsAll: Optional[Dict[str, str]] = None
    """
    Map of tags assigned to the resource, including those inherited from the provider default_tags configuration block.
    """
    tpmSupport: Optional[str] = None
    """
    If the image is configured for NitroTPM support, the value is v2.0. For more information, see NitroTPM in the Amazon Elastic Compute Cloud User Guide.
    """
    usageOperation: Optional[str] = None
    """
    Operation of the Amazon EC2 instance and the billing code that is associated with the AMI.
    """
    virtualizationType: Optional[str] = None
    """
    Keyword to choose what virtualization mode created instances
    will use. Can be either "paravirtual" (the default) or "hvm". The choice of virtualization type
    changes the set of further arguments that are required, as described below.
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


class AMI(BaseModel):
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
    AMISpec defines the desired state of AMI
    """
    status: Optional[Status] = None
    """
    AMIStatus defines the observed state of AMI.
    """


class AMIList(BaseModel):
    apiVersion: Optional[str] = None
    """
    APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    """
    items: List[AMI]
    """
    List of amis. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md
    """
    kind: Optional[str] = None
    """
    Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    """
    metadata: Optional[v1.ListMeta] = None
    """
    Standard list metadata. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    """