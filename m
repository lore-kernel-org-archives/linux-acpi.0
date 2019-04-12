From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/3] device property: Add fwnode_is_compatible() and device_is_compatible() helpers
Date: Fri, 12 Apr 2019 10:13:11 +0200
Message-ID: <2845758.HqtfGXT4y5@aspire.rjw.lan>
References: <20190327164339.31205-1-heikki.krogerus@linux.intel.com> <20190327164339.31205-2-heikki.krogerus@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190327164339.31205-2-heikki.krogerus@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andy Shevchenko <andy.shevchenko@gmail.com>, Chunfeng Yun <chunfeng.yun@mediatek.com>, Biju Das <biju.das@bp.renesas.com>, Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Wednesday, March 27, 2019 5:43:37 PM CEST Heikki Krogerus wrote:
> Since there are also some ACPI platforms where the
> "compatible" property is used, introducing a generic helper
> function fwnode_is_compatible() that can be used with
> DT, ACPI and swnodes, and a wrapper function
> device_is_compatible() with it.
> 
> The function calls of_device_is_comaptible() with OF nodes,
> and with ACPI and swnodes it matches the given string
> against the "compatible" string property array.
> 
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> ---
>  drivers/base/property.c  | 35 +++++++++++++++++++++++++++++++++++
>  include/linux/property.h |  3 +++
>  2 files changed, 38 insertions(+)
> 
> diff --git a/drivers/base/property.c b/drivers/base/property.c
> index 8b91ab380d14..af9f5aac5d02 100644
> --- a/drivers/base/property.c
> +++ b/drivers/base/property.c
> @@ -1006,3 +1006,38 @@ const void *device_get_match_data(struct device *dev)
>  	return fwnode_call_ptr_op(dev_fwnode(dev), device_get_match_data, dev);
>  }
>  EXPORT_SYMBOL_GPL(device_get_match_data);
> +
> +/**
> + * fwnode_is_compatible - Check does fwnode have the given compatible string
> + * @fwnode: fwnode with the "compatible" property
> + * @compat: The compatible string
> + *
> + * Match the compatible strings of @fwnode against @compat. Returns positive
> + * value on match, and 0 when no matching compatible string is found.
> + */
> +int fwnode_is_compatible(struct fwnode_handle *fwnode, const char *compat)
> +{
> +	int ret;
> +
> +	if (is_of_node(fwnode))
> +		return of_device_is_compatible(to_of_node(fwnode), compat);
> +
> +	ret = fwnode_property_match_string(fwnode, "compatible", compat);
> +
> +	return ret < 0 ? 0 : 1;
> +}
> +EXPORT_SYMBOL_GPL(fwnode_is_compatible);
> +
> +/**
> + * device_is_compatible - Check does a device have the given compatible string
> + * @dev: Device with the "compatible" property
> + * @compat: The compatible string
> + *
> + * Match the compatible strings of @dev against @compat. Returns positive value
> + * on match, and 0 when no matching compatible string is found.
> + */
> +int device_is_compatible(struct device *dev, const char *compat)
> +{
> +	return fwnode_is_compatible(dev_fwnode(dev), compat);
> +}
> +EXPORT_SYMBOL_GPL(device_is_compatible);
> diff --git a/include/linux/property.h b/include/linux/property.h
> index 65d3420dd5d1..d22788ec36cd 100644
> --- a/include/linux/property.h
> +++ b/include/linux/property.h
> @@ -311,6 +311,9 @@ fwnode_graph_get_remote_node(const struct fwnode_handle *fwnode, u32 port,
>  int fwnode_graph_parse_endpoint(const struct fwnode_handle *fwnode,
>  				struct fwnode_endpoint *endpoint);
>  
> +int fwnode_is_compatible(struct fwnode_handle *fwnode, const char *compat);
> +int device_is_compatible(struct device *dev, const char *compat);
> +
>  /* -------------------------------------------------------------------------- */
>  /* Software fwnode support - when HW description is incomplete or missing */
>  
> 

The new helpers would not be used anywhere for the time being, so it is better to
add them along with the first user IMO.

Please resend when this is needed.
