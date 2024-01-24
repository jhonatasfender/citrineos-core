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

import { MessageFormatEnumType, MessagePriorityEnumType, MessageStateEnumType } from "../enums";
import { OcppRequest } from "../../..";

export interface NotifyDisplayMessagesRequest extends OcppRequest {
  customData?: CustomDataType;
  /**
   * @minItems 1
   */
  messageInfo?: [MessageInfoType, ...MessageInfoType[]];
  /**
   * The id of the &lt;&lt;getdisplaymessagesrequest,GetDisplayMessagesRequest&gt;&gt; that requested this message.
   *
   */
  requestId: number;
  /**
   * "to be continued" indicator. Indicates whether another part of the report follows in an upcoming NotifyDisplayMessagesRequest message. Default value when omitted is false.
   *
   */
  tbc?: boolean;
}
/**
 * This class does not get 'AdditionalProperties = false' in the schema generation, so it can be extended with arbitrary JSON properties to allow adding custom data.
 */
export interface CustomDataType {
  vendorId: string;
  [k: string]: unknown;
}
/**
 * Message_ Info
 * urn:x-enexis:ecdm:uid:2:233264
 * Contains message details, for a message to be displayed on a Charging Station.
 *
 */
export interface MessageInfoType {
  customData?: CustomDataType;
  display?: ComponentType;
  /**
   * Identified_ Object. MRID. Numeric_ Identifier
   * urn:x-enexis:ecdm:uid:1:569198
   * Master resource identifier, unique within an exchange context. It is defined within the OCPP context as a positive Integer value (greater or equal to zero).
   *
   */
  id: number;
  priority: MessagePriorityEnumType;
  state?: MessageStateEnumType;
  /**
   * Message_ Info. Start. Date_ Time
   * urn:x-enexis:ecdm:uid:1:569256
   * From what date-time should this message be shown. If omitted: directly.
   *
   */
  startDateTime?: string;
  /**
   * Message_ Info. End. Date_ Time
   * urn:x-enexis:ecdm:uid:1:569257
   * Until what date-time should this message be shown, after this date/time this message SHALL be removed.
   *
   */
  endDateTime?: string;
  /**
   * During which transaction shall this message be shown.
   * Message SHALL be removed by the Charging Station after transaction has
   * ended.
   *
   */
  transactionId?: string;
  message: MessageContentType;
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
 * Message_ Content
 * urn:x-enexis:ecdm:uid:2:234490
 * Contains message details, for a message to be displayed on a Charging Station.
 *
 *
 */
export interface MessageContentType {
  customData?: CustomDataType;
  format: MessageFormatEnumType;
  /**
   * Message_ Content. Language. Language_ Code
   * urn:x-enexis:ecdm:uid:1:570849
   * Message language identifier. Contains a language code as defined in &lt;&lt;ref-RFC5646,[RFC5646]&gt;&gt;.
   *
   */
  language?: string;
  /**
   * Message_ Content. Content. Message
   * urn:x-enexis:ecdm:uid:1:570852
   * Message contents.
   *
   *
   */
  content: string;
}




