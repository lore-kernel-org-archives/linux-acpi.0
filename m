From: Hans Verkuil <hverkuil-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org>
Subject: Re: [PATCH v10 22/24] ov5670: Add support for flash and lens devices
Date: Mon, 11 Sep 2017 11:49:14 +0200
Message-ID: <ac06b8c5-45d9-a441-85ca-8ef6efc19b7a@xs4all.nl>
References: <20170911080008.21208-1-sakari.ailus@linux.intel.com>
 <20170911080008.21208-23-sakari.ailus@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170911080008.21208-23-sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: niklas.soderlund-1zkq55x86MTxsAP9Fp7wbw@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mika.westerberg-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, pavel-+ZI9xUNit7I@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On 09/11/2017 10:00 AM, Sakari Ailus wrote:
> Parse async sub-devices by using
> v4l2_subdev_fwnode_reference_parse_sensor_common().
> 
> Signed-off-by: Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>

Acked-by: Hans Verkuil <hans.verkuil-FYB4Gu1CFyUAvxtiuMwx3w@public.gmane.org>

Regards,

	Hans


> ---
>  drivers/media/i2c/ov5670.c | 33 +++++++++++++++++++++++++--------
>  1 file changed, 25 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/media/i2c/ov5670.c b/drivers/media/i2c/ov5670.c
> index 6f7a1d6d2200..25970307dd75 100644
> --- a/drivers/media/i2c/ov5670.c
> +++ b/drivers/media/i2c/ov5670.c
> @@ -18,6 +18,7 @@
>  #include <linux/pm_runtime.h>
>  #include <media/v4l2-ctrls.h>
>  #include <media/v4l2-device.h>
> +#include <media/v4l2-fwnode.h>
>  
>  #define OV5670_REG_CHIP_ID		0x300a
>  #define OV5670_CHIP_ID			0x005670
> @@ -1807,6 +1808,7 @@ static const struct ov5670_mode supported_modes[] = {
>  struct ov5670 {
>  	struct v4l2_subdev sd;
>  	struct media_pad pad;
> +	struct v4l2_async_notifier notifier;
>  
>  	struct v4l2_ctrl_handler ctrl_handler;
>  	/* V4L2 Controls */
> @@ -2473,11 +2475,13 @@ static int ov5670_probe(struct i2c_client *client)
>  		return -EINVAL;
>  
>  	ov5670 = devm_kzalloc(&client->dev, sizeof(*ov5670), GFP_KERNEL);
> -	if (!ov5670) {
> -		ret = -ENOMEM;
> -		err_msg = "devm_kzalloc() error";
> -		goto error_print;
> -	}
> +	if (!ov5670)
> +		return -ENOMEM;
> +
> +	ret = v4l2_fwnode_reference_parse_sensor_common(
> +		&client->dev, &ov5670->notifier);
> +	if (ret < 0)
> +		return ret;
>  
>  	/* Initialize subdev */
>  	v4l2_i2c_subdev_init(&ov5670->sd, client, &ov5670_subdev_ops);
> @@ -2486,7 +2490,7 @@ static int ov5670_probe(struct i2c_client *client)
>  	ret = ov5670_identify_module(ov5670);
>  	if (ret) {
>  		err_msg = "ov5670_identify_module() error";
> -		goto error_print;
> +		goto error_release_notifier;
>  	}
>  
>  	mutex_init(&ov5670->mutex);
> @@ -2513,11 +2517,18 @@ static int ov5670_probe(struct i2c_client *client)
>  		goto error_handler_free;
>  	}
>  
> +	ret = v4l2_async_subdev_notifier_register(&ov5670->sd,
> +						  &ov5670->notifier);
> +	if (ret) {
> +		err_msg = "can't register async notifier";
> +		goto error_entity_cleanup;
> +	}
> +
>  	/* Async register for subdev */
>  	ret = v4l2_async_register_subdev(&ov5670->sd);
>  	if (ret < 0) {
>  		err_msg = "v4l2_async_register_subdev() error";
> -		goto error_entity_cleanup;
> +		goto error_unregister_notifier;
>  	}
>  
>  	ov5670->streaming = false;
> @@ -2533,6 +2544,9 @@ static int ov5670_probe(struct i2c_client *client)
>  
>  	return 0;
>  
> +error_unregister_notifier:
> +	v4l2_async_notifier_unregister(&ov5670->notifier);
> +
>  error_entity_cleanup:
>  	media_entity_cleanup(&ov5670->sd.entity);
>  
> @@ -2542,7 +2556,8 @@ static int ov5670_probe(struct i2c_client *client)
>  error_mutex_destroy:
>  	mutex_destroy(&ov5670->mutex);
>  
> -error_print:
> +error_release_notifier:
> +	v4l2_async_notifier_release(&ov5670->notifier);
>  	dev_err(&client->dev, "%s: %s %d\n", __func__, err_msg, ret);
>  
>  	return ret;
> @@ -2554,6 +2569,8 @@ static int ov5670_remove(struct i2c_client *client)
>  	struct ov5670 *ov5670 = to_ov5670(sd);
>  
>  	v4l2_async_unregister_subdev(sd);
> +	v4l2_async_notifier_unregister(&ov5670->notifier);
> +	v4l2_async_notifier_release(&ov5670->notifier);
>  	media_entity_cleanup(&sd->entity);
>  	v4l2_ctrl_handler_free(sd->ctrl_handler);
>  	mutex_destroy(&ov5670->mutex);
> 

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
