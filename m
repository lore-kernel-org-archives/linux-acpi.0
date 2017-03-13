From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v4 13/16] device property: Add support for fwnode endpoints
Date: Mon, 13 Mar 2017 22:52:03 +0100
Message-ID: <1907784.opL26JLB0u@aspire.rjw.lan>
References: <1488809970-25568-1-git-send-email-sakari.ailus@linux.intel.com> <1488809970-25568-14-git-send-email-sakari.ailus@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:53305 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752469AbdCMV52 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 13 Mar 2017 17:57:28 -0400
In-Reply-To: <1488809970-25568-14-git-send-email-sakari.ailus@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, devicetree@vger.kernel.org, sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, mika.westerberg@linux.intel.com, rafael@kernel.org, mark.rutland@arm.com, broonie@kernel.org, robh@kernel.org, ahs3@redhat.com

On Monday, March 06, 2017 04:19:27 PM Sakari Ailus wrote:
> Similar to OF endpoints, endpoint type nodes can be also supported on
> ACPI. In order to make it possible for drivers to ignore the matter,
> add a type for fwnode_endpoint and a function to parse them.
> 
> On ACPI, find the child node index instead of relying on the "endpoint"
> property.
> 
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> ---
>  drivers/base/property.c  | 36 ++++++++++++++++++++++++++++++++++++
>  include/linux/fwnode.h   |  6 ++++++
>  include/linux/property.h |  3 +++
>  3 files changed, 45 insertions(+)
> 
> diff --git a/drivers/base/property.c b/drivers/base/property.c
> index 860e160..b8c1017 100644
> --- a/drivers/base/property.c
> +++ b/drivers/base/property.c
> @@ -1330,3 +1330,39 @@ fwnode_graph_get_remote_endpoint(struct fwnode_handle *fwnode)
>  	return endpoint;
>  }
>  EXPORT_SYMBOL_GPL(fwnode_graph_get_remote_endpoint);
> +
> +/*

That should be /** I gather?

> + * fwnode_graph_parse_endpoint() - parse common endpoint node properties

The parens at the end of the function name above are not necessary.

> + * @node: pointer to endpoint device_node
> + * @endpoint: pointer to the fwnode endpoint data structure
> + *
> + * The caller should hold a reference to @node.

A few words about what the function does, please.

> + */
> +int fwnode_graph_parse_endpoint(struct fwnode_handle *fwnode,
> +				struct fwnode_endpoint *endpoint)
> +{
> +	struct fwnode_handle *port_fwnode = fwnode_get_parent(fwnode);
> +
> +	memset(endpoint, 0, sizeof(*endpoint));
> +
> +	endpoint->local_fwnode = fwnode;
> +
> +	if (is_acpi_node(port_fwnode)) {
> +		struct fwnode_handle *iter;
> +
> +		fwnode_property_read_u32(port_fwnode, "port", &endpoint->port);
> +
> +		for (iter = fwnode_get_next_child_node(port_fwnode, NULL);
> +		     iter != fwnode;
> +		     iter = fwnode_get_next_child_node(port_fwnode, iter))
> +			endpoint->id++;
> +	} else {
> +		fwnode_property_read_u32(port_fwnode, "reg", &endpoint->port);
> +		fwnode_property_read_u32(fwnode, "reg", &endpoint->id);
> +	}
> +
> +	fwnode_handle_put(port_fwnode);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(fwnode_graph_parse_endpoint);
> diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
> index 8bd28ce..cb60f29 100644
> --- a/include/linux/fwnode.h
> +++ b/include/linux/fwnode.h
> @@ -27,4 +27,10 @@ struct fwnode_handle {
>  	struct fwnode_handle *secondary;
>  };
>  
> +struct fwnode_endpoint {
> +	unsigned int port;
> +	unsigned int id;
> +	const struct fwnode_handle *local_fwnode;
> +};

Any kerneldoc?

> +
>  #endif
> diff --git a/include/linux/property.h b/include/linux/property.h
> index 0b61ea4..45ef00a 100644
> --- a/include/linux/property.h
> +++ b/include/linux/property.h
> @@ -284,4 +284,7 @@ struct fwnode_handle *fwnode_graph_get_remote_port(
>  struct fwnode_handle *fwnode_graph_get_remote_endpoint(
>  	struct fwnode_handle *fwnode);
>  
> +int fwnode_graph_parse_endpoint(struct fwnode_handle *fwnode,
> +				struct fwnode_endpoint *endpoint);
> +
>  #endif /* _LINUX_PROPERTY_H_ */
> 

Thanks,
Rafael

