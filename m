From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] ACPI video: print out a warning message when duplicate
 video bus devices under the same VGA controller are detected
Date: Wed, 25 Nov 2009 16:39:02 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0911251638220.3950@localhost.localdomain>
References: <1259140608.10510.62.camel@rzhang1-desktop>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:42091 "EHLO
	vms173001.mailsrvcs.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759341AbZKYVjG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 25 Nov 2009 16:39:06 -0500
Received: from localhost.localdomain ([unknown] [74.104.151.18])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0KTO005G4PH3N021@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 25 Nov 2009 15:39:12 -0600 (CST)
In-reply-to: <1259140608.10510.62.camel@rzhang1-desktop>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Wed, 25 Nov 2009, Zhang Rui wrote:

> 
> Some buggy BIOS exports multiple ACPI video bus devices for the same
> VGA controller, and multiple backlight control methods as well.
> This may mess up the ACPI video backlight control.
> http://bugzilla.kernel.org/show_bug.cgi?id=13577
> 
> We should at least send out a warning message in this case.
> 
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  drivers/acpi/video.c |   24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> Index: linux-2.6/drivers/acpi/video.c
> ===================================================================
> --- linux-2.6.orig/drivers/acpi/video.c
> +++ linux-2.6/drivers/acpi/video.c
> @@ -2233,12 +2233,36 @@ static int acpi_video_resume(struct acpi
>  	return AE_OK;
>  }
>  
> +static acpi_status
> +acpi_video_bus_match(acpi_handle handle, u32 level, void *context,
> +			void **return_value)
> +{
> +	struct acpi_device *device = context;
> +	struct acpi_device *sibling;
> +	int result;
> +
> +	if (handle == device->handle)
> +		return AE_CTRL_TERMINATE;
> +
> +	result = acpi_bus_get_device(handle, &sibling);
> +	if (result)
> +		return AE_OK;
> +
> +	if (!strcmp(acpi_device_name(sibling), ACPI_VIDEO_BUS_NAME))
> +		printk(KERN_WARNING FW_BUG "Duplicate ACPI video bus "
> +				"devices for the same VGA controller\n");

what is somebody supposed to _do_ when they see this message?

thanks,
-Len
