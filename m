From: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: Re: [PATCH v2 6/8] v4l: media/drv-intf/soc_mediabus.h: include dependent header file
Date: Fri, 07 Apr 2017 13:01:29 +0300
Message-ID: <2155093.Y2052RbRLf@avalon>
References: <1491484330-12040-1-git-send-email-sakari.ailus@linux.intel.com> <1491484330-12040-7-git-send-email-sakari.ailus@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1491484330-12040-7-git-send-email-sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi Sakari,

Thank you for the patch.

On Thursday 06 Apr 2017 16:12:08 Sakari Ailus wrote:
> media/drv-intf/soc_mediabus.h does depend on struct v4l2_mbus_config which
> is defined in media/v4l2-mediabus.h. Include it.
> 
> Signed-off-by: Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>

Was this provided indirectly before, through v4l2-of.h perhaps ? If so, 
shouldn't this patch be moved before 5/8 ? Apart from that,

Reviewed-by: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>

> ---
>  include/media/drv-intf/soc_mediabus.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/media/drv-intf/soc_mediabus.h
> b/include/media/drv-intf/soc_mediabus.h index 2ff7737..0449788 100644
> --- a/include/media/drv-intf/soc_mediabus.h
> +++ b/include/media/drv-intf/soc_mediabus.h
> @@ -14,6 +14,8 @@
>  #include <linux/videodev2.h>
>  #include <linux/v4l2-mediabus.h>
> 
> +#include <media/v4l2-mediabus.h>
> +
>  /**
>   * enum soc_mbus_packing - data packing types on the media-bus
>   * @SOC_MBUS_PACKING_NONE:	no packing, bit-for-bit transfer to RAM, one

-- 
Regards,

Laurent Pinchart

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
