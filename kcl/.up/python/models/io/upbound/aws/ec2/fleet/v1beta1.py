# generated by datamodel-codegen:
#   filename:  workdir/ec2_aws_upbound_io_v1beta1_fleet.yaml

from __future__ import annotations

from enum import Enum
from typing import Dict, List, Optional

from pydantic import AwareDatetime, BaseModel, Field

from .....k8s.apimachinery.pkg.apis.meta import v1


class DeletionPolicy(Enum):
    Orphan = 'Orphan'
    Delete = 'Delete'


class FleetInstanceSetItem(BaseModel):
    instanceIds: Optional[List[str]] = None
    """
    The IDs of the instances.
    """
    instanceType: Optional[str] = None
    """
    Instance type.
    """
    lifecycle: Optional[str] = None
    """
    Indicates if the instance that was launched is a Spot Instance or On-Demand Instance.
    """
    platform: Optional[str] = None
    """
    The value is Windows for Windows instances. Otherwise, the value is blank.
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


class LaunchTemplateIdRef(BaseModel):
    name: str
    """
    Name of the referenced object.
    """
    policy: Optional[Policy] = None
    """
    Policies for referencing.
    """


class LaunchTemplateIdSelector(BaseModel):
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


class VersionRef(BaseModel):
    name: str
    """
    Name of the referenced object.
    """
    policy: Optional[Policy] = None
    """
    Policies for referencing.
    """


class VersionSelector(BaseModel):
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


class LaunchTemplateSpecification(BaseModel):
    launchTemplateId: Optional[str] = None
    """
    The ID of the launch template.
    """
    launchTemplateIdRef: Optional[LaunchTemplateIdRef] = None
    """
    Reference to a LaunchTemplate in ec2 to populate launchTemplateId.
    """
    launchTemplateIdSelector: Optional[LaunchTemplateIdSelector] = None
    """
    Selector for a LaunchTemplate in ec2 to populate launchTemplateId.
    """
    launchTemplateName: Optional[str] = None
    """
    The name of the launch template.
    """
    version: Optional[str] = None
    """
    The launch template version number, $Latest, or $Default.
    """
    versionRef: Optional[VersionRef] = None
    """
    Reference to a LaunchTemplate in ec2 to populate version.
    """
    versionSelector: Optional[VersionSelector] = None
    """
    Selector for a LaunchTemplate in ec2 to populate version.
    """


class AcceleratorCount(BaseModel):
    max: Optional[float] = None
    """
    The maximum number of vCPUs. To specify no maximum limit, omit this parameter.
    """
    min: Optional[float] = None
    """
    The minimum number of vCPUs. To specify no minimum limit, specify 0.
    """


class AcceleratorTotalMemoryMib(BaseModel):
    max: Optional[float] = None
    """
    The maximum number of vCPUs. To specify no maximum limit, omit this parameter.
    """
    min: Optional[float] = None
    """
    The minimum number of vCPUs. To specify no minimum limit, specify 0.
    """


class BaselineEbsBandwidthMbps(BaseModel):
    max: Optional[float] = None
    """
    The maximum number of vCPUs. To specify no maximum limit, omit this parameter.
    """
    min: Optional[float] = None
    """
    The minimum number of vCPUs. To specify no minimum limit, specify 0.
    """


class MemoryGibPerVcpu(BaseModel):
    max: Optional[float] = None
    """
    The maximum number of vCPUs. To specify no maximum limit, omit this parameter.
    """
    min: Optional[float] = None
    """
    The minimum number of vCPUs. To specify no minimum limit, specify 0.
    """


class MemoryMib(BaseModel):
    max: Optional[float] = None
    """
    The maximum number of vCPUs. To specify no maximum limit, omit this parameter.
    """
    min: Optional[float] = None
    """
    The minimum number of vCPUs. To specify no minimum limit, specify 0.
    """


class NetworkBandwidthGbps(BaseModel):
    max: Optional[float] = None
    """
    The maximum number of vCPUs. To specify no maximum limit, omit this parameter.
    """
    min: Optional[float] = None
    """
    The minimum number of vCPUs. To specify no minimum limit, specify 0.
    """


class NetworkInterfaceCount(BaseModel):
    max: Optional[float] = None
    """
    The maximum number of vCPUs. To specify no maximum limit, omit this parameter.
    """
    min: Optional[float] = None
    """
    The minimum number of vCPUs. To specify no minimum limit, specify 0.
    """


class TotalLocalStorageGb(BaseModel):
    max: Optional[float] = None
    """
    The maximum number of vCPUs. To specify no maximum limit, omit this parameter.
    """
    min: Optional[float] = None
    """
    The minimum number of vCPUs. To specify no minimum limit, specify 0.
    """


class VcpuCount(BaseModel):
    max: Optional[float] = None
    """
    The maximum number of vCPUs. To specify no maximum limit, omit this parameter.
    """
    min: Optional[float] = None
    """
    The minimum number of vCPUs. To specify no minimum limit, specify 0.
    """


class InstanceRequirements(BaseModel):
    acceleratorCount: Optional[AcceleratorCount] = None
    """
    Block describing the minimum and maximum number of accelerators (GPUs, FPGAs, or AWS Inferentia chips). Default is no minimum or maximum limits.
    """
    acceleratorManufacturers: Optional[List[str]] = None
    """
    List of accelerator manufacturer names. Default is any manufacturer.
    """
    acceleratorNames: Optional[List[str]] = None
    """
    List of accelerator names. Default is any acclerator.
    """
    acceleratorTotalMemoryMib: Optional[AcceleratorTotalMemoryMib] = None
    """
    Block describing the minimum and maximum total memory of the accelerators. Default is no minimum or maximum.
    """
    acceleratorTypes: Optional[List[str]] = None
    """
    The accelerator types that must be on the instance type. Default is any accelerator type.
    """
    allowedInstanceTypes: Optional[List[str]] = None
    """
    The instance types to apply your specified attributes against. All other instance types are ignored, even if they match your specified attributes. You can use strings with one or more wild cards,represented by an asterisk (*). The following are examples: c5*, m5a.*, r*, *3*. For example, if you specify c5*, you are excluding the entire C5 instance family, which includes all C5a and C5n instance types. If you specify m5a.*, you are excluding all the M5a instance types, but not the M5n instance types. Maximum of 400 entries in the list; each entry is limited to 30 characters. Default is no excluded instance types. Default is any instance type.
    """
    bareMetal: Optional[str] = None
    """
    Indicate whether bare metal instace types should be included, excluded, or required. Default is excluded.
    """
    baselineEbsBandwidthMbps: Optional[BaselineEbsBandwidthMbps] = None
    """
    Block describing the minimum and maximum baseline EBS bandwidth, in Mbps. Default is no minimum or maximum.
    """
    burstablePerformance: Optional[str] = None
    """
    Indicates whether burstable performance T instance types are included, excluded, or required. Default is excluded.
    """
    cpuManufacturers: Optional[List[str]] = None
    """
    The CPU manufacturers to include. Default is any manufacturer.
    ~> NOTE: Don't confuse the CPU hardware manufacturer with the CPU hardware architecture. Instances will be launched with a compatible CPU architecture based on the Amazon Machine Image (AMI) that you specify in your launch template.
    """
    excludedInstanceTypes: Optional[List[str]] = None
    """
    The instance types to exclude. You can use strings with one or more wild cards, represented by an asterisk (*). The following are examples: c5*, m5a.*, r*, *3*. For example, if you specify c5*, you are excluding the entire C5 instance family, which includes all C5a and C5n instance types. If you specify m5a.*, you are excluding all the M5a instance types, but not the M5n instance types. Maximum of 400 entries in the list; each entry is limited to 30 characters. Default is no excluded instance types.
    """
    instanceGenerations: Optional[List[str]] = None
    """
    Indicates whether current or previous generation instance types are included. The current generation instance types are recommended for use. Valid values are current and previous. Default is current and previous generation instance types.
    """
    localStorage: Optional[str] = None
    """
    Indicate whether instance types with local storage volumes are included, excluded, or required. Default is included.
    """
    localStorageTypes: Optional[List[str]] = None
    """
    List of local storage type names. Valid values are hdd and ssd. Default any storage type.
    """
    maxSpotPriceAsPercentageOfOptimalOnDemandPrice: Optional[float] = None
    """
    The price protection threshold for Spot Instances. This is the maximum you’ll pay for a Spot Instance, expressed as a percentage higher than the cheapest M, C, or R instance type with your specified attributes. When Amazon EC2 Auto Scaling selects instance types with your attributes, we will exclude instance types whose price is higher than your threshold. The parameter accepts an integer, which Amazon EC2 Auto Scaling interprets as a percentage. To turn off price protection, specify a high value, such as 999999. Conflicts with spot_max_price_percentage_over_lowest_price
    """
    memoryGibPerVcpu: Optional[MemoryGibPerVcpu] = None
    """
    Block describing the minimum and maximum amount of memory (GiB) per vCPU. Default is no minimum or maximum.
    """
    memoryMib: Optional[MemoryMib] = None
    """
    The minimum and maximum amount of memory per vCPU, in GiB. Default is no minimum or maximum limits.
    """
    networkBandwidthGbps: Optional[NetworkBandwidthGbps] = None
    """
    The minimum and maximum amount of network bandwidth, in gigabits per second (Gbps). Default is No minimum or maximum.
    """
    networkInterfaceCount: Optional[NetworkInterfaceCount] = None
    """
    Block describing the minimum and maximum number of network interfaces. Default is no minimum or maximum.
    """
    onDemandMaxPricePercentageOverLowestPrice: Optional[float] = None
    """
    The price protection threshold for On-Demand Instances. This is the maximum you’ll pay for an On-Demand Instance, expressed as a percentage higher than the cheapest M, C, or R instance type with your specified attributes. When Amazon EC2 Auto Scaling selects instance types with your attributes, we will exclude instance types whose price is higher than your threshold. The parameter accepts an integer, which Amazon EC2 Auto Scaling interprets as a percentage. To turn off price protection, specify a high value, such as 999999. Default is 20.
    """
    requireHibernateSupport: Optional[bool] = None
    """
    Indicate whether instance types must support On-Demand Instance Hibernation, either true or false. Default is false.
    """
    spotMaxPricePercentageOverLowestPrice: Optional[float] = None
    """
    The price protection threshold for Spot Instances. This is the maximum you’ll pay for a Spot Instance, expressed as a percentage higher than the cheapest M, C, or R instance type with your specified attributes. When Amazon EC2 Auto Scaling selects instance types with your attributes, we will exclude instance types whose price is higher than your threshold. The parameter accepts an integer, which Amazon EC2 Auto Scaling interprets as a percentage. To turn off price protection, specify a high value, such as 999999. Default is 100. Conflicts with max_spot_price_as_percentage_of_optimal_on_demand_price
    """
    totalLocalStorageGb: Optional[TotalLocalStorageGb] = None
    """
    Block describing the minimum and maximum total local storage (GB). Default is no minimum or maximum.
    """
    vcpuCount: Optional[VcpuCount] = None
    """
    Block describing the minimum and maximum number of vCPUs. Default is no maximum.
    """


class OverrideItem(BaseModel):
    availabilityZone: Optional[str] = None
    """
    Availability Zone in which to launch the instances.
    """
    instanceRequirements: Optional[InstanceRequirements] = None
    """
    Override the instance type in the Launch Template with instance types that satisfy the requirements.
    """
    instanceType: Optional[str] = None
    """
    Instance type.
    """
    maxPrice: Optional[str] = None
    """
    Maximum price per unit hour that you are willing to pay for a Spot Instance.
    """
    priority: Optional[float] = None
    """
    Priority for the launch template override. If on_demand_options allocation_strategy is set to prioritized, EC2 Fleet uses priority to determine which launch template override to use first in fulfilling On-Demand capacity. The highest priority is launched first. The lower the number, the higher the priority. If no number is set, the launch template override has the lowest priority. Valid values are whole numbers starting at 0.
    """
    subnetId: Optional[str] = None
    """
    ID of the subnet in which to launch the instances.
    """
    weightedCapacity: Optional[float] = None
    """
    Number of units provided by the specified instance type.
    """


class LaunchTemplateConfigItem(BaseModel):
    launchTemplateSpecification: Optional[LaunchTemplateSpecification] = None
    """
    Nested argument containing EC2 Launch Template to use. Defined below.
    """
    override: Optional[List[OverrideItem]] = None
    """
    Nested argument(s) containing parameters to override the same parameters in the Launch Template. Defined below.
    """


class CapacityReservationOptions(BaseModel):
    usageStrategy: Optional[str] = None
    """
    Indicates whether to use unused Capacity Reservations for fulfilling On-Demand capacity. Valid values: use-capacity-reservations-first.
    """


class OnDemandOptions(BaseModel):
    allocationStrategy: Optional[str] = None
    """
    The order of the launch template overrides to use in fulfilling On-Demand capacity. Valid values: lowestPrice, prioritized. Default: lowestPrice.
    """
    capacityReservationOptions: Optional[CapacityReservationOptions] = None
    """
    Demand capacity. Supported only for fleets of type instant.
    """
    maxTotalPrice: Optional[str] = None
    """
    The maximum amount per hour for On-Demand Instances that you're willing to pay.
    """
    minTargetCapacity: Optional[float] = None
    """
    The minimum target capacity for On-Demand Instances in the fleet. If the minimum target capacity is not reached, the fleet launches no instances. Supported only for fleets of type instant.
    If you specify min_target_capacity, at least one of the following must be specified: single_availability_zone or single_instance_type.
    """
    singleAvailabilityZone: Optional[bool] = None
    """
    Indicates that the fleet launches all On-Demand Instances into a single Availability Zone. Supported only for fleets of type instant.
    """
    singleInstanceType: Optional[bool] = None
    """
    Indicates that the fleet uses a single instance type to launch all On-Demand Instances in the fleet. Supported only for fleets of type instant.
    """


class CapacityRebalance(BaseModel):
    replacementStrategy: Optional[str] = None
    """
    The replacement strategy to use. Only available for fleets of type set to maintain. Valid values: launch.
    """
    terminationDelay: Optional[float] = None


class MaintenanceStrategies(BaseModel):
    capacityRebalance: Optional[CapacityRebalance] = None
    """
    Nested argument containing the capacity rebalance for your fleet request. Defined below.
    """


class SpotOptions(BaseModel):
    allocationStrategy: Optional[str] = None
    """
    How to allocate the target capacity across the Spot pools. Valid values: diversified, lowestPrice, capacity-optimized, capacity-optimized-prioritized and price-capacity-optimized. Default: lowestPrice.
    """
    instanceInterruptionBehavior: Optional[str] = None
    """
    Behavior when a Spot Instance is interrupted. Valid values: hibernate, stop, terminate. Default: terminate.
    """
    instancePoolsToUseCount: Optional[float] = None
    """
    Number of Spot pools across which to allocate your target Spot capacity. Valid only when Spot allocation_strategy is set to lowestPrice. Default: 1.
    """
    maintenanceStrategies: Optional[MaintenanceStrategies] = None
    """
    Nested argument containing maintenance strategies for managing your Spot Instances that are at an elevated risk of being interrupted. Defined below.
    """


class TargetCapacitySpecification(BaseModel):
    defaultTargetCapacityType: Optional[str] = None
    """
    Default target capacity type. Valid values: on-demand, spot.
    """
    onDemandTargetCapacity: Optional[float] = None
    """
    The number of On-Demand units to request.
    """
    spotTargetCapacity: Optional[float] = None
    """
    The number of Spot units to request.
    """
    targetCapacityUnitType: Optional[str] = None
    """
    The unit for the target capacity.
    If you specify target_capacity_unit_type, instance_requirements must be specified.
    """
    totalTargetCapacity: Optional[float] = None
    """
    The number of units to request, filled using default_target_capacity_type.
    """


class ForProvider(BaseModel):
    context: Optional[str] = None
    """
    Reserved.
    """
    excessCapacityTerminationPolicy: Optional[str] = None
    """
    Whether running instances should be terminated if the total target capacity of the EC2 Fleet is decreased below the current size of the EC2. Valid values: no-termination, termination. Defaults to termination. Supported only for fleets of type maintain.
    """
    fleetInstanceSet: Optional[List[FleetInstanceSetItem]] = None
    """
    Information about the instances that were launched by the fleet. Available only when type is set to instant.
    """
    fleetState: Optional[str] = None
    """
    The state of the EC2 Fleet.
    """
    fulfilledCapacity: Optional[float] = None
    """
    The number of units fulfilled by this request compared to the set target capacity.
    """
    fulfilledOnDemandCapacity: Optional[float] = None
    """
    The number of units fulfilled by this request compared to the set target On-Demand capacity.
    """
    launchTemplateConfig: Optional[List[LaunchTemplateConfigItem]] = None
    """
    Nested argument containing EC2 Launch Template configurations. Defined below.
    """
    onDemandOptions: Optional[OnDemandOptions] = None
    """
    Nested argument containing On-Demand configurations. Defined below.
    """
    region: str
    """
    Region is the region you'd like your resource to be created in.
    """
    replaceUnhealthyInstances: Optional[bool] = None
    """
    Whether EC2 Fleet should replace unhealthy instances. Defaults to false. Supported only for fleets of type maintain.
    """
    spotOptions: Optional[SpotOptions] = None
    """
    Nested argument containing Spot configurations. Defined below.
    """
    tags: Optional[Dict[str, str]] = None
    """
    Key-value map of resource tags.
    """
    targetCapacitySpecification: Optional[TargetCapacitySpecification] = None
    """
    Nested argument containing target capacity configurations. Defined below.
    """
    terminateInstances: Optional[bool] = None
    """
    Whether to terminate instances for an EC2 Fleet if it is deleted successfully. Defaults to false.
    """
    terminateInstancesWithExpiration: Optional[bool] = None
    """
    Whether running instances should be terminated when the EC2 Fleet expires. Defaults to false.
    """
    type: Optional[str] = None
    """
    The type of request. Indicates whether the EC2 Fleet only requests the target capacity, or also attempts to maintain it. Valid values: maintain, request, instant. Defaults to maintain.
    """
    validFrom: Optional[str] = None
    """
    The start date and time of the request, in UTC format (for example, YYYY-MM-DDTHH:MM:SSZ). The default is to start fulfilling the request immediately.
    """
    validUntil: Optional[str] = None
    """
    The end date and time of the request, in UTC format (for example, YYYY-MM-DDTHH:MM:SSZ). At this point, no new EC2 Fleet requests are placed or able to fulfill the request. If no value is specified, the request remains until you cancel it.
    """


class InitProvider(BaseModel):
    context: Optional[str] = None
    """
    Reserved.
    """
    excessCapacityTerminationPolicy: Optional[str] = None
    """
    Whether running instances should be terminated if the total target capacity of the EC2 Fleet is decreased below the current size of the EC2. Valid values: no-termination, termination. Defaults to termination. Supported only for fleets of type maintain.
    """
    fleetInstanceSet: Optional[List[FleetInstanceSetItem]] = None
    """
    Information about the instances that were launched by the fleet. Available only when type is set to instant.
    """
    fleetState: Optional[str] = None
    """
    The state of the EC2 Fleet.
    """
    fulfilledCapacity: Optional[float] = None
    """
    The number of units fulfilled by this request compared to the set target capacity.
    """
    fulfilledOnDemandCapacity: Optional[float] = None
    """
    The number of units fulfilled by this request compared to the set target On-Demand capacity.
    """
    launchTemplateConfig: Optional[List[LaunchTemplateConfigItem]] = None
    """
    Nested argument containing EC2 Launch Template configurations. Defined below.
    """
    onDemandOptions: Optional[OnDemandOptions] = None
    """
    Nested argument containing On-Demand configurations. Defined below.
    """
    replaceUnhealthyInstances: Optional[bool] = None
    """
    Whether EC2 Fleet should replace unhealthy instances. Defaults to false. Supported only for fleets of type maintain.
    """
    spotOptions: Optional[SpotOptions] = None
    """
    Nested argument containing Spot configurations. Defined below.
    """
    tags: Optional[Dict[str, str]] = None
    """
    Key-value map of resource tags.
    """
    targetCapacitySpecification: Optional[TargetCapacitySpecification] = None
    """
    Nested argument containing target capacity configurations. Defined below.
    """
    terminateInstances: Optional[bool] = None
    """
    Whether to terminate instances for an EC2 Fleet if it is deleted successfully. Defaults to false.
    """
    terminateInstancesWithExpiration: Optional[bool] = None
    """
    Whether running instances should be terminated when the EC2 Fleet expires. Defaults to false.
    """
    type: Optional[str] = None
    """
    The type of request. Indicates whether the EC2 Fleet only requests the target capacity, or also attempts to maintain it. Valid values: maintain, request, instant. Defaults to maintain.
    """
    validFrom: Optional[str] = None
    """
    The start date and time of the request, in UTC format (for example, YYYY-MM-DDTHH:MM:SSZ). The default is to start fulfilling the request immediately.
    """
    validUntil: Optional[str] = None
    """
    The end date and time of the request, in UTC format (for example, YYYY-MM-DDTHH:MM:SSZ). At this point, no new EC2 Fleet requests are placed or able to fulfill the request. If no value is specified, the request remains until you cancel it.
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


class LaunchTemplateSpecificationModel(BaseModel):
    launchTemplateId: Optional[str] = None
    """
    The ID of the launch template.
    """
    launchTemplateName: Optional[str] = None
    """
    The name of the launch template.
    """
    version: Optional[str] = None
    """
    The launch template version number, $Latest, or $Default.
    """


class AtProvider(BaseModel):
    arn: Optional[str] = None
    """
    The ARN of the fleet
    """
    context: Optional[str] = None
    """
    Reserved.
    """
    excessCapacityTerminationPolicy: Optional[str] = None
    """
    Whether running instances should be terminated if the total target capacity of the EC2 Fleet is decreased below the current size of the EC2. Valid values: no-termination, termination. Defaults to termination. Supported only for fleets of type maintain.
    """
    fleetInstanceSet: Optional[List[FleetInstanceSetItem]] = None
    """
    Information about the instances that were launched by the fleet. Available only when type is set to instant.
    """
    fleetState: Optional[str] = None
    """
    The state of the EC2 Fleet.
    """
    fulfilledCapacity: Optional[float] = None
    """
    The number of units fulfilled by this request compared to the set target capacity.
    """
    fulfilledOnDemandCapacity: Optional[float] = None
    """
    The number of units fulfilled by this request compared to the set target On-Demand capacity.
    """
    id: Optional[str] = None
    """
    Fleet identifier
    """
    launchTemplateConfig: Optional[List[LaunchTemplateConfigItem]] = None
    """
    Nested argument containing EC2 Launch Template configurations. Defined below.
    """
    onDemandOptions: Optional[OnDemandOptions] = None
    """
    Nested argument containing On-Demand configurations. Defined below.
    """
    replaceUnhealthyInstances: Optional[bool] = None
    """
    Whether EC2 Fleet should replace unhealthy instances. Defaults to false. Supported only for fleets of type maintain.
    """
    spotOptions: Optional[SpotOptions] = None
    """
    Nested argument containing Spot configurations. Defined below.
    """
    tags: Optional[Dict[str, str]] = None
    """
    Key-value map of resource tags.
    """
    tagsAll: Optional[Dict[str, str]] = None
    """
    A map of tags assigned to the resource, including those inherited from the provider default_tags configuration block.
    """
    targetCapacitySpecification: Optional[TargetCapacitySpecification] = None
    """
    Nested argument containing target capacity configurations. Defined below.
    """
    terminateInstances: Optional[bool] = None
    """
    Whether to terminate instances for an EC2 Fleet if it is deleted successfully. Defaults to false.
    """
    terminateInstancesWithExpiration: Optional[bool] = None
    """
    Whether running instances should be terminated when the EC2 Fleet expires. Defaults to false.
    """
    type: Optional[str] = None
    """
    The type of request. Indicates whether the EC2 Fleet only requests the target capacity, or also attempts to maintain it. Valid values: maintain, request, instant. Defaults to maintain.
    """
    validFrom: Optional[str] = None
    """
    The start date and time of the request, in UTC format (for example, YYYY-MM-DDTHH:MM:SSZ). The default is to start fulfilling the request immediately.
    """
    validUntil: Optional[str] = None
    """
    The end date and time of the request, in UTC format (for example, YYYY-MM-DDTHH:MM:SSZ). At this point, no new EC2 Fleet requests are placed or able to fulfill the request. If no value is specified, the request remains until you cancel it.
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


class Fleet(BaseModel):
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
    FleetSpec defines the desired state of Fleet
    """
    status: Optional[Status] = None
    """
    FleetStatus defines the observed state of Fleet.
    """


class FleetList(BaseModel):
    apiVersion: Optional[str] = None
    """
    APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
    """
    items: List[Fleet]
    """
    List of fleets. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md
    """
    kind: Optional[str] = None
    """
    Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    """
    metadata: Optional[v1.ListMeta] = None
    """
    Standard list metadata. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
    """