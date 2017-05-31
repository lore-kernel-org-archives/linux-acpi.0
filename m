From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v5 2/6] device property: Move FW type specific
 functionality to FW specific files
Date: Wed, 31 May 2017 15:19:11 +0300
Message-ID: <20170531121911.GG2784@lahna.fi.intel.com>
References: <1496231532-23601-1-git-send-email-sakari.ailus@linux.intel.com>
 <1496231532-23601-3-git-send-email-sakari.ailus@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1496231532-23601-3-git-send-email-sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sudeep.holla-5wv7dgnIgG8@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, ahs3-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, kieran.bingham-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Wed, May 31, 2017 at 02:52:08PM +0300, Sakari Ailus wrote:
> +static int fwnode_property_read_int_array(
> +	struct fwnode_handle *fwnode, const char *propname,
> +	unsigned int elem_size, void *val, size_t nval)

You forgot this one :)

> +{
> +	int ret;
> +
> +	ret = fwnode_call_int_op(fwnode, property_read_int_array, propname,
> +				 elem_size, val, nval);
> +	if (ret == -EINVAL && !IS_ERR_OR_NULL(fwnode) &&
> +	    !IS_ERR_OR_NULL(fwnode->secondary))
> +		ret = fwnode_call_int_op(
> +			fwnode->secondary, property_read_int_array, propname,
> +			elem_size, val, nval);
> +
> +	return ret;
> +}

[...]

> +/**
> + * struct fwnode_operations - Operations for fwnode interface
> + * @get: Get a reference to an fwnode.
> + * @put: Put a reference to an fwnode.
> + * @property_present: Return true if a property is present.
> + * @property_read_integer_array: Read an array of integer properties. Return
> + *				 zero on success, a negative error code
> + *				 otherwise.
> + * @property_read_string_array: Read an array of string properties. Return zero
> + *				on success, a negative error code otherwise.
> + * @get_parent: Return the parent of an fwnode.
> + * @get_next_child_node: Return the next child node in an iteration.
> + * @get_named_child_node: Return a child node with a given name.
> + */
> +struct fwnode_operations {
> +	void (*get)(struct fwnode_handle *fwnode);
> +	void (*put)(struct fwnode_handle *fwnode);
> +	bool (*property_present)(struct fwnode_handle *fwnode,
> +				 const char *propname);
> +	int (*property_read_int_array)(struct fwnode_handle *fwnode,
> +				       const char *propname,
> +				       unsigned int elem_size, void *val,
> +				       size_t nval);
> +	int (*property_read_string_array)(struct fwnode_handle *fwnode_handle,
> +					  const char *propname,
> +					  const char **val, size_t nval);
> +	struct fwnode_handle *(*get_parent)(struct fwnode_handle *fwnode);
> +	struct fwnode_handle *
> +	(*get_next_child_node)(struct fwnode_handle *fwnode,
> +			       struct fwnode_handle *child);

I would do the following instead

	struct fwnode_handle *(*get_next_child_node)(struct fwnode_handle *fwnode,
						     struct fwnode_handle *child);
	struct fwnode_handle *(*get_named_child_node)(struct fwnode_handle *fwnode,
						      const char *name);

Yes, it is over 80 chars but it is more readable this way.

Just saying :) I'll leave this up to you.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
