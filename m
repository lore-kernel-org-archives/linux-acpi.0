From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v7.2 7/7] device property: Get rid of struct fwnode_handle
 type field
Date: Thu, 22 Jun 2017 02:57:08 +0200
Message-ID: <CAJZ5v0iTmeXAhjb47L8OeGBxue6tsMEEPeDGco+ZDkXo4MqLzg@mail.gmail.com>
References: <1497354548-17502-1-git-send-email-sakari.ailus@linux.intel.com>
 <1497948596-1009-1-git-send-email-sakari.ailus@linux.intel.com> <20170620141414.GA11351@red-moon>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-it0-f66.google.com ([209.85.214.66]:34834 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751083AbdFVA5K (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 21 Jun 2017 20:57:10 -0400
In-Reply-To: <20170620141414.GA11351@red-moon>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, Al Stone <ahs3@redhat.com>, Frank Rowand <frowand.list@gmail.com>, kieran.bingham@ideasonboard.com

On Tue, Jun 20, 2017 at 4:14 PM, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
> On Tue, Jun 20, 2017 at 11:49:56AM +0300, Sakari Ailus wrote:
>
> [...]
>
>> +#define DECLARE_ACPI_FWNODE_OPS(ops) \
>> +     const struct fwnode_operations ops = {                          \
>> +             .device_is_available = acpi_fwnode_device_is_available, \
>> +             .property_present = acpi_fwnode_property_present,       \
>> +             .property_read_int_array =                              \
>> +                     acpi_fwnode_property_read_int_array,            \
>> +             .property_read_string_array =                           \
>> +                     acpi_fwnode_property_read_string_array,         \
>> +             .get_parent = acpi_node_get_parent,                     \
>> +             .get_next_child_node = acpi_get_next_subnode,           \
>> +             .get_named_child_node = acpi_fwnode_get_named_child_node, \
>> +             .graph_get_next_endpoint =                              \
>> +                     acpi_fwnode_graph_get_next_endpoint,            \
>> +             .graph_get_remote_endpoint =                            \
>> +                     acpi_fwnode_graph_get_remote_endpoint,          \
>> +             .graph_get_port_parent = acpi_node_get_parent,          \
>> +             .graph_parse_endpoint = acpi_fwnode_graph_parse_endpoint, \
>> +     };                                                              \
>> +     EXPORT_SYMBOL_GPL(ops)
>> +
>> +DECLARE_ACPI_FWNODE_OPS(acpi_device_fwnode_ops);
>> +DECLARE_ACPI_FWNODE_OPS(acpi_data_fwnode_ops);
>> +DECLARE_ACPI_FWNODE_OPS(acpi_static_fwnode_ops);
>
> I do not think it is a great idea to associate valid fwnode_operations
> to a static ACPI fwnode (which is just a tag - like the IRQCHIP one).

Sakari, care to address this comment?

Thanks,
Rafael
