From: Eric Auger <eric.auger@linaro.org>
Subject: Re: [PATCH V5 2/6] vfio: platform: move reset call to a common
 function
Date: Mon, 23 May 2016 15:02:17 +0200
Message-ID: <5742FF59.6090108@linaro.org>
References: <1463364819-477-1-git-send-email-okaya@codeaurora.org>
 <1463364819-477-3-git-send-email-okaya@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:35592 "EHLO
	mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753041AbcEWNDu (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 23 May 2016 09:03:50 -0400
Received: by mail-wm0-f44.google.com with SMTP id a136so21305857wme.0
        for <linux-acpi@vger.kernel.org>; Mon, 23 May 2016 06:03:49 -0700 (PDT)
In-Reply-To: <1463364819-477-3-git-send-email-okaya@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sinan Kaya <okaya@codeaurora.org>, kvm@vger.kernel.org, timur@codeaurora.org, cov@codeaurora.org, jcm@redhat.com
Cc: linux-acpi@vger.kernel.org, agross@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Baptiste Reynal <b.reynal@virtualopensystems.com>, Alex Williamson <alex.williamson@redhat.com>, linux-kernel@vger.kernel.org

Hi Sinan,
On 05/16/2016 04:13 AM, Sinan Kaya wrote:
> The reset call sequence seems to replicate itself multiple times
> across the file. Grouping them together for maintenance reasons.
> 
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> ---
>  drivers/vfio/platform/vfio_platform_common.c | 31 ++++++++++++++--------------
>  1 file changed, 15 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/vfio/platform/vfio_platform_common.c b/drivers/vfio/platform/vfio_platform_common.c
> index 08fd7c2..cb91dd3 100644
> --- a/drivers/vfio/platform/vfio_platform_common.c
> +++ b/drivers/vfio/platform/vfio_platform_common.c
> @@ -134,6 +134,18 @@ static void vfio_platform_regions_cleanup(struct vfio_platform_device *vdev)
>  	kfree(vdev->regions);
>  }
>  
> +static int vfio_platform_call_reset(struct vfio_platform_device *vdev)
> +{
> +	if (vdev->of_reset) {
> +		dev_info(vdev->device, "reset\n");
> +		vdev->of_reset(vdev);
> +		return 0;
you should return vdev->of_reset(vdev) to keep the existing
VFIO_DEVICE_RESET ioctl behavior

Once fixed, Reviewed-by: Eric Auger <eric.auger@linaro.org>

Besides, but this goes beyond the scope of your series, maybe we should
reconsider in the future what happens in case the reset fails on
open/release.

Best Regards

Eric
> +	}
> +
> +	dev_warn(vdev->device, "no reset function found!\n");
> +	return -EINVAL;
> +}
> +
>  static void vfio_platform_release(void *device_data)
>  {
>  	struct vfio_platform_device *vdev = device_data;
> @@ -141,12 +153,7 @@ static void vfio_platform_release(void *device_data)
>  	mutex_lock(&driver_lock);
>  
>  	if (!(--vdev->refcnt)) {
> -		if (vdev->of_reset) {
> -			dev_info(vdev->device, "reset\n");
> -			vdev->of_reset(vdev);
> -		} else {
> -			dev_warn(vdev->device, "no reset function found!\n");
> -		}
> +		vfio_platform_call_reset(vdev);
>  		vfio_platform_regions_cleanup(vdev);
>  		vfio_platform_irq_cleanup(vdev);
>  	}
> @@ -175,12 +182,7 @@ static int vfio_platform_open(void *device_data)
>  		if (ret)
>  			goto err_irq;
>  
> -		if (vdev->of_reset) {
> -			dev_info(vdev->device, "reset\n");
> -			vdev->of_reset(vdev);
> -		} else {
> -			dev_warn(vdev->device, "no reset function found!\n");
> -		}
> +		vfio_platform_call_reset(vdev);
>  	}
>  
>  	vdev->refcnt++;
> @@ -312,10 +314,7 @@ static long vfio_platform_ioctl(void *device_data,
>  		return ret;
>  
>  	} else if (cmd == VFIO_DEVICE_RESET) {
> -		if (vdev->of_reset)
> -			return vdev->of_reset(vdev);
> -		else
> -			return -EINVAL;
> +		return vfio_platform_call_reset(vdev);
>  	}
>  
>  	return -ENOTTY;
> 

