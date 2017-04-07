From: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: Re: [PATCH v2 4/8] v4l: async: Provide interoperability between OF and fwnode matching
Date: Fri, 07 Apr 2017 13:07:48 +0300
Message-ID: <4169138.83VydnvH0Q@avalon>
References: <1491484330-12040-1-git-send-email-sakari.ailus@linux.intel.com> <1491484330-12040-5-git-send-email-sakari.ailus@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1491484330-12040-5-git-send-email-sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi Sakari,

Thank you for the patch.

On Thursday 06 Apr 2017 16:12:06 Sakari Ailus wrote:
> OF and fwnode support are separated in V4L2 and individual drivers may
> implement one of them. Sub-devices do not match with a notifier
> expecting sub-devices with fwnodes, nor the other way around.

Shouldn't we instead convert all drivers to fwnode matching ? What's missing 
after the mass conversion in patch 5/8 ?

> Fix this by checking for sub-device's of_node field in fwnode match and
> fwnode field in OF match.
> 
> Signed-off-by: Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> ---
>  drivers/media/v4l2-core/v4l2-async.c | 26 +++++++++++++++++++++++---
>  include/media/v4l2-async.h           |  2 +-
>  2 files changed, 24 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/media/v4l2-core/v4l2-async.c
> b/drivers/media/v4l2-core/v4l2-async.c index 384ad5e..7f5d804 100644
> --- a/drivers/media/v4l2-core/v4l2-async.c
> +++ b/drivers/media/v4l2-core/v4l2-async.c
> @@ -14,6 +14,7 @@
>  #include <linux/list.h>
>  #include <linux/module.h>
>  #include <linux/mutex.h>
> +#include <linux/of.h>
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
>  #include <linux/types.h>
> @@ -40,15 +41,34 @@ static bool match_devname(struct v4l2_subdev *sd,
>  	return !strcmp(asd->match.device_name.name, dev_name(sd->dev));
>  }
> 
> +static bool fwnode_cmp(struct fwnode_handle *one,
> +		       struct fwnode_handle *theother)
> +{
> +	if (!one || !theother)
> +		return false;
> +
> +	if (one->type != theother->type)
> +		return false;
> +
> +	if (is_of_node(one))
> +		return !of_node_cmp(of_node_full_name(to_of_node(one)),
> +				    of_node_full_name(to_of_node(theother)));
> +	else
> +		return one == theother;
> +}
> +
>  static bool match_of(struct v4l2_subdev *sd, struct v4l2_async_subdev *asd)
> {
> -	return !of_node_cmp(of_node_full_name(sd->of_node),
> -			    of_node_full_name(asd->match.of.node));
> +	return fwnode_cmp(sd->of_node ?
> +			  of_fwnode_handle(sd->of_node) : sd->fwnode,
> +			  of_fwnode_handle(asd->match.of.node));
>  }
> 
>  static bool match_fwnode(struct v4l2_subdev *sd, struct v4l2_async_subdev
> *asd)
>  {
> -	return sd->fwnode == asd->match.fwnode.fwn;
> +	return fwnode_cmp(sd->of_node ?
> +			  of_fwnode_handle(sd->of_node) : sd->fwnode,
> +					   asd->match.fwnode.fwn);
>  }
> 
>  static bool match_custom(struct v4l2_subdev *sd, struct v4l2_async_subdev
> *asd) diff --git a/include/media/v4l2-async.h b/include/media/v4l2-async.h
> index 8f552d2..df8b682 100644
> --- a/include/media/v4l2-async.h
> +++ b/include/media/v4l2-async.h
> @@ -57,7 +57,7 @@ struct v4l2_async_subdev {
>  	enum v4l2_async_match_type match_type;
>  	union {
>  		struct {
> -			const struct device_node *node;
> +			struct device_node *node;

That seems to be a bit of a hack :-( I'd rather make everything const and cast 
to non-const pointers explicitly where the API requires us to. Or, better, add 
a to_of_node_const() function.

>  		} of;
>  		struct {
>  			struct fwnode_handle *fwn;

-- 
Regards,

Laurent Pinchart

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
