From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH 2/3] device property: Move fwnode graph ops to firmware
 specific locations
Date: Mon, 27 Mar 2017 14:52:00 +0300
Message-ID: <20170327115200.GB2957@lahna.fi.intel.com>
References: <1490353432-12017-1-git-send-email-sakari.ailus@linux.intel.com>
 <1490353432-12017-2-git-send-email-sakari.ailus@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1490353432-12017-2-git-send-email-sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, sudeep.holla-5wv7dgnIgG8@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, ahs3-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Fri, Mar 24, 2017 at 01:03:51PM +0200, Sakari Ailus wrote:
>  const struct fwnode_operations acpi_fwnode_ops = {
>  	.property_present = acpi_fwnode_property_present,
>  	.property_read_int_array = acpi_fwnode_property_read_int_array,
> @@ -1193,4 +1248,9 @@ const struct fwnode_operations acpi_fwnode_ops = {
>  	.get_parent = acpi_fwnode_get_parent,
>  	.get_next_child_node = acpi_get_next_subnode,
>  	.get_named_child_node = acpi_fwnode_get_named_child_node,
> +	.graph_get_next_endpoint = acpi_fwnode_graph_get_next_endpoint,
> +	.graph_get_remote_endpoint = acpi_fwnode_graph_get_remote_endpoint,
> +	.graph_get_remote_port = acpi_fwnode_graph_get_remote_port,
> +	.graph_get_remote_port_parent = acpi_fwnode_graph_get_remote_port_parent,
> +	.graph_parse_endpoint = acpi_fwnode_graph_parse_endpoint,
>  };

Not sure if it is possible but it would be nice to have a single
primitive implementation specific graph callback and then build
everything else on top of that in generic code. Here you have 5
callbacks just for graph support.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
