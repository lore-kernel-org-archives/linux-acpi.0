From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] software node: Implement get_named_child_node fwnode callback
Date: Tue, 19 Feb 2019 11:00:17 +0100
Message-ID: <1695920.3PekvGoq6c@aspire.rjw.lan>
References: <20190213115549.81917-1-heikki.krogerus@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190213115549.81917-1-heikki.krogerus@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Wednesday, February 13, 2019 12:55:49 PM CET Heikki Krogerus wrote:
> This makes it possible to support drivers that use
> fwnode_get_named_child_node() and device_get_named_child_node()
> functions.
> 
> The node name is for now taken from a device property named
> "name". That mimics the old style of naming of the nodes in
> devicetree (though with modern flattened DT, the name is
> matched against the actual node-name, it used to be done
> with a property "name"). In Open Firmware DT the "name"
> property is also still being used.
> 
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> ---
>  drivers/base/swnode.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
> index 89ad8dee6ad5..1fad9291f6aa 100644
> --- a/drivers/base/swnode.c
> +++ b/drivers/base/swnode.c
> @@ -499,6 +499,28 @@ software_node_get_next_child(const struct fwnode_handle *fwnode,
>  	return &c->fwnode;
>  }
>  
> +static struct fwnode_handle *
> +software_node_get_named_child_node(const struct fwnode_handle *fwnode,
> +				   const char *childname)
> +{
> +	struct software_node *swnode = to_software_node(fwnode);
> +	const struct property_entry *prop;
> +	struct software_node *child;
> +
> +	if (!swnode || list_empty(&swnode->children))
> +		return NULL;
> +
> +	list_for_each_entry(child, &swnode->children, entry) {
> +		prop = property_entry_get(child->properties, "name");
> +		if (!prop)
> +			continue;
> +		if (!strcmp(childname, prop->value.str)) {
> +			kobject_get(&child->kobj);
> +			return &child->fwnode;
> +		}
> +	}
> +	return NULL;
> +}
>  
>  static const struct fwnode_operations software_node_ops = {
>  	.get = software_node_get,
> @@ -508,6 +530,7 @@ static const struct fwnode_operations software_node_ops = {
>  	.property_read_string_array = software_node_read_string_array,
>  	.get_parent = software_node_get_parent,
>  	.get_next_child_node = software_node_get_next_child,
> +	.get_named_child_node = software_node_get_named_child_node,
>  };
>  
>  /* -------------------------------------------------------------------------- */
> 

Applied, thanks!
