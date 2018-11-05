From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 1/4] device property: Introduce fwnode_name()
Date: Mon, 5 Nov 2018 16:37:31 +0200
Message-ID: <20181105143731.GK10650@smile.fi.intel.com>
References: <20181105091727.25544-1-heikki.krogerus@linux.intel.com>
 <20181105091727.25544-2-heikki.krogerus@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181105091727.25544-2-heikki.krogerus@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Mon, Nov 05, 2018 at 12:17:24PM +0300, Heikki Krogerus wrote:
> This helper returns the name of the node. The name is
> primarily expected to be returned from a new fwnode
> operation meant for this purpose, but when no name is
> returned, the helper will also attempt to read a device
> property "name".
> 
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> ---
>  drivers/base/property.c  | 18 ++++++++++++++++++
>  include/linux/fwnode.h   |  1 +
>  include/linux/property.h |  2 ++
>  3 files changed, 21 insertions(+)
> 
> diff --git a/drivers/base/property.c b/drivers/base/property.c
> index 240ab5230ff6..1e4eb7ab2b84 100644
> --- a/drivers/base/property.c
> +++ b/drivers/base/property.c
> @@ -1156,6 +1156,24 @@ void fwnode_handle_put(struct fwnode_handle *fwnode)
>  }
>  EXPORT_SYMBOL_GPL(fwnode_handle_put);
>  
> +/**
> + * fwnode_name - Get the name of a device node
> + * @fwnode: Pointer to the device node.
> + *
> + * Returns the node name of @fwnode. If @fwnode does not have a "unit name",
> + * this code will also attempt to read a string property named "name".
> + */
> +const char *fwnode_name(const struct fwnode_handle *fwnode)
> +{
> +	const char *name = fwnode_call_ptr_op(fwnode, name);
> +
> +	if (!name)
> +		fwnode_call_int_op(fwnode, property_read_string_array,
> +				   "name", &name, 1);

Is it going to be extended in the future?

Otherwise I would rather go with (few more LOCs, yes)

	const char *name;

	name = fwnode_call_ptr_op(fwnode, name);
	if (name)
		return name;

	fwnode_call_int_op(fwnode, property_read_string_array, "name", &name, 1);
	return name;

> +	return name;
> +}
> +EXPORT_SYMBOL_GPL(fwnode_name);
> +
>  /**
>   * fwnode_device_is_available - check if a device is available for use
>   * @fwnode: Pointer to the fwnode of the device.
> diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
> index faebf0ca0686..2e445fed4df4 100644
> --- a/include/linux/fwnode.h
> +++ b/include/linux/fwnode.h
> @@ -72,6 +72,7 @@ struct fwnode_reference_args {
>  struct fwnode_operations {
>  	struct fwnode_handle *(*get)(struct fwnode_handle *fwnode);
>  	void (*put)(struct fwnode_handle *fwnode);
> +	const char *(*name)(const struct fwnode_handle *fwnode);
>  	bool (*device_is_available)(const struct fwnode_handle *fwnode);
>  	const void *(*device_get_match_data)(const struct fwnode_handle *fwnode,
>  					     const struct device *dev);
> diff --git a/include/linux/property.h b/include/linux/property.h
> index ac8a1ebc4c1b..44781d37dd96 100644
> --- a/include/linux/property.h
> +++ b/include/linux/property.h
> @@ -109,6 +109,8 @@ struct fwnode_handle *device_get_named_child_node(struct device *dev,
>  struct fwnode_handle *fwnode_handle_get(struct fwnode_handle *fwnode);
>  void fwnode_handle_put(struct fwnode_handle *fwnode);
>  
> +const char *fwnode_name(const struct fwnode_handle *fwnode);
> +
>  int fwnode_irq_get(struct fwnode_handle *fwnode, unsigned int index);
>  
>  unsigned int device_get_child_node_count(struct device *dev);
> -- 
> 2.19.1
> 

-- 
With Best Regards,
Andy Shevchenko
