From: Ryan May <rmay@ou.edu>
Subject: Re: [PATCH 1/2] [PATCH] ACPI: video: Don't call absent methods
Date: Fri, 14 Sep 2007 09:01:10 -0500
Message-ID: <46EA9426.4000404@ou.edu>
References: <20070903122958.20082.6843.stgit@z61m>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from rossby.metr.ou.edu ([129.15.192.80]:2936 "EHLO
	rossby.metr.ou.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750793AbXINOBZ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 14 Sep 2007 10:01:25 -0400
Received: from [10.197.12.171] (raman.som.nor.ouint [10.197.12.171])
	by rossby.metr.ou.edu (8.12.9p2/8.12.9) with ESMTP id l8EE1FYN027094
	for <linux-acpi@vger.kernel.org>; Fri, 14 Sep 2007 09:01:15 -0500 (CDT)
	(envelope-from rmay@ou.edu)
In-Reply-To: <20070903122958.20082.6843.stgit@z61m>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

What's the status of this particular patch?

Ryan

Alexey Starikovskiy wrote:
> Signed-off-by: Ryan May <rmay@ou.edu>
> Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
> ---
> 
>  drivers/acpi/video.c |   18 ++++++++++--------
>  1 files changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
> index 3c9bb85..83aa41c 100644
> --- a/drivers/acpi/video.c
> +++ b/drivers/acpi/video.c
> @@ -409,14 +409,16 @@ acpi_video_device_lcd_query_levels(struct acpi_video_device *device,
>  static int
>  acpi_video_device_lcd_set_level(struct acpi_video_device *device, int level)
>  {
> -	int status;
> +	int status = AE_OK;
>  	union acpi_object arg0 = { ACPI_TYPE_INTEGER };
>  	struct acpi_object_list args = { 1, &arg0 };
>  
>  
>  	arg0.integer.value = level;
> -	status = acpi_evaluate_object(device->dev->handle, "_BCM", &args, NULL);
> -
> +	if (device->cap._BCM)
> +		status = acpi_evaluate_object(device->dev->handle, "_BCM",
> +					      &args, NULL);
> +	device->brightness->curr = level;
>  	printk(KERN_DEBUG "set_level status: %x\n", status);
>  	return status;
>  }
> @@ -425,11 +427,11 @@ static int
>  acpi_video_device_lcd_get_level_current(struct acpi_video_device *device,
>  					unsigned long *level)
>  {
> -	int status;
> -
> -	status = acpi_evaluate_integer(device->dev->handle, "_BQC", NULL, level);
> -
> -	return status;
> +	if (device->cap._BQC)
> +		return acpi_evaluate_integer(device->dev->handle, "_BQC", NULL,
> +					     level);
> +	*level = device->brightness->curr;
> +	return AE_OK;
>  }
>  
>  static int
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 


-- 
Ryan May
Graduate Research Assistant
School of Meteorology
University of Oklahoma
