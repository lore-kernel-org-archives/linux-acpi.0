From: Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: Re: [PATCH v4 15/16] device property: Add fwnode_get_next_parent()
Date: Tue, 14 Mar 2017 09:51:02 +0200
Message-ID: <d2c06f1b-fd77-83b1-341e-04c61f8bd839@linux.intel.com>
References: <1488809970-25568-1-git-send-email-sakari.ailus@linux.intel.com>
 <1488809970-25568-16-git-send-email-sakari.ailus@linux.intel.com>
 <2027673.WAD1C0MHDO@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:28608 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750780AbdCNHvL (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 14 Mar 2017 03:51:11 -0400
In-Reply-To: <2027673.WAD1C0MHDO@aspire.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, devicetree@vger.kernel.org, sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, mika.westerberg@linux.intel.com, rafael@kernel.org, mark.rutland@arm.com, broonie@kernel.org, robh@kernel.org, ahs3@redhat.com

On 03/13/17 23:58, Rafael J. Wysocki wrote:
> On Monday, March 06, 2017 04:19:29 PM Sakari Ailus wrote:
>> In order to differentiate the functionality between dropping a reference
>> to the node (or not) for the benefit of OF, introduce
>> fwnode_get_next_parent().
>>
>> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
>> ---
>>  drivers/base/property.c  | 29 +++++++++++++++++++++++++++++
>>  include/linux/property.h |  1 +
>>  2 files changed, 30 insertions(+)
>>
>> diff --git a/drivers/base/property.c b/drivers/base/property.c
>> index b8c1017..defeba9 100644
>> --- a/drivers/base/property.c
>> +++ b/drivers/base/property.c
>> @@ -953,6 +953,35 @@ int device_add_properties(struct device *dev,
>>  EXPORT_SYMBOL_GPL(device_add_properties);
>>  
>>  /**
>> + * fwnode_get_next_parent - Iterate to the node's parent
>> + * @fwnode: Firmware whose parent is retrieved
>> + *
>> + * This is like fwnode_get_parent() except that it drops the refcount
>> + * on the passed node, making it suitable for iterating through a
>> + * node's parents.
>> + *
>> + * Returns a node pointer with refcount incremented, use
>> + * fwnode_handle_node() on it when done.
>> + */
>> +struct fwnode_handle *fwnode_get_next_parent(struct fwnode_handle *fwnode)
>> +{
>> +	struct fwnode_handle *parent = NULL;
>> +
>> +	if (is_of_node(fwnode)) {
>> +		struct device_node *node;
>> +
>> +		node = of_get_next_parent(to_of_node(fwnode));
> 
> So I would fold the [14/15] into this one and then it should be clear why that
> change was useful.

Ok, I'll fold the two patches.

-- 
Regards,

Sakari Ailus
sakari.ailus@linux.intel.com
