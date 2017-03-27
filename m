From: Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: Re: [PATCH v1.1 3/3] device property:
 fwnode_property_read_string_array() returns nr of strings
Date: Tue, 28 Mar 2017 00:46:12 +0300
Message-ID: <28c01bed-d2cb-153f-1e1f-a04b6c045581@linux.intel.com>
References: <1488806791-25488-4-git-send-email-sakari.ailus@linux.intel.com>
 <1489584688-15624-1-git-send-email-sakari.ailus@linux.intel.com>
 <20170327133618.GH2957@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:42501 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752238AbdC0Vt4 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 27 Mar 2017 17:49:56 -0400
In-Reply-To: <20170327133618.GH2957@lahna.fi.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, devicetree@vger.kernel.org, sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, rafael@kernel.org, mark.rutland@arm.com, broonie@kernel.org, robh@kernel.org, ahs3@redhat.com

Hi Mika,

Mika Westerberg wrote:
> On Wed, Mar 15, 2017 at 03:31:28PM +0200, Sakari Ailus wrote:
>> Functionally fwnode_property_read_string_array() should match
>> of_property_read_string_array() and work as a drop-in substitute for the
>> latter. of_property_read_string_array() returns the number of strings read
>> if the target string pointer array is non-NULL. Make
>> fwnode_property_read_string_array() do the same.
>>
>> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
>> ---
>> This patch replaces v1 3/3 patch in this set.
>>
>> Instead of changing the return value of fwnode / device property API
>> string array access on OF, change the behaviour on pset and ACPI instead.
>> This makes them to return the number of strings read on success.
>>
>> I can merge this with patch 2/3 which is changing the same part of the
>> file, however I'm sending this separately at least for now as I think it's
>> easier to review this way, rather than making a bugfix and a change of the
>> behaviour in the same patch.
>>
>> Regards,
>> Sakari
>>
>>  drivers/base/property.c | 64 +++++++++++++++++++++++++++++++++++--------------
>>  1 file changed, 46 insertions(+), 18 deletions(-)
>>
>> diff --git a/drivers/base/property.c b/drivers/base/property.c
>> index 8c98390..82187ac 100644
>> --- a/drivers/base/property.c
>> +++ b/drivers/base/property.c
>> @@ -340,8 +340,8 @@ EXPORT_SYMBOL_GPL(device_property_read_u64_array);
>>   * Function reads an array of string properties with @propname from the device
>>   * firmware description and stores them to @val if found.
>>   *
>> - * Return: number of values if @val was %NULL,
>> - *         %0 if the property was found (success),
>> + * Return: number of values read on success if @val is non-NULL,
>> + *	   number of values available on success if @val is NULL,
>>   *	   %-EINVAL if given arguments are not valid,
>>   *	   %-ENODATA if the property does not have a value,
>>   *	   %-EPROTO or %-EILSEQ if the property is not an array of strings,
>> @@ -549,29 +549,57 @@ static int __fwnode_property_read_string_array(struct fwnode_handle *fwnode,
>>  			of_property_read_string_array(to_of_node(fwnode),
>>  						      propname, val, nval) :
>>  			of_property_count_strings(to_of_node(fwnode), propname);
>> -	else if (is_acpi_node(fwnode))
>> -		return acpi_node_prop_read(fwnode, propname, DEV_PROP_STRING,
>> -					   val, nval);
>> -	else if (is_pset_node(fwnode)) {
>> +	else if (is_acpi_node(fwnode)) {
>> +		int array_len =
>> +			acpi_node_prop_read(fwnode, propname, DEV_PROP_STRING,
>
> Why not change acpi_node_prop_read() instead? This way you don't need to
> add the extra code dealing with the return value here.
>
> Ditto for the pset counterpart.

There are a few other users of acpi_node_prop_read() albeit there are 
not too many of them. acpi_node_prop_read() is just calling 
acpi_dev_prop_read() which is public but apparently has no users. I 
think changing that would be quite feasible, I'll take that into account 
in the next version. Same for pset.

-- 
Sakari Ailus
sakari.ailus@linux.intel.com
