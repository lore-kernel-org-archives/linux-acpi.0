From: Sakari Ailus <sakari.ailus-X3B1VOXEql0@public.gmane.org>
Subject: Re: [PATCH v5.1 11/13] of: Add nop implementation of
 of_get_next_parent()
Date: Fri, 24 Mar 2017 11:28:15 +0200
Message-ID: <20170324092814.GS10701@valkosipuli.retiisi.org.uk>
References: <1489667481-28521-12-git-send-email-sakari.ailus@linux.intel.com>
 <1489752538-23543-1-git-send-email-sakari.ailus@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1489752538-23543-1-git-send-email-sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sudeep.holla-5wv7dgnIgG8@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, ahs3-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Fri, Mar 17, 2017 at 02:08:58PM +0200, Sakari Ailus wrote:
> of_get_next_parent() was only defined if CONFIG_OF was set. Using the
> function thus requires #ifdef CONFIG_OF ... #endif in all cases. Avoid
> having to use pre-processor macros around the function by providing a nop
> implementation of of_get_next_parent().
> 
> Signed-off-by: Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>

As a result of the changes in v5.1 in the patch 12/13 ("device property: Add
fwnode_get_next_parent()") of this set, this patch is no longer needed. If
there are no objections, I'll drop it from the set.

> ---
> since v5:
> 
> - Improved commit message.
> 
>  include/linux/of.h | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/include/linux/of.h b/include/linux/of.h
> index e5d4225f..cc212a0 100644
> --- a/include/linux/of.h
> +++ b/include/linux/of.h
> @@ -586,6 +586,12 @@ static inline struct device_node *of_get_parent(const struct device_node *node)
>  	return NULL;
>  }
>  
> +static inline struct device_node *of_get_next_parent(
> +	const struct device_node *node)
> +{
> +	return NULL;
> +}
> +
>  static inline struct device_node *of_get_next_child(
>  	const struct device_node *node, struct device_node *prev)
>  {

-- 
Sakari Ailus
e-mail: sakari.ailus-X3B1VOXEql0@public.gmane.org	XMPP: sailus-PCDdDYkjdNMDXYZnReoRVg@public.gmane.org
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
