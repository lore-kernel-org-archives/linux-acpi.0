From: Sakari Ailus <sakari.ailus-X3B1VOXEql0@public.gmane.org>
Subject: Re: [PATCH v2 1/8] v4l: flash led class: Use fwnode_handle instead
 of device_node in init
Date: Fri, 7 Apr 2017 13:20:38 +0300
Message-ID: <20170407102038.GC4192@valkosipuli.retiisi.org.uk>
References: <1491484330-12040-1-git-send-email-sakari.ailus@linux.intel.com>
 <1491484330-12040-2-git-send-email-sakari.ailus@linux.intel.com>
 <3129720.GhXEqohgpp@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <3129720.GhXEqohgpp@avalon>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi Laurent,

Thank you for the review!

On Fri, Apr 07, 2017 at 11:49:56AM +0300, Laurent Pinchart wrote:
> Hi Sakari,
> 
> Thank you for the patch.
> 
> On Thursday 06 Apr 2017 16:12:03 Sakari Ailus wrote:
> > Pass the more generic fwnode_handle to the init function than the
> > device_node.
> > 
> > Signed-off-by: Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> > ---
> >  drivers/leds/leds-aat1290.c                    |  5 +++--
> >  drivers/leds/leds-max77693.c                   |  5 +++--
> >  drivers/media/v4l2-core/v4l2-flash-led-class.c | 11 ++++++-----
> >  include/media/v4l2-flash-led-class.h           |  4 ++--
> >  4 files changed, 14 insertions(+), 11 deletions(-)
> > 
> > diff --git a/drivers/leds/leds-aat1290.c b/drivers/leds/leds-aat1290.c
> > index def3cf9..a21e192 100644
> > --- a/drivers/leds/leds-aat1290.c
> > +++ b/drivers/leds/leds-aat1290.c
> > @@ -503,8 +503,9 @@ static int aat1290_led_probe(struct platform_device
> > *pdev) aat1290_init_v4l2_flash_config(led, &led_cfg, &v4l2_sd_cfg);
> > 
> >  	/* Create V4L2 Flash subdev. */
> > -	led->v4l2_flash = v4l2_flash_init(dev, sub_node, fled_cdev, NULL,
> > -					  &v4l2_flash_ops, &v4l2_sd_cfg);
> > +	led->v4l2_flash = v4l2_flash_init(dev, of_fwnode_handle(sub_node),
> > +					  fled_cdev, NULL, &v4l2_flash_ops,
> > +					  &v4l2_sd_cfg);
> >  	if (IS_ERR(led->v4l2_flash)) {
> >  		ret = PTR_ERR(led->v4l2_flash);
> >  		goto error_v4l2_flash_init;
> > diff --git a/drivers/leds/leds-max77693.c b/drivers/leds/leds-max77693.c
> > index 1eb58ef..2d3062d 100644
> > --- a/drivers/leds/leds-max77693.c
> > +++ b/drivers/leds/leds-max77693.c
> > @@ -930,8 +930,9 @@ static int max77693_register_led(struct max77693_sub_led
> > *sub_led, max77693_init_v4l2_flash_config(sub_led, led_cfg, &v4l2_sd_cfg);
> > 
> >  	/* Register in the V4L2 subsystem. */
> > -	sub_led->v4l2_flash = v4l2_flash_init(dev, sub_node, fled_cdev, NULL,
> > -					      &v4l2_flash_ops, &v4l2_sd_cfg);
> > +	sub_led->v4l2_flash = v4l2_flash_init(dev, of_fwnode_handle(sub_node),
> > +					      fled_cdev, NULL, 
> &v4l2_flash_ops,
> > +					      &v4l2_sd_cfg);
> >  	if (IS_ERR(sub_led->v4l2_flash)) {
> >  		ret = PTR_ERR(sub_led->v4l2_flash);
> >  		goto err_v4l2_flash_init;
> > diff --git a/drivers/media/v4l2-core/v4l2-flash-led-class.c
> > b/drivers/media/v4l2-core/v4l2-flash-led-class.c index 794e563..f430c89
> > 100644
> > --- a/drivers/media/v4l2-core/v4l2-flash-led-class.c
> > +++ b/drivers/media/v4l2-core/v4l2-flash-led-class.c
> > @@ -13,6 +13,7 @@
> >  #include <linux/module.h>
> >  #include <linux/mutex.h>
> >  #include <linux/of.h>
> 
> I think you can drop linux/of.h.

Correct. Will fix.

> 
> > +#include <linux/property.h>
> >  #include <linux/slab.h>
> >  #include <linux/types.h>
> >  #include <media/v4l2-flash-led-class.h>
> > @@ -612,7 +613,7 @@ static const struct v4l2_subdev_internal_ops
> > v4l2_flash_subdev_internal_ops = { static const struct v4l2_subdev_ops
> > v4l2_flash_subdev_ops;
> > 
> >  struct v4l2_flash *v4l2_flash_init(
> > -	struct device *dev, struct device_node *of_node,
> > +	struct device *dev, struct fwnode_handle *fwn,
> >  	struct led_classdev_flash *fled_cdev,
> >  	struct led_classdev_flash *iled_cdev,
> >  	const struct v4l2_flash_ops *ops,
> > @@ -638,7 +639,7 @@ struct v4l2_flash *v4l2_flash_init(
> >  	v4l2_flash->iled_cdev = iled_cdev;
> >  	v4l2_flash->ops = ops;
> >  	sd->dev = dev;
> > -	sd->of_node = of_node ? of_node : led_cdev->dev->of_node;
> > +	sd->fwnode = fwn ? fwn : dev_fwnode(led_cdev->dev);
> 
> v4l2_subdev will only have a fwnode field in patch 3/8.

I think I've rearranged the set after writing the patch and missed the
dependency. I'll move it third unless there are other dependencies.

-- 
Kind regards,

Sakari Ailus
e-mail: sakari.ailus-X3B1VOXEql0@public.gmane.org	XMPP: sailus-PCDdDYkjdNMDXYZnReoRVg@public.gmane.org
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
