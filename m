From: Niklas =?iso-8859-1?Q?S=F6derlund?=
        <niklas.soderlund-1zkq55x86MTxsAP9Fp7wbw@public.gmane.org>
Subject: Re: [PATCH v16 05/32] v4l: async: Correctly serialise async
 sub-device unregistration
Date: Thu, 26 Oct 2017 17:38:03 +0200
Message-ID: <20171026153803.GD2297@bigcity.dyn.berto.se>
References: <20171026075342.5760-1-sakari.ailus@linux.intel.com>
 <20171026075342.5760-6-sakari.ailus@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20171026075342.5760-6-sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, hverkuil-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org, laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, pavel-+ZI9xUNit7I@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On 2017-10-26 10:53:15 +0300, Sakari Ailus wrote:
> The check whether an async sub-device is bound to a notifier was performed
> without list_lock held, making it possible for another process to
> unbind the async sub-device before the sub-device unregistration function
> proceeds to take the lock.
> 
> Fix this by first acquiring the lock and then proceeding with the check.
> 
> Signed-off-by: Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> Reviewed-by: Sebastian Reichel <sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
> Acked-by: Hans Verkuil <hans.verkuil-FYB4Gu1CFyUAvxtiuMwx3w@public.gmane.org>

Acked-by: Niklas Söderlund <niklas.soderlund+renesas-1zkq55x86MTxsAP9Fp7wbw@public.gmane.org>

> ---
>  drivers/media/v4l2-core/v4l2-async.c | 18 +++++++-----------
>  1 file changed, 7 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/media/v4l2-core/v4l2-async.c b/drivers/media/v4l2-core/v4l2-async.c
> index 4924481451ca..cde2cf2ab4b0 100644
> --- a/drivers/media/v4l2-core/v4l2-async.c
> +++ b/drivers/media/v4l2-core/v4l2-async.c
> @@ -298,20 +298,16 @@ EXPORT_SYMBOL(v4l2_async_register_subdev);
>  
>  void v4l2_async_unregister_subdev(struct v4l2_subdev *sd)
>  {
> -	struct v4l2_async_notifier *notifier = sd->notifier;
> -
> -	if (!sd->asd) {
> -		if (!list_empty(&sd->async_list))
> -			v4l2_async_cleanup(sd);
> -		return;
> -	}
> -
>  	mutex_lock(&list_lock);
>  
> -	list_add(&sd->asd->list, &notifier->waiting);
> +	if (sd->asd) {
> +		struct v4l2_async_notifier *notifier = sd->notifier;
>  
> -	if (notifier->unbind)
> -		notifier->unbind(notifier, sd, sd->asd);
> +		list_add(&sd->asd->list, &notifier->waiting);
> +
> +		if (notifier->unbind)
> +			notifier->unbind(notifier, sd, sd->asd);
> +	}
>  
>  	v4l2_async_cleanup(sd);
>  
> -- 
> 2.11.0
> 

-- 
Regards,
Niklas Söderlund
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
