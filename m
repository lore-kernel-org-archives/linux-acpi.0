From: Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: Re: [PATCH v4 13/16] device property: Add support for fwnode
 endpoints
Date: Tue, 14 Mar 2017 09:46:19 +0200
Message-ID: <5a98d396-4170-ef31-14de-93667d6e6990@linux.intel.com>
References: <1488809970-25568-1-git-send-email-sakari.ailus@linux.intel.com>
 <1488809970-25568-14-git-send-email-sakari.ailus@linux.intel.com>
 <1907784.opL26JLB0u@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:3505 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750793AbdCNHrv (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 14 Mar 2017 03:47:51 -0400
In-Reply-To: <1907784.opL26JLB0u@aspire.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, devicetree@vger.kernel.org, sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, mika.westerberg@linux.intel.com, rafael@kernel.org, mark.rutland@arm.com, broonie@kernel.org, robh@kernel.org, ahs3@redhat.com

Hi Rafael,

On 03/13/17 23:52, Rafael J. Wysocki wrote:
> On Monday, March 06, 2017 04:19:27 PM Sakari Ailus wrote:
>> Similar to OF endpoints, endpoint type nodes can be also supported on
>> ACPI. In order to make it possible for drivers to ignore the matter,
>> add a type for fwnode_endpoint and a function to parse them.
>>
>> On ACPI, find the child node index instead of relying on the "endpoint"
>> property.
>>
>> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
>> ---
>>  drivers/base/property.c  | 36 ++++++++++++++++++++++++++++++++++++
>>  include/linux/fwnode.h   |  6 ++++++
>>  include/linux/property.h |  3 +++
>>  3 files changed, 45 insertions(+)
>>
>> diff --git a/drivers/base/property.c b/drivers/base/property.c
>> index 860e160..b8c1017 100644
>> --- a/drivers/base/property.c
>> +++ b/drivers/base/property.c
>> @@ -1330,3 +1330,39 @@ fwnode_graph_get_remote_endpoint(struct fwnode_handle *fwnode)
>>  	return endpoint;
>>  }
>>  EXPORT_SYMBOL_GPL(fwnode_graph_get_remote_endpoint);
>> +
>> +/*
> 
> That should be /** I gather?

Indeed.

> 
>> + * fwnode_graph_parse_endpoint() - parse common endpoint node properties
> 
> The parens at the end of the function name above are not necessary.

I'll drop them.

> 
>> + * @node: pointer to endpoint device_node
>> + * @endpoint: pointer to the fwnode endpoint data structure
>> + *
>> + * The caller should hold a reference to @node.
> 
> A few words about what the function does, please.

I'll add that. Also "node" should be "fwnode", I think I changed the
argument name but not the documentation. "device_node" should be
"fwnode_handle", too.

> 
>> + */
>> +int fwnode_graph_parse_endpoint(struct fwnode_handle *fwnode,
>> +				struct fwnode_endpoint *endpoint)
>> +{
>> +	struct fwnode_handle *port_fwnode = fwnode_get_parent(fwnode);
>> +
>> +	memset(endpoint, 0, sizeof(*endpoint));
>> +
>> +	endpoint->local_fwnode = fwnode;
>> +
>> +	if (is_acpi_node(port_fwnode)) {
>> +		struct fwnode_handle *iter;
>> +
>> +		fwnode_property_read_u32(port_fwnode, "port", &endpoint->port);
>> +
>> +		for (iter = fwnode_get_next_child_node(port_fwnode, NULL);
>> +		     iter != fwnode;
>> +		     iter = fwnode_get_next_child_node(port_fwnode, iter))
>> +			endpoint->id++;
>> +	} else {
>> +		fwnode_property_read_u32(port_fwnode, "reg", &endpoint->port);
>> +		fwnode_property_read_u32(fwnode, "reg", &endpoint->id);
>> +	}
>> +
>> +	fwnode_handle_put(port_fwnode);
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL(fwnode_graph_parse_endpoint);
>> diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
>> index 8bd28ce..cb60f29 100644
>> --- a/include/linux/fwnode.h
>> +++ b/include/linux/fwnode.h
>> @@ -27,4 +27,10 @@ struct fwnode_handle {
>>  	struct fwnode_handle *secondary;
>>  };
>>  
>> +struct fwnode_endpoint {
>> +	unsigned int port;
>> +	unsigned int id;
>> +	const struct fwnode_handle *local_fwnode;
>> +};
> 
> Any kerneldoc?

There was none in the original so I didn't end up adding any here
either. I'll do that now.

> 
>> +
>>  #endif
>> diff --git a/include/linux/property.h b/include/linux/property.h
>> index 0b61ea4..45ef00a 100644
>> --- a/include/linux/property.h
>> +++ b/include/linux/property.h
>> @@ -284,4 +284,7 @@ struct fwnode_handle *fwnode_graph_get_remote_port(
>>  struct fwnode_handle *fwnode_graph_get_remote_endpoint(
>>  	struct fwnode_handle *fwnode);
>>  
>> +int fwnode_graph_parse_endpoint(struct fwnode_handle *fwnode,
>> +				struct fwnode_endpoint *endpoint);
>> +
>>  #endif /* _LINUX_PROPERTY_H_ */
>>
> 
> Thanks,
> Rafael
> 


-- 
Regards,

Sakari Ailus
sakari.ailus@linux.intel.com
