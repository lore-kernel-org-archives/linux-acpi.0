From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v4 5/5] device property: Add FW type agnostic
 fwnode_graph_get_remote_node
Date: Wed, 31 May 2017 13:02:55 +0300
Message-ID: <20170531100255.GE2784@lahna.fi.intel.com>
References: <1495443202-22817-1-git-send-email-sakari.ailus@linux.intel.com>
 <1495443202-22817-6-git-send-email-sakari.ailus@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1495443202-22817-6-git-send-email-sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sudeep.holla-5wv7dgnIgG8@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, ahs3-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Mon, May 22, 2017 at 11:53:22AM +0300, Sakari Ailus wrote:
> Add fwnode_graph_get_remote_node() function which is equivalent to
> of_graph_get_remote_node() on OF.
> 
> Signed-off-by: Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> ---
>  drivers/base/property.c  | 37 +++++++++++++++++++++++++++++++++++++
>  include/linux/property.h |  2 ++
>  2 files changed, 39 insertions(+)
> 
> diff --git a/drivers/base/property.c b/drivers/base/property.c
> index f5ac4cc..b311a6f 100644
> --- a/drivers/base/property.c
> +++ b/drivers/base/property.c
> @@ -1214,6 +1214,43 @@ fwnode_graph_get_remote_endpoint(struct fwnode_handle *fwnode)
>  EXPORT_SYMBOL_GPL(fwnode_graph_get_remote_endpoint);
>  
>  /**
> + * fwnode_graph_get_remote_node - get remote parent node for given port/endpoint
> + * @fwnode: pointer to parent fwnode_handle containing graph port/endpoint
> + * @port_id: identifier of the parent port node
> + * @endpoint_id: identifier of the endpoint node
> + *
> + * Return: Remote fwnode handle associated with remote endpoint node linked
> + *	   to @node. Use fwnode_node_put() on it when done.
> + */
> +struct fwnode_handle *fwnode_graph_get_remote_node(
> +	struct fwnode_handle *fwnode, u32 port_id, u32 endpoint_id)


Write it:

struct fwnode_handle *fwnode_graph_get_remote_node(struct fwnode_handle *fwnode,
						   u32 port_id, u32 endpoint_id)

instead.

> +{
> +	struct fwnode_handle *endpoint = NULL;
> +
> +	while ((endpoint = fwnode_graph_get_next_endpoint(fwnode, endpoint))) {
> +		struct fwnode_endpoint fwnode_ep;
> +		struct fwnode_handle *remote;
> +		int ret;
> +
> +		ret = fwnode_graph_parse_endpoint(endpoint, &fwnode_ep);
> +		if (ret < 0)
> +			continue;
> +
> +		if (fwnode_ep.port != port_id || fwnode_ep.id != endpoint_id)
> +			continue;
> +
> +		remote = fwnode_graph_get_remote_port_parent(endpoint);
> +		if (!remote)
> +			return NULL;
> +
> +		return fwnode_device_is_available(remote) ? remote : NULL;
> +	}
> +
> +	return NULL;
> +}
> +EXPORT_SYMBOL_GPL(fwnode_graph_get_remote_node);
> +
> +/**
>   * fwnode_graph_parse_endpoint - parse common endpoint node properties
>   * @fwnode: pointer to endpoint fwnode_handle
>   * @endpoint: pointer to the fwnode endpoint data structure
> diff --git a/include/linux/property.h b/include/linux/property.h
> index 7be014a..b9f4838 100644
> --- a/include/linux/property.h
> +++ b/include/linux/property.h
> @@ -281,6 +281,8 @@ struct fwnode_handle *fwnode_graph_get_remote_port(
>  	struct fwnode_handle *fwnode);
>  struct fwnode_handle *fwnode_graph_get_remote_endpoint(
>  	struct fwnode_handle *fwnode);
> +struct fwnode_handle *fwnode_graph_get_remote_node(
> +	struct fwnode_handle *fwnode, u32 port, u32 endpoint);

Also here:

struct fwnode_handle *fwnode_graph_get_remote_node(struct fwnode_handle *fwnode,
						   u32 port, u32 endpoint);

Other than that, I think this is going to the right direction as now we
start to use those primitives in more generic code. Hopefully most new
functionality will be added here, and the fwnode_operations will not
grow anymore ;-)
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
