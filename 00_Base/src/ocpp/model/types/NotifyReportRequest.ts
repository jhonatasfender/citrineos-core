/**
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 * Copyright 2023 S44, LLC
 */
/* eslint-disable */
/**
 * This file was automatically generated by json-schema-to-typescript.
 * DO NOT MODIFY IT BY HAND. Instead, modify the source JSONSchema file,
 * and run json-schema-to-typescript to regenerate this file.
 */

import { AttributeEnumType, DataEnumType, MutabilityEnumType } from "../enums";
import { OcppRequest } from "../../..";

export interface NotifyReportRequest extends OcppRequest {
  customData?: CustomDataType;
  /**
   * The id of the GetReportRequest  or GetBaseReportRequest that requested this report
   *
   */
  requestId: number;
  /**
   * Timestamp of the moment this message was generated at the Charging Station.
   *
   */
  generatedAt: string;
  /**
   * @minItems 1
   */
  reportData?: [ReportDataType, ...ReportDataType[]];
  /**
   * “to be continued” indicator. Indicates whether another part of the report follows in an upcoming notifyReportRequest message. Default value when omitted is false.
   *
   *
   */
  tbc?: boolean;
  /**
   * Sequence number of this message. First message starts at 0.
   *
   */
  seqNo: number;
}
/**
 * This class does not get 'AdditionalProperties = false' in the schema generation, so it can be extended with arbitrary JSON properties to allow adding custom data.
 */
export interface CustomDataType {
  vendorId: string;
  [k: string]: unknown;
}
/**
 * Class to report components, variables and variable attributes and characteristics.
 *
 */
export interface ReportDataType {
  customData?: CustomDataType;
  component: ComponentType;
  variable: VariableType;
  /**
   * @minItems 1
   * @maxItems 4
   */
  variableAttribute:
    | [VariableAttributeType]
    | [VariableAttributeType, VariableAttributeType]
    | [VariableAttributeType, VariableAttributeType, VariableAttributeType]
    | [VariableAttributeType, VariableAttributeType, VariableAttributeType, VariableAttributeType];
  variableCharacteristics?: VariableCharacteristicsType;
}
/**
 * A physical or logical component
 *
 */
export interface ComponentType {
  customData?: CustomDataType;
  evse?: EVSEType;
  /**
   * Name of the component. Name should be taken from the list of standardized component names whenever possible. Case Insensitive. strongly advised to use Camel Case.
   *
   */
  name: string;
  /**
   * Name of instance in case the component exists as multiple instances. Case Insensitive. strongly advised to use Camel Case.
   *
   */
  instance?: string;
}
/**
 * EVSE
 * urn:x-oca:ocpp:uid:2:233123
 * Electric Vehicle Supply Equipment
 *
 */
export interface EVSEType {
  customData?: CustomDataType;
  /**
   * Identified_ Object. MRID. Numeric_ Identifier
   * urn:x-enexis:ecdm:uid:1:569198
   * EVSE Identifier. This contains a number (&gt; 0) designating an EVSE of the Charging Station.
   *
   */
  id: number;
  /**
   * An id to designate a specific connector (on an EVSE) by connector index number.
   *
   */
  connectorId?: number;
}
/**
 * Reference key to a component-variable.
 *
 */
export interface VariableType {
  customData?: CustomDataType;
  /**
   * Name of the variable. Name should be taken from the list of standardized variable names whenever possible. Case Insensitive. strongly advised to use Camel Case.
   *
   */
  name: string;
  /**
   * Name of instance in case the variable exists as multiple instances. Case Insensitive. strongly advised to use Camel Case.
   *
   */
  instance?: string;
}
/**
 * Attribute data of a variable.
 *
 */
export interface VariableAttributeType {
  customData?: CustomDataType;
  type?: AttributeEnumType;
  /**
   * Value of the attribute. May only be omitted when mutability is set to 'WriteOnly'.
   *
   * The Configuration Variable &lt;&lt;configkey-reporting-value-size,ReportingValueSize&gt;&gt; can be used to limit GetVariableResult.attributeValue, VariableAttribute.value and EventData.actualValue. The max size of these values will always remain equal.
   *
   */
  value?: string;
  mutability?: MutabilityEnumType;
  /**
   * If true, value will be persistent across system reboots or power down. Default when omitted is false.
   *
   */
  persistent?: boolean;
  /**
   * If true, value that will never be changed by the Charging Station at runtime. Default when omitted is false.
   *
   */
  constant?: boolean;
}
/**
 * Fixed read-only parameters of a variable.
 *
 */
export interface VariableCharacteristicsType {
  customData?: CustomDataType;
  /**
   * Unit of the variable. When the transmitted value has a unit, this field SHALL be included.
   *
   */
  unit?: string;
  dataType: DataEnumType;
  /**
   * Minimum possible value of this variable.
   *
   */
  minLimit?: number;
  /**
   * Maximum possible value of this variable. When the datatype of this Variable is String, OptionList, SequenceList or MemberList, this field defines the maximum length of the (CSV) string.
   *
   */
  maxLimit?: number;
  /**
   * Allowed values when variable is Option/Member/SequenceList.
   *
   * * OptionList: The (Actual) Variable value must be a single value from the reported (CSV) enumeration list.
   *
   * * MemberList: The (Actual) Variable value  may be an (unordered) (sub-)set of the reported (CSV) valid values list.
   *
   * * SequenceList: The (Actual) Variable value  may be an ordered (priority, etc)  (sub-)set of the reported (CSV) valid values.
   *
   * This is a comma separated list.
   *
   * The Configuration Variable &lt;&lt;configkey-configuration-value-size,ConfigurationValueSize&gt;&gt; can be used to limit SetVariableData.attributeValue and VariableCharacteristics.valueList. The max size of these values will always remain equal.
   *
   *
   */
  valuesList?: string;
  /**
   * Flag indicating if this variable supports monitoring.
   *
   */
  supportsMonitoring: boolean;
}




